<?php
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
  
    public function clear()
    {
		if($this->model->clear()){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
			return json_encode($rdata);			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
			return json_encode($rdata);
		}
    }
}