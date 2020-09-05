<?php
/**
 * @file Config.php
 * @brief 配置参数
 * @author jellypa
 * @date 2017-08-08
 * @version 3.8.1
 */
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
    public function edit()
    {
		$post = post();
		unset($post['file']);
		if($this->model->configEdit($post)){
			$this->log('company', "[配置参数]编辑");
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];		
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }
    public function getData()
    {
		$data = $this->model->getData();
		if(!empty($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
				'data' => $data,
			];		
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }
 
}