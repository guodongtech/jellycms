<?php
namespace App\Controllers;
use \App\Models\ModelFieldModel;
use \App\Models\ModelModel;

class ModelField extends BaseController
{

    private $model;
    private $modelModel;

    public function __construct()
    {
        $this->model = new ModelFieldModel();
        $this->modelModel = new ModelModel();
    }

    public function index()
    {
		$modelList = $this->modelModel->getList();
		$data = [
			"modelList" => $modelList,
		];
         echo view('modelfield.html', $data);
    }
	//获取列表
    public function getList()
    {
		$list = $this->model->getList();

		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		echo json_encode($data);
    }
	//添加 编辑都在此处处理
    public function edit()
    {
		$post = post();
		if(!$post['name'] || !$post['model_id']|| !$post['type'] || !$post['description']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			echo json_encode($rdata);
			exit;
		}
		
		$data = $post;
		unset($post['content']);
		// 校验 输入规则
		$input_check = $this->model->inputRules($data);
		if($input_check !== true){
			exit($input_check);
		}
		// 校验 name model_id 是否联合唯一
		$check = $this->model->checkEdit($data);
		if(!$post['id']){
			if(count($check)>0){
				$rdata = [
					"code" => 0,
					"msg" => "此模型下已存在该字段",
				];
				echo json_encode($rdata);
				exit;
			}
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			if(count($check)>0 && $check[0]['id'] != $post['id']){
				$rdata = [
					"code" => 0,
					"msg" => "此模型下已存在该字段",
				];
				echo json_encode($rdata);
				exit;
			}
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
			echo json_encode($rdata);			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
			echo json_encode($rdata);
		}
    }
	//删除操作 调用model类的save
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

  
}