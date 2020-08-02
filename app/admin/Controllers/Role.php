<?php
namespace App\Controllers;
use \App\Models\RoleModel;
use \App\Models\AuthModel;
use \App\Models\AreaModel;
use \Config;
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
		$authResult = $this->authModel->getTreeList();
		$areaResult = $this->areaModel->getList();
		$data = [
			'list' => $result,
			'authList' => $authResult,
			'areaList' => $areaResult,
		];
		// echo $authResult;die;
        return view('role.html', $data);
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
		return json_encode($data);
    }
    public function edit()
    {
		$post = post();
		if(!$post['name'] || !$post['areas_id']){
			return json_encode(['code'=>0,'msg'=>'参数不足']);
		}
		// 校验角色是否存在
		$result = $this->model->roleCheck($post['name']);

		$data['name'] = $post['name'];
		$data['rules_id'] = $post['rules_id'];
		$data['description'] = $post['description'];
		$data['status'] = $post['status'];
		$areas_id = $post['areas_id'];
		foreach($areas_id as $key=>$value){
			$areas_id[$key] = (int)$areas_id[$key];
		}
		$data['areas_id'] = json_encode($areas_id, true);
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			if(count($result) > 0){
				return json_encode(['code'=>0,'msg'=>'该角色已存在！']);
			}
		}else{
			$data['update_user'] = $this->session->id;
			$data['id'] = $post['id'];
			$data['update_time'] = date('Y-m-d H:i:s',time());
			if(count($result) > 0 && $result[0]['id']!=$post['id']){
				return json_encode(['code'=>0,'msg'=>'该角色已存在！']);
			}
		}
		if($this->model->edit($data)){
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
	//编辑字段值
    public function changeValue()
    {
		$post = post();
		if(!$post['id'] || !$post['field'] || !$post['value']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['field'] => $post['value'],
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
		return json_encode($rdata);
    }
}