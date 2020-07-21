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
function post(){
	$args = func_get_args();
	$request = \Config\Services::request();
	if(count($args)){
		$args_str = implode(',', $args);
		return $request->getPost($args_str);
	}else{
		return $request->getPost();
	}
}
 function getWebThemePath(){
	//拼接模板路径 域名模式待处理
	$config = new \config\config();
	$request = \Config\Services::request();
	$agent = $request->getUserAgent();
	if ($agent->isMobile())
	{
		$themePath = '/'.$config->homeViewName.'/'.$config->mobileTheme.'/';
	}
	else
	{
		$themePath = '/'.$config->homeViewName.'/'.$config->theme.'/';
	}
		
	return $themePath;
	 
 }

    /**
     * 操作成功跳转的快捷方法
     * @access protected
     * @param mixed  $msg    提示信息
     * @param string $url    跳转的 URL 地址
     * @param mixed  $data   返回的数据
     * @param int    $wait   跳转等待时间
     * @param array  $header 发送的 Header 信息
     * @return void
     * @throws HttpResponseException
     */
    function success($msg = '', $url = null, $data = '', $wait = 3, array $header = [])
    {
        if (is_null($url) && !is_null($_SERVER['HTTP_REFERER'])) {
            $url = $_SERVER['HTTP_REFERER'];
        } elseif ('' !== $url && !strpos($url, '://') && 0 !== strpos($url, '/')) {
            $url =$url;
        }
        $data = [
            'code' => 1,
            'msg'  => $msg,
            'data' => $data,
            'url'  => $url,
            'wait' => $wait,
        ];
        echo view('html/dispatch_jump.html', $data);exit;
    }

    /**
     * 操作错误跳转的快捷方法
     * @access protected
     * @param mixed  $msg    提示信息
     * @param string $url    跳转的 URL 地址
     * @param mixed  $data   返回的数据
     * @param int    $wait   跳转等待时间
     * @param array  $header 发送的 Header 信息
     * @return void
     * @throws HttpResponseException
     */
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
		echo view('html/dispatch_jump.html', $data);exit;

    }
 function isMobile(){
	 return 1;
 }
 
 