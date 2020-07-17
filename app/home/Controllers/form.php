<?php namespace App\Controllers;
use  \App\Models\FormModel;

class Form extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		$this->model = new FormModel();
		$this->session = \Config\Services::session();
		
	}
	public function index($name)
	{	
		//取当前表单
		$form = $mustField = $this->model->getForm($name);;
		if(empty($form)){
			$rdata = [
				"code" => 0,
				"msg" => "表单{$name}不存在或不可用",
			];
			exit(json_encode($rdata));
		}
		$post = post();
		//获取必填字段
		$mustField = $this->model->getRequiredField($name);
		foreach(array_column($mustField, 'name') as $value){
			if(!$post[$value]){
				$rdata = [
					"code" => 0,
					"msg" => "必填参数{$value}不能为空",
				];
				exit(json_encode($rdata));
			}			
		}
		unset($post['code']);
		$data = $post;
		//创建表单时 create_time  status ip deleted字段必须创建，不管会不会用到。此处统一
		$data['create_time'] = time();
		$data['status'] = $form['type']; //0：前台不显示；1：前台展示；3：审核中  与form表type关联
		if($this->model->insertData($name, $data)){
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
		echo json_encode($rdata);
	}
	 

}
