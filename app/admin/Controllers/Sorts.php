<?php
namespace App\Controllers;
use \App\Models\SortsModel;
use \App\Models\ModelModel;
use \App\Models\AreaModel;
use \App\Models\FileModel;

class Sorts extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SortsModel();
        $this->modelModel = new ModelModel();
        $this->areaModel = new AreaModel();
        $this->FileModel = new FileModel();
    }
    public function index()
    {
		$sortsList = $this->model->getList();
		$modelList = $this->modelModel->getList();
		$areaList = $this->areaModel->getList();
		$template_file = $this->FileModel->getTemplateList();
		$data = [
			'list' => $sortsList,
			'modelList' => $modelList,
			'areaList' => $areaList,
			'template_file' => $template_file,
		];
        echo view('sorts.html', $data);
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
		if(!$post['name'] || is_null($post['pid']) || !$post['urlname'] || !$post['model_id']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			exit(json_encode($rdata));
		}
		$data = $post;
		// 判断栏目名称是否已存在
		$check = $this->model->checkEdit($data);
		if(!$post['id']){
			if(count($check)>0){
				$rdata = [
					"code" => 0,
					"msg" => "该栏目已存在",
				];
				exit(json_encode($rdata));	
			}
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			if(count($check)>0 && $check[0]['id']!=$post['id']){
				$rdata = [
					"code" => 0,
					"msg" => "该栏目已存在",
				];
				exit(json_encode($rdata));	
			}
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "编辑成功",
				"url" => '/'.ADMINNAME.'/sorts/index/',
			];
			exit(json_encode($rdata));				
		}else{
			$rdata = [
				"code" => 2,
				"msg" => "操作失败，请重试",
			];
			exit(json_encode($rdata));	
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
    public function getValues($model_id){
    	$values = $this->modelModel->getValues($model_id);
    	exit(json_encode($values));
    }























}
