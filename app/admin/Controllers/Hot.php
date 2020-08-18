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
		$list = $this->model->getRobots();
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
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