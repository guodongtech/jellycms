<?php namespace App\Controllers;
use  \App\Models\UpgradeModel;
class Upgrade extends BaseController
{    
	private $model;
    public function __construct()
    {
		$this->downDomain = 'http://update.jellycms.cn/';
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
		//无可用更新 但返回最新版本提醒
		if(empty($result)){
			$rdata = [
				"code" => 0,
				"msg" => "无可用更新,当前最新版本号：version".$max['name']."。如有疑问请联系JellyCMS官方。",
			];
			return json_encode($rdata);
		}
		
		$filePath = str_replace('\\', '/',$result['zipfile']);
		$detailArray = explode("\n", $result['detail']);
		foreach($detailArray as $key=>$value){
			$detailArray[$key] = explode(',', $value);
			$detailArray[$key]['name'] = $detailArray[$key][0];
			unset($detailArray[$key][0]);
			$detailArray[$key]['type'] = $detailArray[$key][1];
			unset($detailArray[$key][1]);
			$detailArray[$key]['description'] = $detailArray[$key][2];
			unset($detailArray[$key][2]);
			$detailArray[$key]['datetime'] = $result['create_time'];
		}
		//print_r($detailArray);
		//返回更新信息
		$rdata = [
			"code" => 0,
			"msg" => "有可用更新",
			"data" => $detailArray,
			"count" => count($detailArray),
			"md5" => $result['md5'],
			"create_time" => $result['create_time'],
			"name" => 'v'.$result['name'],
			"description" => $result['description'],
			"download" => $this->downDomain.$filePath,
		];
		return json_encode($rdata);
	}
}
