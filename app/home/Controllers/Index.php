<?php namespace App\Controllers;
use  \App\Models\IndexModel;

class Index extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $data;//页面数据
	private $model;
	private $cacheName;//缓存文件名
	public function __construct()
	{
		$this->model = new IndexModel();
		//获取当前区域信息
		$area = $this->model->getCurrentArea($_SERVER['HTTP_HOST']);
		$area_id = $area['id'];
		//已绑定移动端域名的，跳转到域名
		if($area['domain'] != '' && $area['domain'] != $this->model->getHttpType().$_SERVER['HTTP_HOST']){
			header('Location: '.$area['domain'].$_SERVER['REQUEST_URI']);
			exit;
		}
		
		//获取当前区域模板 及设置缓存文件名称
		$request = \Config\Services::request();
		$agent = $request->getUserAgent();
		if ($agent->isMobile())
		{
			$cacheTemp = $cacheTemp.'mobile'.$area_id;
			$this->theme = $area['mobiletheme']; //主题
			$this->folder = $area['htmlfolder'];//模板存放文件夹
		}
		else
		{
			$cacheTemp = $cacheTemp.'pc'.$area_id;
			$this->theme = $area['pctheme']; //主题
			$this->folder = $area['htmlfolder'];//模板存放文件夹
			
		}
		$this->session = \Config\Services::session();
		//开启缓存则先取缓存文件
		if($GLOBALS['cached']){
			$this->cacheName = md5($cacheTemp); //缓存文件名
			if ($output = cache($this->cacheName))
			{
				//exit($output);
			}			
		}
		
		//设置area_id
		$this->session->set(['area_id' =>$area_id]);
		//全局标签 数据
		$this->data['company'] = $this->model->getCompany($area_id);
		$this->data['site'] = $this->model->getSite($area_id);
	}
	public function index()
	{	
		$str =$_SERVER["QUERY_STRING"];
		if(!$str) {
			$this->data['home'] = 1;//首页标记
			return view('index.html',$this->data, ['theme'=>$this->theme, 'folder'=>$this->folder]);
		}
		
		//去掉后缀
		$str = str_replace(".html","",$str);
		$str = str_replace(".htm","",$str);
		$str = trim($str, "/");
		//目录/ID模式模式处理
		if(strpos($str, '/')){//目录/ID模式 只取内容ID
			$params = explode('/', $str);
			return $this->content($params[1]); 
		}else if(strpos($str, '_')){ //列表页 单页 无自定义别名和有自定义别名的都可用
			$params = explode('_', $str);
			return $this->list($params); 
		}else{//列表页 单页 ?list/ 有自定义别名
			return $this->list(array($str)); 
		}

	}
	
	//列表页 $params[0] urlname; $params[1] id;$params[2]  页数
	public function list($params){
		if(count($params) == 1){
			$sort = $this->model->getSortByUrlname($params[0]);
		}else if(count($params) == 2){
			//两个参数可能是分页 urlname_page  model_urlname_sortid
			//如果urlname存在，那么可以确定第二个参数是分页。
			$checkSorts = $this->model->getSortByUrlname($params[0]);
			if($checkSorts['urlname'] != ''){
				$sort = $this->model->getSortByUrlname($params[0]);
			}else{
				$sort = $this->model->getSortById($params[1]);
			}
			
			if($sort['id']){
				$this->data['page'] = $params[1];
			}
		}else if(count($params) == 3){
			$sort = $this->model->getSortById($params[1]);
			$this->data['page'] = $params[2];
		}
		if(!$sort) exit('栏目不可用');
		$parents = $this->model->getParentsorts($sort['id']);
		$this->data['sorts'] = $sort;
		$this->data['topsort'] = $parents[0];//顶级分类
		array_pop($parents);//最后一个元素是当前分类，删除
		$this->data['parentsort'] = end($parents);//父分类 顶级分类无父分类
		return view($sort['listtpl'],$this->data, ['theme'=>$this->theme, 'folder'=>$this->folder]);
		//echo view($sort['listtpl'],$this->data, ['cache'=>$this->catchTime,'cache_name'=>$this->cacheName]);
	}
	//内容页 
	private function content($id){
		//获取content 相关数据
		$content = $this->model->getContent($id);
		if(!$content) exit('内容不可用');
		$prenext = $this->model->getPreNext($id);
		$this->data['pre'] = $prenext['pre'];
		$this->data['next'] = $prenext['next'];
		$sort = $this->model->getSortById($content['sort_id']);
		
		$this->data['contents'] = $content;
		$parents = $this->model->getParentsorts($sort['id']);
		$this->data['sorts'] = $sort;
		$this->data['topsort'] = $parents[0];//顶级分类
		array_pop($parents);//最后一个元素是当前分类，删除
		$this->data['parentsort'] = end($parents);//父分类 顶级分类无父分类
		//echo view($sort['contenttpl'],$this->data, ['cache'=>$this->catchTime,'cache_name'=>$this->cacheName]);
		return view($sort['contenttpl'],$this->data, ['theme'=>$this->theme, 'folder'=>$this->folder]);
	}
 
	//处理路由 其它同类路由在app/home/config/routes.php里有一份处理CI自有模式和伪静态模式路由。
	private function route($str){

	}
	/**
     * 判断是否为https
     * @return bool 是https返回true;否则返回false
     */
    function isHttps() {
        if ( !empty($_SERVER['HTTPS']) && ($_SERVER['HTTPS']) !== 'off') {
            return true;
        } elseif ( isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https' ) {
            return true;
        } elseif ( !empty($_SERVER['HTTP_FRONT_END_HTTPS']) && ($_SERVER['HTTP_FRONT_END_HTTPS']) !== 'off') {
            return true;
        }else{
            return false;
        }
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
