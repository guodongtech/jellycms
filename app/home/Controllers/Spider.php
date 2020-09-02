<?php 
namespace App\Controllers;
use  \App\Models\StatisticsModel;
class Spider extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		
	}
	public function index()
	{	
		$url = 'https://www.jellycms.cn/';
		$this->baiduSpider( $url );
		$this->sogouSpider( $url );
		$this->bingSpider( $url );
		$this->googleSpider( $url );
		$this->haosou360Spider( $url );
	}
	/**
     * cURL获取网页内容
     * @param  [type] [param]
     * @return [type] [description]
     */
    private function baiduSpider( $url )
    {
        $this->ch = curl_init();
        $this->ip = '220.181.108.'.rand(1,255);  // 百度蜘蛛
        $this->timeout = 15;
        curl_setopt($this->ch, CURLOPT_URL,$url);
        curl_setopt($this->ch, CURLOPT_TIMEOUT,0);
        //伪造蜘蛛IP  
        curl_setopt($this->ch, CURLOPT_HTTPHEADER,array('X-FORWARDED-FOR:'.$this->ip.'','CLIENT-IP:'.$this->ip.'')); 
        //伪造蜘蛛头部
        curl_setopt($this->ch, CURLOPT_USERAGENT,"Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)");
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($this->ch, CURLOPT_HEADER,0);
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,$this->timeout);
		//不验证SSL证书
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $content = curl_exec($this->ch);
        if($content === false)
        {
			//输出错误信息
            $no = curl_errno($this->ch);
            switch(trim($no))
            {
                case 28 : $this->error = '访问目标地址超时'; break;
                default : $this->error = curl_error($this->ch); break;
            }
            echo $this->error;
        }
        else
        {
            return $content;
        }
    }
    private function sogouSpider( $url )
    {
        $this->ch = curl_init();
		$this->ip = '220.181.108.'.rand(1,255);  // 百度蜘蛛
        $this->timeout = 15;
        curl_setopt($this->ch, CURLOPT_URL,$url);
        curl_setopt($this->ch, CURLOPT_TIMEOUT,0);
        //伪造蜘蛛IP  
        curl_setopt($this->ch, CURLOPT_HTTPHEADER,array('X-FORWARDED-FOR:'.$this->ip.'','CLIENT-IP:'.$this->ip.'')); 
        //伪造蜘蛛头部
        curl_setopt($this->ch, CURLOPT_USERAGENT,"Sogou web spider/4.0(+http://www.sogou.com/docs/help/webmasters.htm#07)");
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($this->ch, CURLOPT_HEADER,0);
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,$this->timeout);
		//不验证SSL证书
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $content = curl_exec($this->ch);
        if($content === false)
        {
			//输出错误信息
            $no = curl_errno($this->ch);
            switch(trim($no))
            {
                case 28 : $this->error = '访问目标地址超时'; break;
                default : $this->error = curl_error($this->ch); break;
            }
            echo $this->error;
        }
        else
        {
            return $content;
        }
    }
    private function bingSpider( $url )
    {
        $this->ch = curl_init();
		$this->ip = '220.181.108.'.rand(1,255);  // 百度蜘蛛
        $this->timeout = 15;
        curl_setopt($this->ch, CURLOPT_URL,$url);
        curl_setopt($this->ch, CURLOPT_TIMEOUT,0);
        //伪造蜘蛛IP  
        curl_setopt($this->ch, CURLOPT_HTTPHEADER,array('X-FORWARDED-FOR:'.$this->ip.'','CLIENT-IP:'.$this->ip.'')); 
        //伪造蜘蛛头部
        curl_setopt($this->ch, CURLOPT_USERAGENT,"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)");
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($this->ch, CURLOPT_HEADER,0);
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,$this->timeout);
		//不验证SSL证书
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $content = curl_exec($this->ch);
        if($content === false)
        {
			//输出错误信息
            $no = curl_errno($this->ch);
            switch(trim($no))
            {
                case 28 : $this->error = '访问目标地址超时'; break;
                default : $this->error = curl_error($this->ch); break;
            }
            echo $this->error;
        }
        else
        {
            return $content;
        }
    }
    private function googleSpider( $url )
    {
        $this->ch = curl_init();
		$this->ip = '220.181.108.'.rand(1,255);  // 百度蜘蛛
        $this->timeout = 15;
        curl_setopt($this->ch, CURLOPT_URL,$url);
        curl_setopt($this->ch, CURLOPT_TIMEOUT,0);
        //伪造蜘蛛IP  
        curl_setopt($this->ch, CURLOPT_HTTPHEADER,array('X-FORWARDED-FOR:'.$this->ip.'','CLIENT-IP:'.$this->ip.'')); 
        //伪造蜘蛛头部
        curl_setopt($this->ch, CURLOPT_USERAGENT,"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)");
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($this->ch, CURLOPT_HEADER,0);
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,$this->timeout);
		//不验证SSL证书
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $content = curl_exec($this->ch);
        if($content === false)
        {
			//输出错误信息
            $no = curl_errno($this->ch);
            switch(trim($no))
            {
                case 28 : $this->error = '访问目标地址超时'; break;
                default : $this->error = curl_error($this->ch); break;
            }
            echo $this->error;
        }
        else
        {
            return $content;
        }
    }
    private function haosou360Spider( $url )
    {
        $this->ch = curl_init();
		$this->ip = '220.181.108.'.rand(1,255);  // 百度蜘蛛
        $this->timeout = 15;
        curl_setopt($this->ch, CURLOPT_URL,$url);
        curl_setopt($this->ch, CURLOPT_TIMEOUT,0);
        //伪造蜘蛛IP  
        curl_setopt($this->ch, CURLOPT_HTTPHEADER,array('X-FORWARDED-FOR:'.$this->ip.'','CLIENT-IP:'.$this->ip.'')); 
        //伪造蜘蛛头部
        curl_setopt($this->ch, CURLOPT_USERAGENT,"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider");
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($this->ch, CURLOPT_HEADER,0);
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,$this->timeout);
		//不验证SSL证书
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $content = curl_exec($this->ch);
        if($content === false)
        {
			//输出错误信息
            $no = curl_errno($this->ch);
            switch(trim($no))
            {
                case 28 : $this->error = '访问目标地址超时'; break;
                default : $this->error = curl_error($this->ch); break;
            }
            echo $this->error;
        }
        else
        {
            return $content;
        }
    }
}
