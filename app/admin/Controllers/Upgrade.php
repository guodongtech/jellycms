<?php
namespace App\Controllers;
use \App\Models\SysLogModel;
use \config;
class Upgrade extends BaseController
{
 
    public function __construct()
    {
        $config = new \Config\Config();
    }
    public function index()
    {
        return view('upgrade.html');
    }
    public function getList()
    {
       return  $serverResult = $this->getUpgradeDetail();
		///return json_decode($serverResult, true);
    }
    //获取官方更新数据 
    public function getUpgradeDetail(){
		$version = $this->currentVersion();
		$url = 'https://upgrade.jellycms.cn/index.php/upgrade/check/'.$version;
	   $header = array(
		   'Accept: application/json',
		);
		$curl = curl_init();
		//设置抓取的url
		curl_setopt($curl, CURLOPT_URL, $url);
		//设置头文件的信息作为数据流输出
		curl_setopt($curl, CURLOPT_HEADER, 0);
		// 超时设置,以秒为单位
		curl_setopt($curl, CURLOPT_TIMEOUT, 1);
	 
		// 超时设置，以毫秒为单位
		 curl_setopt($curl, CURLOPT_TIMEOUT_MS, 5000);
	 
		// 设置请求头
		curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
		//设置获取的信息以文件流的形式返回，而不是直接输出。
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
		//执行命令
		$result = curl_exec($curl);
	 
		// 显示错误信息
		if (curl_error($curl)) {
			print "Error: " . curl_error($curl);
		} else {
			curl_close($curl);
		}
		return $result;
    }
	//获取当前版本号
	public function currentVersion(){
		$versionPath = WRITEPATH.'version/';//此文件夹一定要可写可读权限。
		helper('filesystem');
		$verionFiles = get_dir_file_info($versionPath);
		foreach($verionFiles as $key=>$value){
			if(strpos($key, 'version_') !==false){
				$versionFile = $value['server_path'];
			}
		}
		if(!file_exists($versionFile)){
			return false;
		}
		return file_get_contents($versionFile); 
	}

}