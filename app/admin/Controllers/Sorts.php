<?php
namespace App\Controllers;
use \App\Models\SortsModel;
use \App\Models\ModelModel;

class Sorts extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SortsModel();
        $this->modelModel = new ModelModel();
    }
    public function index()
    {
		$sortsList = $this->model->getList();
		$modelList = $this->modelModel->getList();
		$data = [
			'list' => $sortsList,
			'modelList' => $modelList,
		];
        echo view('html/sorts.html', $data);
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
		if(!$post['name'] || is_null($post['pid'])){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			exit(json_encode($rdata));
		}
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/sorts/index/');				
		}else{
			error("操作失败", '/'.ADMINNAME.'/sorts/index/');
		}
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
		$Child = $this->model->getChild($id);
		if(count($Child)>0){
			$rdata = [
				"code" => 0,
				"msg" => "有子菜单，无法删除",
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
		$allowSwitch = ['status'];
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
