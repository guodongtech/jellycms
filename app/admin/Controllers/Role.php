<?php
namespace App\Controllers;
use \App\Models\RoleModel;
use \App\Models\AuthModel;
use \App\Models\AreaModel;
class Role extends BaseController
{

    private $blank;

    private $model;

    public function __construct()
    {
        $this->model = new RoleModel();
        $this->authModel = new AuthModel();
        $this->areaModel = new AreaModel();
    }

    // 角色列表
    public function index()
    {
		$result = $this->model->getList();
		$authResult = $this->authModel->getList();
		$areaResult = $this->areaModel->getList();
		$data = [
			'list' => $result,
			'authList' => $authResult,
			'areaList' => $areaResult,
		];
        echo view('html/role.html', $data);
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
		if(!$post['name'] || !count($post['rules_id']) || !$post['areas_id']){
			success("操作失w败");exit;
		}
		foreach($post['rules_id'] as $key=>$value){
			$post['rules_id'][$key] = (int)$value;
		}
		$post['rules_id'] = json_encode($post['rules_id']);
		foreach($post['areas_id'] as $key=>$value){
			$post['areas_id'][$key] = (int)$value;
		}
		$post['areas_id'] = json_encode($post['areas_id']);
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/role/index/');				
		}else{
			success("操作失败");
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