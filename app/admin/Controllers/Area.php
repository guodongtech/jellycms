<?php
namespace App\Controllers;
use \App\Models\AreaModel;

class Area extends BaseController
{

    private $count;

    private $blank;

    private $outData = array();

    private $model;

    public function __construct()
    {
        $this->model = new AreaModel();
    }

    public function index()
    {
		$areaList = $this->model->getList();
		$data = [
			'list' => $areaList,
		];
        echo view('html/area.html', $data);
		
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
	public function edit(){
		$post = $this->request->getPost();
		if(!$post['name'] || !$post['surname']){
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
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/area/index/');				
		}
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
			exit(json_encode($rdata));
        }
		$data = [
			"id" => $id,
			"deleted" =>  1,
		];
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

		echo json_encode($rdata);
    }
	
	 
	
	
	
	
}