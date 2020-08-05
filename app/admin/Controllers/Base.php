<?php
namespace App\Controllers;
use CodeIgniter\Controller;

class Base extends Controller
{
	protected $helpers = [];
	public function initController(\CodeIgniter\HTTP\RequestInterface $request, \CodeIgniter\HTTP\ResponseInterface $response, \Psr\Log\LoggerInterface $logger)
	{
		parent::initController($request, $response, $logger);
		//设置SESSION
		$this->session = \Config\Services::session();
		$this->db = \Config\Database::connect();
		//后台信息
		$jellyConfig =  new \Config\config();
		$GLOBALS['version'] = $jellyConfig->version;
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

}
