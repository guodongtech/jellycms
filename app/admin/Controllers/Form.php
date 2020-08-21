<?php
namespace App\Controllers;
use \App\Models\FormModel;

class Form extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new FormModel();
    }

    public function index()
    {
         return view('form.html');
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
		if(!$post['name'] || !$post['table_name']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		//同名检测
		$check_name = $this->model->check($post['name']);
		if($check_name && !$post['id']){
			$rdata = [
				"code" => 0,
				"msg" => $post['name'].":表单已存在",
			];
			return json_encode($rdata);
		}
		if($check_name && $post['id']>0 && $post['id']!=$check_name['id']){
			$rdata = [
				"code" => 0,
				"msg" => $post['name'].":表单已存在",
			];
			return json_encode($rdata);
		}
		//同表名检测
		$check_table = $this->model->checkTablename($post['table_name']);
		if($check_table && !$post['id']){
			$rdata = [
				"code" => 0,
				"msg" => $post['table_name'].":表名已存在",
			];
			return json_encode($rdata);
		}
		if($check_table && $post['id']>0 && $post['id']!=$check_table['id']){
			$rdata = [
				"code" => 0,
				"msg" => $post['table_name'].":表名已存在",
			];
			return json_encode($rdata);
		}
		$data = $post;
		if(!$data['id']){
			//创建表及默认表字段 create_time create_user update_time update_user ip,默认字段不在formfield表里显示
			//保护系统表，表单对应的表名必须为 prefix_form_XXX 在model里做处理
			 if(!$this->model->addFormTable($post['table_name'])){
				$rdata = [
					"code" => 0,
					"msg" => "创建失败",
				];
				return json_encode($rdata);
			 }
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			//renameTable
			 if(!$this->model->editFormTable($data['id'], $data['table_name'])){
				$rdata = [
					"code" => 0,
					"msg" => "创建失败",
				];
				return json_encode($rdata);
			 }
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$this->log('form', "[自定义表单]添加/编辑[ID:".$post['id']."]");
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
		$form = $this->model->getFormById($id);
		if(!$form['id']){
			$rdata = [
				"code" => 0,
				"msg" => "表单不存在！",
			];
			return json_encode($rdata);
		}
		if($form['issystem']){
			$rdata = [
				"code" => 0,
				"msg" => "系统表单，无法删除！",
			];
			return json_encode($rdata);
		}
		
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		if($this->model->edit($data)){
			$this->log('form', "[自定义表单]删除[ID:".$post['id']."]");
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
		$allowSwitch = ['status'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$form = $this->model->getFormById($post['id']);
		if(!$form['id']){
			$rdata = [
				"code" => 0,
				"msg" => "表单不存在！",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['switchName'] => (int)$post['switchValue'],
		];
		if($this->model->edit($data)){
			$this->log('form', "[自定义表单]修改状态[ID:".$post['id']."]");
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