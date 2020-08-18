<?php namespace App\Controllers;
//use  \App\Models\DevelopersModel;

class Push extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		//$this->model = new DevelopersModel();
	}
	public function developers()
	{	
		$list = [
			['name'=>'zhangteng', 'email'=>'314246439@qq.com', 'description'=>'加入时间：2015年3月18日'],
			['name'=>'zhaojiabin', 'email'=>'zjb888@qq.com', 'description'=>'加入时间：2016年6月15日'],
		];
		$rdata = [
			'code'=>0,
			'msg'=>0,
			"data" => $list,
		
		];
		echo json_encode($rdata);
	}
	 

}
