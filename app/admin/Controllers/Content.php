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
		//获取模型名
		$modelRes = $this->model->getModelName($model_id);
		if(count($modelRes)){
			$data['model_name'] = $modelRes['name'];
		}
		$data['model_id'] = $model_id;
        echo view('html/content.html', $data);
    }
    public function getList($model_id)
    {
		$list = $this->model->getList($model_id);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		echo json_encode($data);
    }
	//内容页修改
    public function contentEdit($model_id, $id)
    {	


		$sorts = $this->sortsModel->getSelect();
		$data =[
			'model_id'=>$model_id,
			'id'=>$id,
			'sorts'=>$sorts,
		];
		//获取模型名
		$modelRes = $this->model->getModelName($model_id);
		if(count($modelRes)){
			$data['model_name'] = $modelRes['name'];
		}
        echo view('html/content_edit.html', $data);
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

		echo json_encode($data);
    }
	
	
	//内容页添加/修改
    public function contentAdd($model_id)
    {	
		$sorts = $this->sortsModel->getSelectByModelId($model_id);
		$data =[
			'model_id'=>$model_id,
			'sorts'=>$sorts,
		];
		//获取模型名
		$modelRes = $this->model->getModelName($model_id);
		if(count($modelRes)){
			$data['model_name'] = $modelRes['name'];
		}
        echo view('html/content_edit.html', $data);
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
			echo json_encode($rdata);
			exit;
		}
		$data = $post;
		//LAYUI问题处理
		$data['istop'] = $data['istop']?$data['istop']:0;
		$data['isrecommend'] = $data['isrecommend']?$data['isrecommend']:0;
		$data['isheadline'] = $data['isheadline']?$data['isheadline']:0;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
			$id = $post['id']?$post['id']:$this->db->insertID();
			$modelResult = $this->model->getModelId($id);
			success("操作成功", '/'.ADMINNAME.'/content/index/'.$modelResult['model_id']);		
		}else{
			//return redirect()->back()->withInput();
		}
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
			echo json_encode($rdata);
			exit;
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
		echo json_encode($rdata);		
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['status', 'istop', 'isrecommend', 'isheadline'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			echo json_encode($rdata);
			exit;
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
		echo json_encode($rdata);
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}