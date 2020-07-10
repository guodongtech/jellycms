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

        echo view('html/logs.html');
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
		echo json_encode($data);
    }
  
    public function clear()
    {
		if($this->model->clear()){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
			echo json_encode($rdata);			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
			echo json_encode($rdata);
		}
    }
}