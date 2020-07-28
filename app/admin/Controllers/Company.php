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
		$company = $this->model->getCompany($this->session->area_id);
		$data = [
			"company" => $company,
		];
         echo view('company.html', $data);
    }
    public function edit()
    {
		$post = post();
		if(!$post['name']){
			error("操作失败", '/'.ADMINNAME.'/company/index/');
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