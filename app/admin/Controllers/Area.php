<?php
namespace App\Controllers;
use \App\Models\AreaModel;
use \App\Models\FileModel;
class Area extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new AreaModel();
		$this->FileModel = new FileModel();
    }

    public function index()
    {
		$areaList = $this->model->getList();
		$themeList = $this->FileModel->getThemeList();

		$data = [
			'list' => $areaList,
			"themeList" => $themeList,
		];
        return view('area.html', $data);
		
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
	public function edit(){
		$post = $this->request->getPost();
		if(!$post['name'] || !$post['surname']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		if($data['default']){
			//设置所有区域 default=0
			$this->model->setDefault();			
		}else{
			//当前区域为默认区域，不能设置成非默认
			if(!empty($this->model->getThisArea($post['id']))){
				error("失败:必须有一个默认区域", '/'.ADMINNAME.'/area/index/');	
			}	
		}
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/area/index/');				
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
    //删除
    public function del()
    {
		$id = $this->request->getPost('id');
        if (!$id ) {
			$rdata = [
				"code" => 0,
				"msg" => "参数错误",
			];
			return json_encode($rdata);
        }
		$data = [
			"id" => $id,
			"deleted" =>  1,
		];
		//当前区域为默认区域，不能设置成非默认
		if(!empty($this->model->getThisArea($id))){
			$rdata = [
				"code" => 0,
				"msg" => "失败:默认区域不能删除",
			];
			return json_encode($rdata);
		}	

        if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "删除成功",
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
		$allowSwitch = ['default'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		
		//必须有一个默认区域
		if($post['switchValue']){
			//设置所有区域 default=0
			$this->model->setDefault();			
		}else{
			//当前区域为默认区域，不能设置成非默认
			if(!empty($this->model->getThisArea($post['id']))){
				$rdata = [
					"code" => 0,
					"msg" => "失败:必须有一个默认区域",
				];
				return json_encode($rdata);
			}	
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