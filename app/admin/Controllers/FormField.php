<?php
namespace App\Controllers;
use \App\Models\FormFieldModel;
use \App\Models\FormModel;

class FormField extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new FormFieldModel();
        $this->formModel = new FormModel();
    }

    public function index()
    {
		$formList = $this->formModel->getList();
		$data = [
			"formList" => $formList,
		];
         echo view('html/form_field.html', $data);
    }
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
    public function edit()
    {
		$post = post();
		if(!$post['name'] || is_null($post['form_id'])){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			echo json_encode($rdata);
			exit;
		}
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

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
				"code" => 0,
				"msg" => "操作失败",
			];
		}

		echo json_encode($rdata);		
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['must'];
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