<?php
namespace App\Controllers;
use \App\Models\HotModel;

class Hot extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new HotModel();
    }
    public function getRobots()
    {
		$get = $this->request->getGet();
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$res = $this->model->getRobots($page, $limit, $this->session->area_id);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $res['total'],
			"data" => $res['list'],
		];
		return json_encode($data);
    }
	//获取列表
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
    

}