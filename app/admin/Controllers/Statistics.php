<?php
namespace App\Controllers;
use \App\Models\StatisticsModel;

class Statistics extends BaseController
{
	private $model;
    public function __construct()
    {
        $this->model = new StatisticsModel();
    }
    // pv
	public function todayVisit(){
		$data = $this->model->todayVisit();
		return json_encode($data);
	}
	// 浏览器分布
	public function allBrowser(){
		$data = $this->model->allBrowser();
		return json_encode($data);
	}
}