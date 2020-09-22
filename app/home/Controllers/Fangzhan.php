<?php
/**
 * @file Fangzhan.php
 * @brief 抓取指定页面的静态资源
 * @author jellypa
 * @date 2015-01-02
 * @version 3.8.1
 */
namespace App\Controllers;
use  \App\Models\FormModel;
class Fangzhan extends BaseController
{
	public function __construct()
	{
		$this->request = \Config\Services::request();
		$this->post = $this->request->getPost();
		//$this->post['urllist'][0]['url']= "https://www.jellycms.cn/";
		//$this->post['urllist'][0]['path']='/';
		//$this->post['urllist'][0]['name']='index.html';
	}
	public function index(){
		$list = $this->getList();
		//print_r($list);
		echo json_encode($list);
	}
	//开始下载
	function download(){
		
	}
    function getUrl($url)
    {
		$urlInfo = parse_url($url);
        $headerArray = array("Content-type:application/json;", "Accept:application/json");
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
		//处理https
		if($urlInfo['scheme'] == 'https'){
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);			
		}

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		//设置userAgent
		if(isset($this->post['userAgent'])){
			curl_setopt($ch, CURLOPT_USERAGENT, $this->post['userAgent']);
		}else{
			curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1');
		}
        
        //curl_setopt($ch, CURLOPT_HTTPHEADER, $headerArray);
        $output = curl_exec($ch);
    	//echo '错误:',curl_error($ch),$output,PHP_EOL;
        curl_close($ch);
        return $output;
    }

	//获取CSS中资源 字体 背景 还可能引入了CSS 引入方式有两种@import "style.css"; /* 或者@import url(style.css)里面也可能有引号
    function getCssSrc($url)
    {
		//获取CSS中背景图片
		static $cssSrc = array();
    	$content = $this->getUrl($url);
		preg_match_all("/(?:background|background-image)(?:.*)url\((.*)\)/U", $content, $cssbg);
		foreach($cssbg[1] as $key=>$value){
			if(preg_match("/(data:)/",$value))continue;
			$value = preg_replace('/\?.*/i','',$value);//替换？及以后的字符
			$cssSrcT = str_replace('"', '', $value);
			$cssSrcT = str_replace("'", '', $cssSrcT);
			$absolutePath = $this->relativeToAbsolute($url, $cssSrcT);
			$cssSrc[] = [
				'url' => $absolutePath,
				'type' => 'cssbg',
				'original' => $cssSrcT,
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}
		
		//获取CSS中引入的CSS
		preg_match_all("/@import(?:\s+)(.*)\s/U", $content, $cssimport);
		foreach($cssimport[1] as $key=>$value){
			$cssimport[1][$key] = str_replace('"', '', $value);
			$cssimport[1][$key] = str_replace("'", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace(";", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace("url(", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace(")", '', $cssimport[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $cssimport[1][$key]);
			$cssimport[1][$key] = [
				'url' => $absolutePath,
				'type' => 'css',
				'original' => $cssimport[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
			$this->getCssSrc($absolutePath);
		}
		$cssSrc = array_merge($cssSrc, $cssimport[1]);
		$cssSrc = array_unique($cssSrc, SORT_REGULAR);
		return $cssSrc;
    }
	//相对路径转绝对路径
	function relativeToAbsolute($baseurl, $srcurl) {  
		$srcinfo = parse_url($srcurl);
		if(isset($srcinfo['scheme'])) {
			return $srcurl;
		}
		$baseinfo = parse_url($baseurl);
		if(isset($baseinfo['scheme'])) {
			$url = $baseinfo['scheme'].'://'.$baseinfo['host'];
		}else{
			$url = '//'.$baseinfo['host'];
		}
		
		if(substr($srcinfo['path'], 0, 1) == '/') {
			$path = $srcinfo['path'];
		}else{
			$path = dirname($baseinfo['path']).'/'.$srcinfo['path'];
		}
		$rst = array();
		$path_array = explode('/', $path);
		if(!$path_array[0]) {
			$rst[] = '';
		}
		foreach ($path_array AS $key => $dir) {
			if ($dir == '..') {
				if (end($rst) == '..') {
					$rst[] = '..';
				}elseif(!array_pop($rst)) {
					$rst[] = '..';
				}
			}elseif($dir && $dir != '.') {
				$rst[] = $dir;
			}
		}
		if(!end($path_array)) {
			$rst[] = '';
		}
		$url .= implode('/', $rst);
		return str_replace('\\', '/', $url);
	}
	//获取页面资源链接
	function getPageSrcUrlList($url){
		$html = $this->getUrl($url);//抓取页面
		//图片 可能存在不规则写法如资源链接未带引号 缺少空格
		preg_match_all("/<img(?:.*)src=(.*)(?:\/>|>| )/U", $html, $img);
		foreach($img[1] as $key=>$value){
			$img[1][$key] = str_replace('"', '', $value);
			$img[1][$key] = str_replace("'", '', $img[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $img[1][$key]);
			$img[1][$key] = [
				'url' => $absolutePath,
				'type' => 'img',
				'original' => $img[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}
		//js
		preg_match_all("/<script(?:.*)src=(.*)(?:\/>|>| )/U", $html, $js);
		foreach($js[1] as $key=>$value){
			if(preg_match(".baidu.",$value))continue;//排除百度代码
			$js[1][$key] = str_replace('"', '', $value);
			$js[1][$key] = str_replace("'", '', $js[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $js[1][$key]);
			$js[1][$key] = [
				'url' => $absolutePath,
				'type' => 'js',
				'original' => $js[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}
		
		//匹配css地址 可能存在不规则写法 如缺少引号 
		preg_match_all("/link(?:.*)href=(.*)(?:\/>|>| )/U", $html, $css);
		foreach($css[1] as $key=>$value){
			$css[1][$key] = str_replace('"', '', $value);
			$css[1][$key] = str_replace("'", '', $css[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $css[1][$key]);
			$css[1][$key] = [
				'url' => $absolutePath,
				'type' => 'css',
				'original' => $css[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}
		//css以<style>@import url()</style> 方式导入
		preg_match_all("/@import(?:\s+)(.*)\s/U", $html, $cssimport);
		foreach($cssimport[1] as $key=>$value){
			$cssimport[1][$key] = str_replace('"', '', $value);
			$cssimport[1][$key] = str_replace("'", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace(";", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace("url(", '', $cssimport[1][$key]);
			$cssimport[1][$key] = str_replace(")", '', $cssimport[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $cssimport[1][$key]);
			$cssimport[1][$key] = [
				'url' => $absolutePath,
				'type' => 'css',
				'original' => $cssimport[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}
		//匹配网页中css背景图片 url()中背景图片可能有单引号  双引号 或者不带引号
		preg_match_all("/(?:background|background-image)(?:.*)url\((.*)\)/U", $html, $cssbg);
		foreach($cssbg[1] as $key=>$value){
			if(preg_match("/(data:)/",$value))continue;
			$cssbg[1][$key] = str_replace('"', '', $value);
			$cssbg[1][$key] = str_replace("'", '', $cssbg[1][$key]);
			$absolutePath = $this->relativeToAbsolute($url, $cssbg[1][$key]);
			$cssbg[1][$key] = [
				'url' => $absolutePath,
				'type' => 'css',
				'original' => $cssbg[1][$key],
				'name' => basename($absolutePath),
				'src' => $url,
			];
		}

		//合并结果数组
		$urlList = array_merge($img[1], $js[1], $css[1], $cssbg[1], $cssimport[1]);
		//去掉重复值
  
 
		//保存页面html
	   // file_put_contents($fileName,preg_replace('/(http:\/\/img.yigouf.com)|(http:\/\/pfghouse.pinfangw.com)|(\/\/script.crazyegg.com)/i','',$html));
		return $urlList;		
	}

	
	function getList(){
		$srcUrlList = array();
		$urlList = $this->post['urllist'];
		//获取所有页面资源链接
		foreach($urlList as $key=>$value){
			$srcUrlList= array_merge($this->getPageSrcUrlList($value['url']), $srcUrlList);
			//静态网页资源
			$srcUrlList[] = [
				'url' => $value['url'],
				'type' => 'html',
				'original' => '',
				'name' => $value['name'],
				'src' => '',
			];
		}
		//去掉重复值 关键去重 减少对远程资源的访问次数
		$srcUrlList = array_unique($srcUrlList, SORT_REGULAR);
		//获取CSS中资源及图片
		foreach($srcUrlList as $key=>$value){
			if(preg_match("/(\.css)/i",$value['url'])){
				$srcUrlList= array_merge($this->getCssSrc($value['url']), $srcUrlList);
			}			
		}
		//再次去重
		$srcUrlList = array_unique($srcUrlList, SORT_REGULAR);
		$srcUrlList = array_values($srcUrlList);
		$i = 1;
		foreach($srcUrlList as $key=>$value){
			//按资源类型设置path
			//CSS
			if($value['type'] == 'css'){
				$path = 'css';
			}else if($value['type'] == 'js'){
				//JS
				$path = 'js';
			}else if(preg_match("/(\.jpg)|(\.png)|(\.gif)|(\.ico)/i",$value['url'])){
				//图片
				$path = 'images';
			}else if(preg_match("/(\.ttf)|(\.eot)|(\.woff2)|(\.woff)/i",$value['url'])){
				//字体
				$path = 'font';
			}else if($value['type'] == 'cssbg'){
				//背景
				$path = 'cssbg';
			}else{
				$path = 'other';
			}
			$name = basename($value['url']);
			$resList[] = [
				'id' => $i++,
				'url' => $value['url'],
				'path' => $path,
				'name' => $name,
				'status' => '...',
				'original' => $value['original'],
				'name' => $value['name'],
				'src' => $value['src'],
			];
		}
		$data = [
			"code" => 0,
			"msg" => "操作成功",
			"count" => count($resList),
			"data" => $resList,
		];
		return $data; 
	}
}