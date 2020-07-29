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
	//返回API JSON数据
	function apiresponse($code = 0, $msg = "", $data = array(), $url = ""){
		$res = [
			'code' => $code,
			'msg' => $msg,
			'url' => $url,
			'data' => $data,
		];
		return json_encode($res);
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
	function get(){
		$args = func_get_args();
		$request = \Config\Services::request();
		if(count($args)){
			$args_str = implode(',', $args);
			return $request->getGet($args_str);
		}else{
			return $request->getGet();
		}
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
        echo view('admin/html/dispatch_jump.html', $data);exit;
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
		echo view('admin/html/dispatch_jump.html', $data);exit;

    }
// 生成无限极树,$data为二维数组数据
function gettree($data, $tid, $idField, $pidField, $childName = 'child')
{
    $tree = array();
    foreach ($data as $key => $value) {
        if (is_array($value)) {
            if ($value[$pidField] == "$tid") { // 父亲找到儿子
				$value[$childName] = gettree($data, $value[$idField], $idField, $pidField, $childName);
                $tree[] = $value;
            }
        } else {
            if ($value->$pidField == "$tid") { // 父亲找到儿子
                $temp = clone $value;
                $temp->$childName = gettree($data, $value->$idField, $idField, $pidField, $childName);
                $tree[] = $temp;
            }
        }
    }
    return $tree;
}