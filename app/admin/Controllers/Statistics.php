<?php
/**
 * @file Statistics.php
 * @brief 数据统计
 * @author 无双
 * @date 2020-06-02
 * @version 3.8.1
 */
namespace App\Controllers;
use \App\Models\StatisticsModel;
use CodeIgniter;
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
	// 搜索引擎
	public function allSpider(){
		$data = $this->model->allSpider();
		return json_encode($data);
	}
	// ip分布
	public function allIp(){
		$data = $this->model->allIp();
		return json_encode($data);
	}

}