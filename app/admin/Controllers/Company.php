<?php
namespace App\Controllers;
use \App\Models\CompanyModel;

class Company extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new CompanyModel();
    }

    public function index()
    {
		$com = $this->model->getCompany($this->session->area_id);
		$data = [
			"com" => $com,
		];
         echo view('html/company.html', $data);
    }
    public function edit()
    {
		$post = post();
		print_r($post);
		if(!$post['name']){
			error("操作失败", '/'.ADMINNAME.'/company/index/');
			exit;
		}
		$data = $post;
		$data['area_id'] = $this->session->area_id;
		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/company/index/');				
		}else{
			error("操作失败", '/'.ADMINNAME.'/company/index/');
		}
    }
}