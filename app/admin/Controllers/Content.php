<?php
namespace App\Controllers;
use \App\Models\ContentModel;
use \App\Models\SortsModel;

class Content extends BaseController
{

    private $model;
    public function __construct()
    {
        $this->model = new ContentModel();
        $this->sortsModel = new SortsModel();
    }

    public function index($model_id)
    {
		$sorts = $this->sortsModel->getSelectByModelId($model_id);
		$data['sorts'] = $sorts;
		//获取模型名
		$modelRes = $this->model->getModelName($model_id);
		if(count($modelRes)){
			$data['model_name'] = $modelRes['name'];
		}
		$data['model_id'] = $model_id;
		//单页类模型使用模板
		if($data['type'] == 1){
			return view('single.html', $data);
		}else{
			//列表页类模型使用模板
			return view('content.html', $data);
		} 
    }
    public function getList($model_id)
    {
		$get = $this->request->getGet();
		$keyword = $get['keyword'];
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$res = $this->model->getList($keyword, $model_id, $page, $limit, $this->session->area_id);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $res['total'],
			"data" => $res['list'],
		];
		return json_encode($data);
    }
    public function getListBySortsId()
    {
		$get = $this->request->getGet();
		$keyword = $get['keyword'];
		$sorts = $get['sorts'];
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$res = $this->model->getListBySortsId($keyword, $sorts, $page, $limit, $this->session->area_id);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $res['total'],
			"data" => $res['list'],
		];
		return json_encode($data);
    }
	//内容页修改
    public function contentEdit($model_id, $id)
    {
		$sorts = $this->sortsModel->getSelectByModelId($model_id);
		
		$data =[
			'model_id'=>$model_id,
			'id'=>$id,
			'sorts'=>$sorts,
		];
		//获取模型名
		$modelRes = $this->model->getModelName($model_id);
		$data['model_name'] = $modelRes['name'];
		$data['modelfields'] = $this->model->getModelFields($model_id);
        return view('content_edit.html', $data);
    }
	//内容页修改
    public function getContent()
    {	
		$id = post('id');
		$content = $this->model->getContent($id);
		$data =[
			"code" => 1,
			"msg" => "读取成功",
			'content'=>$content,
		];
 
		return json_encode($data);
    }

	public function saveContent(){
		//获取表单值
		$post = Post();
		//验证;
		if(!$post['title'] || empty($post['sorts_id'])){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		unset($post['file']); //去掉layui加的东西
		$data = $post;
		//扩展字段数据
		$extendData = array();
		//读模型扩展字段
		$resExtend = $this->model->getContentExtendBySortsId($post['sorts_id']);
		foreach($resExtend as $key=>$value){
			//扩展字段二维数组
			$extendData[$key]['modelfield_id'] = $value['id'];
			$extendData[$key]['content_id'] = $data['id'];
			$extendData[$key]['value'] = is_array($data[$value['name']])?implode(',', $data[$value['name']]):$data[$value['name']];
			unset($data[$value['name']]); //从表单数据里删除扩展字段
		}
		if(!$data['id']){
			$data['create_user'] = $this->session->id;
			$data['area_id'] = $this->session->area_id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			$data['area_id'] = $this->session->area_id;
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
			$id = $data['id']?$data['id']:$this->db->insertID();
			$modelResult = $this->model->getModelId($id);
			if(!$data['id']){
				//批量插入扩展字段值
				foreach($extendData as $key=>$value){
					$extendData[$key]['content_id'] = $id; //重新赋值
				}
				$this->model->insertExtendBatch($extendData);//批量添加数据
			}else{
				//批量更新扩展字段值
				$this->model->updateExtendBatch($extendData);//批量更新数据
			}
			success("操作成功", '/'.ADMINNAME.'/content/index/'.$modelResult['model_id']);		
		}else{
			//return redirect()->back()->withInput();
		}
	}
	public function move(){
		$ids = post('ids');
		$sorts_id = post('sorts_id');
		$data['sorts_id'] = $sorts_id;
		$success = 0;
		foreach($ids as $key=>$value){
			$data['id'] = $value;
			if($this->model->edit($data)){
				$success++;
			}
		}
		if(count($ids) == $success){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
	}
	
	public function copy(){
		$ids = post('ids');
		$sorts_id = post('sorts_id');
		$data['sorts_id'] = $sorts_id;
		$success = 0;
		foreach($ids as $key=>$value){
			//复制记录
			$content = $this->model->getCopyContent($value);
			unset($content['id']);//释放ID，添加记录
			$content['sorts_id'] = $sorts_id;
			if($this->model->edit($content)){
				$success++;
			}
			$insertID = $this->db->insertID();
			//复制扩展字段
			$contentExtend = $this->model->getContentExtend($value);
			foreach($contentExtend as $k=>$v){
				$contentExtend[$k]['content_id'] = $insertID;
				unset($contentExtend[$k]['id']);
			}
			$this->model->insertExtendBatch($contentExtend);//批量添加数据
		}
		if(count($ids) == $success){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
	}
	public function batchdel(){
		$ids = post('ids');
		$success = 0;
		foreach($ids as $key=>$value){
			$data['id'] = $value;
			$data['deleted'] = 1;
			if($this->model->edit($data)){
				$success++;
			}
		}
		if(count($ids) == $success){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
	}
	//删除操作
    public function del()
    {
		$id = post('id');
		if(!$id){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];			
		}else{
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];			
		}
		return json_encode($rdata);		
    }
	
	//编辑字段值
    public function changeValue()
    {
		$post = post();
		if(!$post['id'] || !$post['field'] || !$post['value']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['field'] => $post['value'],
		];
		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['status', 'top', 'recommend', 'headline'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['switchName'] => (int)$post['switchValue'],
		];
		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }

}