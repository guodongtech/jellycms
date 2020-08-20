<?php
namespace App\Controllers;
use \App\Models\ModelModel;
use CodeIgniter\CLI\CLI;
use \App\Models\FileModel;
class Model extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new ModelModel();
		$this->FileModel = new FileModel();
    }

    public function index()
    {
		$template_file = $this->FileModel->getTemplateList();
		$data['template_file'] = $template_file;
        return view('model.html', $data);
    }
	//ajax列表
    public function getList()
    {
		$list = $this->model->getList();
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		return json_encode($data);
    }

  	//添加 编辑都在此处处理
    public function edit()
    {
		$post = post();
		if(!$post['name'] || !$post['type'] || !$post['urlname']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		// 校验模型是否已存在
		$check = $this->model->checkEdit($data);
		if(!$data['id']){
			if(count($check)>0){
				$rdata = [
					"code" => 0,
					"msg" => "该模型已存在",
				];
				return json_encode($rdata);	
			}
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			if(count($check)>0 && $check[0]['id']!=$data['id']){
				$rdata = [
					"code" => 0,
					"msg" => "该模型已存在",
				];
				return json_encode($rdata);	
			}
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$this->log("model", '[模型管理]编辑/添加:'."[ID:".$post['id']."]");
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
			return json_encode($rdata);			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
			return json_encode($rdata);
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
			return json_encode($rdata);
		}
		// 内置模型禁止删除
		$check = $this->model->getValues($id);
		if($check['issystem'] == 1){
			$rdata = [
				"code" => 0,
				"msg" => "内置模型禁止删除",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		if($this->model->edit($data)){
			$this->log("model", '[模型管理]删除:'."[ID:".$id."]");
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
	//状态
    public function switch()
    {
		$post = post();
		$allowSwitch = ['status'];
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
			$this->log("model", '[模型管理]修改状态:'."[ID:".$post['id']."]");
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