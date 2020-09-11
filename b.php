<?php

    /**
     * 抓取指定页面的静态资源
     * @param $url
     * @return bool|string
     */

    function getUrl($url)
    {
        $headerArray = array("Content-type:application/json;", "Accept:application/json");
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        //curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        //curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        //curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1');
        //curl_setopt($ch, CURLOPT_HTTPHEADER, $headerArray);
        $output = curl_exec($ch);
    	//echo '错误:',curl_error($ch),$output,PHP_EOL;
        curl_close($ch);
        return $output;
    }
    
    /**
     * 保存文件
     * @param $file
     * @param $content
     */
    function save($file, $content)
    {
        if (0 === strpos($file, 'http')) {
            echo $file, PHP_EOL;
            return;
        }
        $last = strripos($file, '/');
        $file = substr($file, 1);
        if (!$file)return;
        $dir = substr($file, 0, $last);
        if (!$dir) {
            echo $dir, PHP_EOL;
            return;
        }
        if (!file_exists($dir)){
            mkdir($dir, 0777, true);
            chmod($dir,0777);
        }
        if (!file_exists($file))
            file_put_contents($file, $content);
        //echo $file,PHP_EOL;
    }
    
    /**
     * css文件
     * @param $arr //匹配结果数组
     * @param $url
     */
    function saveCss($file, $url,$static)
    {
    	$content = getUrl($url);
        preg_match_all("/url\((.*)\)/U", $content, $arr4);
    	//var_dump($arr4);
        foreach ($arr4[1] as $item) {
    		if(strpos($item,'/') === 0){
    			//echo $item,PHP_EOL;
    			if(!is_file($item)){
    			    save($item, file_get_contents($static.$item));
    			}
    		}
        }
    }
	//获取CSS中资源 字体 背景 还可能引入了CSS 引入方式有两种@import "style.css"; /* 或者@import url(style.css)里面也可能有引号
    function getCssSrc($url)
    {
		//$cssName = basename($url);
		$cssPath = dirname($url);
		static $cssSrc = array();
    	$content = getUrl($url);
		preg_match_all("/url\((.*)\)/U", $content, $cssbga);
		foreach($cssbga[1] as $key=>$value){
			if(preg_match("/(data:)/",$value))continue;
			$value = preg_replace('/\?.*/i','',$value);//替换？及以后的字符
			$cssSrcT = str_replace('"', '', $value);
			$cssSrcT = str_replace("'", '', $cssSrcT);
			$absolutePath = relativeToAbsolute($url, $cssSrcT);
			$cssSrc[] = $absolutePath;
			if(preg_match("/(\.css)/i",$absolutePath)){
				$cssSrc[] = getCssSrc($url);
			}
		}
		$cssSrc = array_unique($cssSrc);
		return $cssSrc;
    }
    //相对路径转绝对路径
	function relativeToAbsolute($url, $relativeUrl){
		$path = dirname($url);
		$pathArray = explode('/', $path);
		$relativeArray = explode('/', $relativeUrl);
		foreach($relativeArray as $key=>$value){
			if($value == '..'){
				array_pop($pathArray);
				unset($relativeArray[$key]);
			}else if($value == '.'){
				//./相对当前路径，此处直接删除
				unset($relativeArray[$key]);
			}
		}
		$absolute = implode('/', $pathArray).'/'.implode('/', $relativeArray);
		return $absolute;
	}

	
	function getSrcUrlList($url){
		$html = getUrl($url);//抓取页面
		//匹配src地址，图片或者js 可能存在不规则写法如资源链接未带引号 缺少空格
		preg_match_all("/src=(.*)(?:\/>|>| )/U", $html, $src);
		foreach($src[1] as $key=>$value){
			$src[1][$key] = str_replace('"', '', $value);
			$src[1][$key] = str_replace("'", '', $src[1][$key]);
			$src[1][$key] = relativeToAbsolute($url, $src[1][$key]);
		}
		
		//匹配css地址 可能存在不规则写法 如缺少引号 
		preg_match_all("/href=(.*)(?:\/>|>| )/U", $html, $css);
		foreach($css[1] as $key=>$value){
			$css[1][$key] = str_replace('"', '', $value);
			$css[1][$key] = str_replace("'", '', $css[1][$key]);
			$css[1][$key] = relativeToAbsolute($url, $css[1][$key]);
		}

		//匹配网页中css背景图片 url()中背景图片可能有单引号  双引号 或者不带引号
		preg_match_all("/url\((.*)\)/U", $html, $cssbg);
		foreach($cssbg[1] as $key=>$value){
			$cssbg[1][$key] = str_replace('"', '', $value);
			$cssbg[1][$key] = str_replace("'", '', $cssbg[1][$key]);
			$cssbg[1][$key] = relativeToAbsolute($url, $cssbg[1][$key]);
		}

		//合并结果数组
		$urlList = array_merge($src[1],$css[1],$cssbg[1]);
		$urlList = array_unique($urlList); //去掉重复值 
		//保存页面html
	   // file_put_contents($fileName,preg_replace('/(http:\/\/img.yigouf.com)|(http:\/\/pfghouse.pinfangw.com)|(\/\/script.crazyegg.com)/i','',$html));
		return $urlList = array_unique($urlList);		
	}
	function getAllSrc($urlList){
		$staticList = array();
		foreach($urlList as $item){
			$path = dirname($item);
			if(strpos($item,'script.crazyegg.com'))continue;
			if(preg_match("/(\.js)|(\.css)|(\.jpg)|(\.png)|(\.gif)|(\.ico)/i",$item)){
				if(preg_match(".baidu.",$item))continue;//排除百度代码
				$newFile = preg_replace('/\?.*/i','',$item);//替换？及以后的字符
				if(preg_match("/([(http:\/\/)(\/\/)])+.*\.com/i",$item))$newFile = preg_replace('/([(http:\/\/)(\/\/)])+.*\.com/i','',$newFile);//跨域资源存到本地的名字
				if(preg_match("(//)",$item)){
					$staticUrl = $item;
				}else{
					$staticUrl = $path.$item;
				}
				$staticList[] = $staticUrl;
				//保存css文件中的背景图片资源
				if(preg_match("/(\.css)/i",$item)){
					 $staticList = array_merge(getCssSrc($staticUrl),$staticList);
				}
			}
		}
		return  array_unique($staticList);
	}
	
	function getList(){
			$srcUrlList = array();
			//$urlList = $_POST['urllist'];
			$urlList = [
				['url'=>'http://www.jellycms.cn/'],
				['url'=>'http://www.jellycms.cn/?aboutus/'],
			];
			foreach($urlList as $key=>$value){
				$srcUrlList= array_merge(getSrcUrlList($value['url']), $srcUrlList);
			}
			$list = getAllSrc($srcUrlList);
	 
		foreach($list as $key=>$value){
			$resList[] = [
				'url' => $value,
				'id' => $key+1,
				'status' => 0,
			];
		}
		//$resList = array_unique($resList);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($resList),
			"data" => $resList,
		];
		return json_encode($data);
	}
	echo getList();
 

?>
