<?php namespace App\Controllers;
use  \App\Models\UpgradeModel;

class Upgrade extends BaseController
{    
	private $model;
    public function __construct()
    {
		$this->downDomain = 'http://down.jellycms.cn/';
		$this->model = new UpgradeModel();
    }
	public function check($version){
		$max = $this->model->getMax();
		if($max['name'] == $version){
			$rdata = [
				"code" => 0,
				"msg" => "已经是最新版本",
			];
			return json_encode($rdata);
		}
		$result = $this->model->checkAvailableMax($version);
		//无可用更新 但返回最新版本
		if(empty($result)){
			$rdata = [
				"code" => 0,
				"msg" => "无可用更新,当前最新版本号：version".$max['name']."。如有疑问请联系JellyCMS官方。",
			];
			return json_encode($rdata);
		}
		
		$filePath = str_replace('\\', '/',$result['zipfile']);
		//返回更新信息
		$rdata = [
			"code" => 0,
			"msg" => "有可用更新",
			"detail" => $result['detail'],
			"md5" => $result['md5'],
			"download" => $this->downDomain.$filePath,
		];
		return json_encode($rdata);
	}
}
