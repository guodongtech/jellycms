<?php 
namespace App\Controllers;
use  \App\Models\StatisticsModel;
class Statistics extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	private $ipLocation;
	public function __construct()
	{
		$this->model = new StatisticsModel();
		$this->ipLocation = new \CodeIgniter\IpLocation\IpLocation();
	}
	public function index($sort_id, $content_id)
	{	
		//此处忽略蜘蛛
		if($this->request->getUserAgent()->isRobot()){
			return;
		}
		if($content_id > 0){
			$this->model->updateVisit($content_id);
		}
		
		$data = [
			'ip' => $this->request->getIPAddress(),
			'os' => $this->request->getUserAgent()->getPlatform(),
			'browser' => $this->request->getUserAgent()->getBrowser(),
			'spider' => $this->request->getUserAgent()->getRobot(),
			'start_time' => date('Y-m-d H:i:s',time()),
			'content_id' => $content_id,
			'sort_id' => $sort_id,
			'province' => $this->ipLocation->getlocation($this->request->getIPAddress()),
		];
		$insertId = $this->model->addData($data);
		$script = 'window.onbeforeunload = function(){var id='.$insertId.'; var url="'.$GLOBALS['self_path'].'/index.php/Statistics/end/"+id; navigator.sendBeacon(url);};';
		return $script;
	}
	public function end($id)
	{	
		$post = post();
		$data = [
			'end_time' => date('Y-m-d H:i:s',time()),
		];
		$this->model->updateData($data, $id);
		return true;
	}
}
