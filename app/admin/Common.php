<?php

/**
 * The goal of this file is to allow developers a location
 * where they can overwrite core procedural functions and
 * replace them with their own. This file is loaded during
 * the bootstrap process and is called during the frameworks
 * execution.
 *
 * This can be looked at as a `master helper` file that is
 * loaded early on, and may also contain additional functions
 * that you'd like to use throughout your entire application
 *
 * @link: https://codeigniter4.github.io/CodeIgniter4/
 */

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