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
		$List = $this->model->getSelect();
		$data = [
			'List' =>$List,
		];
        echo view('auth_index.html', $data);
    }
    public function group()
    {
        echo view('auth_group.html');
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
    public function getGroupList()
    {
		$list = $this->model->getGroupList();
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
		if(!$post['name'] || !$post['controller']|| !$post['action']){
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
			// 当前控制器 方法是否已录入
			if($this->model->checkAdd($data)){
				exit(json_encode(['code'=>0,'msg'=>'该权限已录入，请勿重复操作']));
			}
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			exit(json_encode(['code'=>1,'msg'=>'操作成功','url'=>'/'.ADMINNAME.'/auth/index/']));			
		}else{
			exit(json_encode(['code'=>2,'msg'=>'操作失败，请重试！','url'=>'/'.ADMINNAME.'/auth/index/']));
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
		$child = $this->model->getChild($id);
		if(count($child)>0){
			$rdata = [
				"code" => 0,
				"msg" => "有子权限，无法删除",
			];
			echo json_encode($rdata);
			exit;
		}
		$data = [
			'id' => $id,
			'status' => 0,
		];
		$result = $this->model->edit($data);
		$rdata = [
			"code" => 1,
			"msg" => "操作成功",
		];
		echo json_encode($rdata);		
    }
    // 筛选出最底层节点 修改时默认选中
    public function rulesDeal(){
    	$rules_id = json_decode(post('rules_id'));
    	$result = $this->model->rulesDeal($rules_id);
    	exit(json_encode($result));
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}