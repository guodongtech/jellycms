<?php namespace App\Controllers;
//use  \App\Models\DevelopersModel;

class Manual extends BaseController
{    
	public function __construct()
	{
		//$this->model = new DevelopersModel();
	}
	public function index()
	{
		Header("Location: /manual", true, 301);
	}
}
