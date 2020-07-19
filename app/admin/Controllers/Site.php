<?php
namespace App\Controllers;
use \App\Models\SiteModel;
use \App\Models\FileModel;
class Site extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new SiteModel();
		$this->FileModel = new FileModel();
    }
    public function index()
    {
		$site = $this->model->getSite($this->session->area_id);
		$themeList = $this->FileModel->getThemeList();
		$data = [
			"site" => $site,
			"themeList" => $themeList,
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
