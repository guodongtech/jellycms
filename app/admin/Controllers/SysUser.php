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
        echo view('html/sysuser.html', $data);
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
		// 校验密码
		if($post['password'] != $post['repassword'] && $post['password'] != md5($post['repassword'])){
			echo $post['password']."-".md5($post['repassword'])."-".$post['repassword'];die;
			exit(json_encode(['code'=>0,'msg'=>'密码不一致']));	
		}
		if($post['password'] == $post['repassword']){
			$post['password'] = md5($post['password']);
		}
		if(!$post['name'] || !$post['role_id'] || !$post['realname']){
			exit(json_encode(['code'=>0,'msg'=>'参数不足']));
		}
		unset($post['repassword']);
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			// 校验用户名是否存在
			if($this->model->checkUser($data)){
				exit(json_encode(['code'=>0,'msg'=>'该用户已存在，请勿重复添加']));	
			}
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			exit(json_encode(['code'=>1,'msg'=>'添加成功','url'=>'/'.ADMINNAME.'/sysuser/index/']));		
		}else{
			exit(json_encode(['code'=>2,'msg'=>'添加失败','url'=>'/'.ADMINNAME.'/sysuser/index/']));		
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