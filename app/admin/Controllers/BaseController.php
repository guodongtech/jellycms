<?php
namespace App\Controllers;
use CodeIgniter\Controller;
use Config\Services;
use \App\Models\CheckModel;
use \Config;

class BaseController extends Controller
{
	protected $helpers = [];
	public $session;
	public $sysConfig;
	public function initController(\CodeIgniter\HTTP\RequestInterface $request, \CodeIgniter\HTTP\ResponseInterface $response, \Psr\Log\LoggerInterface $logger)
	{
		//禁止直接访问后台控制器
		if(!defined("AUTH")){
			Header("Location: '/'");
			exit;
		}
		parent::initController($request, $response, $logger);
		//设置SESSION
		$this->session = \Config\Services::session();
		/*检测登录状态，未登录跳回登录页。
			后台链接必须是 后台.php/controller/action/xxx  否则登录超时会跳回首页。 
		*/

		$uriSegments = $request->uri->getSegments();///path/to/page=> ['path', 'to', 'page']
		if(!session('id') && AUTH){
			Header("Location: /".ADMINNAME."/login/"); 
			exit;
		}

		// 加载白名单
		$config = new \Config\Authconfig();
		$white = $config->white;
		// 权限校验
		$this->router = Services::router();
		$this->checkModel = new CheckModel();
		// 获取controller
		$controller = explode('\\',$this->router->controllerName());
		$controller = end($controller);
		$action = $this->router->methodName();
		if($controller != 'Home'){
			$param = $uriSegments[3];
		}else{
			$param = '';
		}
		// $action =  $this->router->methodName();
		// 获取参数 目前只支持固定单参
		$res = $this->checkModel->authCheck($controller,$action,$param,$white);
		if($res['code'] == 2){
			//exit($res['msg']);  //暂时不启用。待权限录入结束再开启
		}

		//后台信息
		$jellyConfig =  new \Config\config();
		$GLOBALS['version'] = $jellyConfig->version;
		//连接数据库
		$this->db = \Config\Database::connect();
		
		//读取系统配置
		$builder = $this->db->table('config');
		$sysConfig   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
		foreach($sysConfig as $key=>$value){
			$GLOBALS[$value['name']] = $value['value'];
		}	
	}
	//记录日志
	public function log($name, $description){
		$data = [
			'name' => $name,
			'description' => $description,
			'ip' => $this->request->getIPAddress(),
			'os' => $this->request->getUserAgent()->getPlatform(),
			'browser' => $this->request->getUserAgent()->getBrowser(),
			'mobile' => $this->request->getUserAgent()->getMobile(),
			'create_user' => $this->session->id,
			'create_time' => date('Y-m-d H:i:s',time()),
			'deleted' => 0,
		];
		$builder = $this->db->table('logs');
		return $builder->insert($data);
	}

}
