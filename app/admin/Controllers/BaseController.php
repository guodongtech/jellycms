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
			Header("Location: ".$GLOBALS['self_path'].'/');
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
			Header("Location: ".$GLOBALS['self_path'].'/'.ADMINNAME."/login/"); 
			exit;
		}

		/* 权限控制 start*/
		//请求方式
		if (isset($_SERVER["HTTP_X_REQUESTED_WITH"]) && strtolower($_SERVER["HTTP_X_REQUESTED_WITH"] == 'XMLHttpRequest')){
			$ajax = 1;
		} else {
			$ajax = 0;
		}
		// 获取控制器方法
		$this->router = Services::router();
		$controller = explode('\\',$this->router->controllerName());
		$controller = end($controller);
		$action = $this->router->methodName();
		// 验证是否录入权限管理系统
		$this->checkModel = new CheckModel();
		$auth_id = $this->checkModel->isAuthRight($controller,$action);
		if($auth_id){
			// 检查该用户是否拥有此权限
			$auth_check = $this->checkModel->authCheck($controller,$action,$auth_id);
			if($auth_check !== true && $ajax == 1){
				echo json_encode($auth_check);die;
			}elseif($auth_check !== true && $ajax == 0){
				error("您没有该权限",'javascript:history.back(-1)');
			}
		}
		/* 权限控制 end*/

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
