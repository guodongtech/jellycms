<?php
/**
 * @copyright (c) 2015-2099 www.guodong.tech
 * @file Common.php
 * @brief 自定义函数
 * @author zhangteng
 * @date 2014/7/14 23:11:50
 * @version 1.0.0
 */
 //前台 url
 function url($parrams){
	$config = new \Config\Config();
	if($config->rewriteRule == 'url'){
		count($parrams)>1?$url = '/?'.implode('/', $parrams).'.'.$config->suffix:$url = '/?'.implode('/', $parrams).'/';
		return $url;
	}else{
		count($parrams)>1?$url = '/'.implode('/', $parrams).'/'.$config->suffix:$url = '/'.implode('/', $parrams).'/';
		return $url;
	}
 }
 
 function getWebThemePath(){
	 $config = new \Config\Config();
	 return $themePath = '/'.$config->homeViewName.'/'.$config->theme.'/';
 }
 function error($msg = '', $url = null, $data = '', $wait = 3, array $header = [])
{
	if (is_null($url) && !is_null($_SERVER['HTTP_REFERER'])) {
		$url = $_SERVER['HTTP_REFERER'];
	} elseif ('' !== $url && !strpos($url, '://') && 0 !== strpos($url, '/')) {
		$url =$url;
	}
	$data = [
		'code' => 0,
		'msg'  => $msg,
		'data' => $data,
		'url'  => $url,
		'wait' => $wait,
	];
	echo view('/html/dispatch_jump.html', $data);exit;

}
 
 
 