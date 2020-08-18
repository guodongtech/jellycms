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
		header('Content-Type: text/html;charset=utf-8');
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']); // *代表允许任何网址请求
		header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
		header('Access-Control-Allow-Credentials: true'); // 设置是否允许发送 cookies
		header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept-Encoding,X-Requested-with, Origin'); // 设置允许自定义请求头的字段
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
