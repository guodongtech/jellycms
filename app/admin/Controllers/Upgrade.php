<?php
/**
 * @file Upgrade.php
 * @brief 在线更新
 * @author jellypa
 * @date 2020-09-02
 * @version 3.8.1
 */
namespace App\Controllers;
use \App\Models\SysLogModel;
use \config;
class Upgrade extends BaseController
{
	private $upgradeFolder;
	private $prefix;
    public function __construct()
    {
		$this->upgradeFolder = WRITEPATH.'upgrade/'.date('Ymd').'/';
        $config = new \Config\Config();
		$this->prefix = $config->database['DBPrefix'];
    }
    public function index()
    {
        return view('upgrade.html');
    }
    public function getList()
    {
		$serverResult = $this->getUpgradeDetail();
		return  $serverResult;
    }
    //获取官方更新数据 
    public function getUpgradeDetail(){
		$version = $this->currentVersion();
		$url = 'http://www.jellycms.cn/index.php/upgrade/check/'.$version;
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
            $config = new \Config\Config();
            // 从配置中取版本号
            $version = $config->version;
            // 创建目录
            mkdir($versionPath,0744,true);
			// 写入版本文件
            write_file($versionPath.'version_'.mt_rand().'.txt', $version);//创建新的版本文件 用随机数防止恶意请求
            return $version;
		}
		return file_get_contents($versionFile); 
	}
	//权限检测 只设置/runtime/upgrade/ 目录的读写权限 0744 没有目录则创建
	public function checkAuth(){
		$backupPath = $this->upgradeFolder;
		if(!is_dir($backupPath)){
			mkdir($backupPath,0744,true);
		}else{
			chmod($backupPath,0744);
		}
		$rdata = [
			"code" => 1,
			"msg" => "已经是最新版本",
		];
		return json_encode($rdata);
	}
	
	public function download(){
		$serverResult = $this->getUpgradeDetail();
		$result = json_decode($serverResult, true);
		$url = $result['download'];
		$filePath = $this->upgradeFolder.$result['name'].'.zip';
		//初始化
		$curl = curl_init();
		//设置抓取的url
		curl_setopt($curl, CURLOPT_URL, $url);
		//打开文件描述符
		$fp = fopen($filePath, 'w+');
		curl_setopt($curl, CURLOPT_FILE, $fp);
		//执行命令
		curl_exec($curl);
		//关闭URL请求
		curl_close($curl);
		//关闭文件描述符
		fclose($fp);
		if(is_file($filePath) && md5_file($filePath) == $result['md5']){
			$rdata = [
				"code" => 1,
				"msg" => "下载完成",
			];			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "下载失败",
			];
		}
		return json_encode($rdata);
	}
	//备份文件
	public function backup(){
		$post = post();
		$filesArray = $post['data'];
		$serverResult = $this->getUpgradeDetail();
		$result = json_decode($serverResult, true);
		//要备份的文件不在更新列表里，返回错误
		$p = array_column($post['data'], 'name');
		$sr = array_column($result['data'], 'name');
		foreach($p as $key=>$value){
			if(!in_array($value, $sr)){
				$rdata = [
					"code" => 0,
					"msg" => "非法操作",
				];
				return json_encode($rdata);
			}
		}
		
		foreach($filesArray as $key=>$value){
			$file = $value['name'];
			//文件存在则备份 不存在则忽略
			if(is_file(FCPATH.$file)){
				if(!is_dir(dirname($this->upgradeFolder.'backup/'.$file))){
					mkdir(dirname($this->upgradeFolder.'backup/'.$file),0744,true);
				}
				if(!copy(FCPATH.$file, $this->upgradeFolder.'backup/'.$file)){
					$rdata = [
						"code" => 0,
						"msg" => "备份失败:".FCPATH.$file,
					];
					return json_encode($rdata);
				}
			}
		}
		$rdata = [
			"code" => 1,
			"msg" => "备份成功",
		];
		return json_encode($rdata);
	}
	//更新
	public function upgrade(){
		$post = post();
		$filesArray = $post['data'];
		$serverResult = $this->getUpgradeDetail();
		$result = json_decode($serverResult, true);
		//要备份的文件不在更新列表里，返回错误
		$p = array_column($post['data'], 'name');
		$sr = array_column($result['data'], 'name');
		//直接读取压缩包
		$zip = zip_open($this->upgradeFolder.$result['name'].'.zip');
		while($zipfile=zip_read($zip)){
			$fileName = zip_entry_name($zipfile);
            if(!in_array($fileName, $p) && strpos($fileName, '.') && strpos($fileName, '.sql') == false){
                continue;
            }
			//文件夹不存在，创建文件夹权限 0755
			if(!is_dir(dirname(FCPATH.$fileName))){
				mkdir(dirname(FCPATH.$fileName), 0755,true);
			}
			$size = zip_entry_filesize($zipfile); //文件真实尺寸  配合zip_entry_read
			//排除.sql和目录
			if(strpos($fileName, '.') && strpos($fileName, '.sql') == false){
				$contents = zip_entry_read($zipfile,$size);//取内容
				//echo md5($contents)."\n";
				$fp = fopen (FCPATH.$fileName, 'w+');
				fwrite($fp, $contents);
				fclose($fp);
				//echo md5(file_get_contents(FCPATH.$fileName))."\n";  //内容MD5一致
			}else{
				//执行数据库升级
				$execute_sql = zip_entry_read($zipfile,$size);
				$sqlFormat = $this->sql_split($execute_sql, $this->prefix);
				try {
	                $counts = count($sqlFormat);
	                for ($i = 0; $i < $counts; $i++) {
	                    $sql = trim($sqlFormat[$i]);

	                    if (stristr($sql, 'CREATE TABLE')) {
	                        $this->db->query($sql);
	                    } else {
	                        if(trim($sql) == ''){
	                        	continue;
	                        }
	                        $this->db->query($sql);
	                    }
	                }
	            } catch (\Exception $e) {
	                return json_encode(['code' => -2, 'msg' => "数据库执行中途失败，请查看官方解决教程"]);
	            }
			}
			zip_entry_close($zipfile);
		}
		zip_close($zip);
		//升级成功，记录当前版本号
		$versionPath = WRITEPATH.'version/';
		helper('filesystem');
		delete_files($versionPath);//删除版本记录文件夹里的所有文件
		write_file($versionPath.'version_'.mt_rand().'.txt', $result['name']);//创建新的版本文件 用随机数防止恶意请求
		$this->log("upgrade", "[系统升级]");
		$rdata = [
			"code" => 1,
			"msg" => "升级成功",
		];
		return json_encode($rdata);
	}
	//数据库升级
    private function sql_split($sql, $tablepre) {

        if ($tablepre != "gd_")
            $sql = str_replace("`gd_", '`'.$tablepre, $sql);
              
        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }
	
}