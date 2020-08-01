<?php
namespace App\Controllers;
use  \App\Models\ConfigModel;
class Config extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new ConfigModel();
    }
    // 应用配置列表
    public function index()
    {
		return view('config.html');
    }

 
}