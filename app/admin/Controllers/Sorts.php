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
		if(!$post['name'] || !$post['model_id']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			exit(json_encode($rdata));
		}
		$data = $post;
		
		//单个和批量都按批量处理
		$names = explode(',',$data['name']);
		unset($data['name']);
		if(!$data['id']){
			//有栏目存在，直接返回错误信息
			foreach($names as $key=>$value){
				// 判断栏目名称是否已存在
				$check = $this->model->checkName($value,$this->session->area_id);
				if(!empty($check)){
					$rdata = [
						"code" => 0,
						"msg" => $value."已存在",
					];
					return json_encode($rdata);					
				}
			}
		}
		$success = 0;
		$error = 0;
		$errorName = array();
		foreach($names as $key=>$value){
			$data['name'] = $value;
			if(!$data['id']){
				$data['create_user'] = $this->session->id;
				$data['area_id'] = $this->session->area_id;
				$data['create_time'] = date('Y-m-d H:i:s',time());
				$data['status'] = 1;
			}else{
				$data['update_user'] = $this->session->id;
				$data['update_time'] = date('Y-m-d H:i:s',time());
			}

			if($this->model->edit($data)){
				$success++;
			}else{
				$error++;
				$errorName[] = $data['name'];
			}
		}
		if(!$error){
			$rdata = [
				"code" => 1,
				"msg" => "操作完成",
			];
			return json_encode($rdata);				
		}else{
			$rdata = [
				"code" => 0,
				"msg" => implode(',', $errorName)."操作失败",
			];
			return json_encode($rdata);	
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
			return json_encode($rdata);
		}
		$Child = $this->model->getChild($id);
		if(count($Child)>0){
			$rdata = [
				"code" => 0,
				"msg" => "有子菜单，无法删除",
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
    public function getValues(){
		$post = post();
    	$values = $this->modelModel->getValues($post['model_id']);
    	return json_encode($values);
    }























}
