<?php namespace App\Controllers;
//use  \App\Models\DevelopersModel;

class Manual extends BaseController
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
	public function index()
	{
		return view('manual.html');
	}
}
