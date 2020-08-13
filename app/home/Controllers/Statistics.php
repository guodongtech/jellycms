<?php 
namespace App\Controllers;
use  \App\Models\StatisticsModel;

class Statistics extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		$this->model = new StatisticsModel();
	}
	public function index()
	{	
		$post = post();
		$data = [
			'ip' => $this->request->getIPAddress(),
			'os' => $this->request->getUserAgent()->getPlatform(),
			'browser' => $this->request->getUserAgent()->getBrowser(),
			'start_time' => date('Y-m-d H:i:s',time()),
		];
		$data = array_merge($data,$post);
		// return json_encode($post);
		$this->model->addData($data);
		return true;
	}
	 

}
