<?php
namespace App\Controllers;
use  \App\Models\SysUserModel;
use \App\Models\RoleModel;
class SysUser extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SysUserModel();
        $this->roleModel = new RoleModel();
    }

    public function index()
    {
		$roleResult = $this->roleModel->getSelect();
		$data = [
			'roleList' => $roleResult,
		];
        return view('sysuser.html', $data);
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
		// 校验密码
		if($post['password'] != $post['repassword'] && $post['password'] != md5($post['repassword'])){
 
			return json_encode(['code'=>0,'msg'=>'密码不一致']);	
		}
		if($post['password'] == $post['repassword']){
			$post['password'] = md5($post['password']);
		}
		if(!$post['name'] || !$post['role_id'] || !$post['realname']){
			return json_encode(['code'=>0,'msg'=>'参数不足']);
		}
		unset($post['repassword']);
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			// 校验用户名是否存在
			if($this->model->checkUser($data['name'])){
				return json_encode(['code'=>0,'msg'=>'该用户已存在，请勿重复添加']);	
			}
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			return json_encode(['code'=>1,'msg'=>'添加成功','url'=>'/'.ADMINNAME.'/sysuser/index/']);		
		}else{
			return json_encode(['code'=>2,'msg'=>'添加失败','url'=>'/'.ADMINNAME.'/sysuser/index/']);		
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
		$check = $this->model->checkUserById($id);
		if($check['issystem']){
			$rdata = [
				"code" => 0,
				"msg" => "系统用户，不可删除",
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