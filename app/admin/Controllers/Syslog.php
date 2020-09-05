<?php
/**
 * @file Syslog.php
 * @brief 系统日志
 * @author 无双
 * @date 2020-06-02
 * @version 3.8.1
 */
namespace App\Controllers;
use \App\Models\SysLogModel;
class SysLog extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new SysLogModel();
    }
    public function index()
    {
        return view('logs.html');
    }
	//获取日志列表
    public function getList()
    {	
		$page = get('page')?get('page'):1;
		$limit = get('limit')?get('limit'):10;
		$list = $this->model->getList($page, $limit);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $this->model->getCount(),
			"data" => $list,
		];
		return json_encode($data);
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
		$this->model->log($data);
	}
    public function clear()
    {
		if($this->model->clear()){
			$this->log('syslog-clear', '清空日志');
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }
}