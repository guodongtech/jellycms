<?php
namespace App\Controllers;

/**
 * Class BaseController
 *
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 * Extend this class in any new controllers:
 *     class Home extends BaseController
 *
 * For security be sure to declare any new methods as protected or private.
 *
 * @package CodeIgniter
 */

use CodeIgniter\Controller;

class BaseController extends Controller
{

	/**
	 * An array of helpers to be loaded automatically upon
	 * class instantiation. These helpers will be available
	 * to all other controllers that extend BaseController.
	 *
	 * @var array
	 */
	protected $helpers = [];
	public $session;
	/**
	 * Constructor.
	 */
	public function initController(\CodeIgniter\HTTP\RequestInterface $request, \CodeIgniter\HTTP\ResponseInterface $response, \Psr\Log\LoggerInterface $logger)
	{
		// Do Not Edit This Line
		parent::initController($request, $response, $logger);

		//--------------------------------------------------------------------
		// Preload any models, libraries, etc, here.
		//--------------------------------------------------------------------
		// E.g.:
		$this->session = \Config\Services::session();
		//连接数据库
		$this->db = \Config\Database::connect();
		$config = new \Config\Config();
		$GLOBALS['homeViewName'] = $config->homeViewName;
		//读取系统配置
		$builder = $this->db->table('config');
		$sysConfig   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
		foreach($sysConfig as $key=>$value){
			$GLOBALS[$value['name']] = $value['value'];
		}
		// 黑名单
		$blackip = explode(',',$GLOBALS['blackip']);
		if(in_array($this->request->getIPAddress(),$blackip)){
			echo "该IP已被禁止访问";die;
		}
		//绝大多数蜘蛛不会执行JS，此处判断是否是蜘蛛
		if($this->request->getUserAgent()->isRobot()){
			$ipLocation = new \CodeIgniter\IpLocation\IpLocation();
			$builder = $this->db->table('statistics');
			$data = [
				'ip' => $this->request->getIPAddress(),
				'os' => $this->request->getUserAgent()->getPlatform(),
				'browser' => $this->request->getUserAgent()->getBrowser(),
				'spider' => $this->request->getUserAgent()->getRobot(),
				'start_time' => date('Y-m-d H:i:s',time()),
				'content_id' => 0,
				'sort_id' => 0,
				'query_string' => $_SERVER["QUERY_STRING"],
				'province' => $ipLocation->getlocation($this->request->getIPAddress()),
			];
			$builder->insert($data);
		}
		
	}

}
