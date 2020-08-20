<?php
namespace App\Controllers;
use  \App\Models\AuthModel;

class Auth extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new AuthModel();
    }

    public function index()
    {
		$list = $this->model->getSelect();
		$data = [
			'list' =>$list,
		];
        return view('auth_index.html', $data);
    }
    public function group()
    {
        return view('auth_group.html');
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
    public function getGroupList()
    {
		$list = $this->model->getGroupList();
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		return json_encode($data);
    }
	//编辑字段值
    public function changeValue()
    {
		$post = post();
		if(!$post['id'] || !$post['field']){
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
			$this->log('auth', '[权限]编辑字段'.$post['field'].'为'.$post['value']."[ID:".$post['id']."]");
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
    public function edit()
    {
		$post = post();
		if(!$post['name']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
			// 当前控制器 方法是否已录入
			if($this->model->checkAdd($data)){
				return json_encode(['code'=>0,'msg'=>'该权限已录入，请勿重复操作']);
			}
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$this->log('auth', '[权限]添加/编辑:'.$data['name']."[ID:".$post['id']."]");
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
		$child = $this->model->getChild($id);
		if(count($child)>0){
			$rdata = [
				"code" => 0,
				"msg" => "有子权限，无法删除",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		$result = $this->model->edit($data);
		$this->log('auth', "[权限]删除[ID:".$id."]");
		$rdata = [
			"code" => 1,
			"msg" => "操作成功",
		];
		return json_encode($rdata);		
    }
    // 筛选出最底层节点 修改时默认选中
    public function rulesDeal(){
    	$rules_id = json_decode(post('rules_id'));
    	$result = $this->model->rulesDeal($rules_id);
    	return json_encode($result);
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}