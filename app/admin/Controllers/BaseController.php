<?php
namespace App\Controllers;
use CodeIgniter\Controller;

class BaseController extends Controller
{
	protected $helpers = [];
	public $session;
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
		//echo $request->uri->getSegment(1);exit;
		if(!$this->session->id && AUTH && $request->uri->getSegment(1) != 'login'){
			Header("Location: /".ADMINNAME."/login/"); 
			exit;
		}
		//连接数据库
		$this->db = \Config\Database::connect();
	}

}
