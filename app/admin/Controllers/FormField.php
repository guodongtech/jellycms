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
		$formList = $this->formModel->getAllForm();
		$data = [
			"formList" => $formList,
		];
         return view('form_field.html', $data);
    }
    public function getList()
    {
		$get = $this->request->getGet();
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$res = $this->model->getList($page, $limit);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $res['total'],
			"data" => $res['list'],
		];
		return json_encode($data);
    }
    public function edit()
    {
		$post = post();
		if(!$post['name'] || is_null($post['form_id'])){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
				
		$check = $this->model->checkFields($data['form_id'], $data['name']);
		//添加字段，但字段物理存在，将此次操作改为修改
		if($check['id'] && !$data['id']){
			if($check['deleted']){
				$data['deleted'] = 0;
				$data['id'] = $check['id'];
			}else{
				$rdata = [
					"code" => 0,
					"msg" => "字段已存在",
				];
				return json_encode($rdata);					
			}
		}

		$fields = array(
			$data['name']       => array(
			'type'           => $data['type'],
			'constraint'     => $data['length'],
			'null'           => TRUE,
			)
		);		
		if(!$data['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());

			if(!$this->model->addField($fields, $data['form_id'])){
				$rdata = [
					"code" => 0,
					"msg" => "创建字段失败",
				];
				return json_encode($rdata);
			}
		}else{
			if(!$this->model->editField($fields, $data['form_id'])){
				$rdata = [
					"code" => 0,
					"msg" => "编辑字段失败",
				];
				return json_encode($rdata);
			}
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
		return json_encode($rdata);
    }
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
				"code" => 0,
				"msg" => "操作失败",
			];
		}

		return json_encode($rdata);		
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['required'];
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