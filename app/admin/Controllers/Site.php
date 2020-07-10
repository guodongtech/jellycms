<?php
namespace App\Controllers;
use \App\Models\SiteModel;

class Site extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SiteModel();
    }
    public function index()
    {
		$site = $this->model->getSite($this->session->area_id);
		$data = [
			"site" => $site,
		];
         echo view('html/site.html', $data);
    }
    public function edit()
    {
		$post = post();
		unset($post['file']); //移除LAYUI多余表单
		if(!$post['title']){
			error("操作失败", '/'.ADMINNAME.'/site/index/');
			exit;
		}
		$data = $post;
		$data['area_id'] = $this->session->area_id;
		if($this->model->edit($data)){
			success("操作成功", '/'.ADMINNAME.'/site/index/');				
		}else{
			error("操作失败", '/'.ADMINNAME.'/site/index/');
		}
    }
}
