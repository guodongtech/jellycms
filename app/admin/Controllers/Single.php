<?php
namespace App\Controllers;
use \App\Models\SingleModel;

class Single extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SingleModel();
    }

    public function index($model_id)
    {
		$modelInfo = $this->model->getModelInfo($model_id);
		$data = [
			'model_id'=>$model_id,
			'urlname'=>$modelInfo['urlname'],
		];
         return view('single.html', $data);
    }
    public function single_edit($id)
    {
		$sortInfo = $this->model->getSortInfo($id);
		$data['sortinfo'] = $sortInfo;
        return view('single_edit.html', $data);
    }
    public function getList($model_id)
    {
		$list = $this->model->getList($model_id);
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
		unset($post['file']); //移除LAYUI多余表单
		$data = $post;
		$sortInfo = $this->model->getSortInfo($data['id']);
		if(empty($sortInfo)){
			return error("分类信息不存在", '/'.ADMINNAME.'/single/index/');
		}
		if($this->model->edit($data)){
			return success("操作成功", '/'.ADMINNAME.'/single/index/');				
		}else{
			return error("操作失败", '/'.ADMINNAME.'/single/index/');
		}
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