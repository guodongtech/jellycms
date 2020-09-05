<?php
/**
 * @file Site.php
 * @brief 站点信息
 * @author jellypa
 * @date 2019-02-02
 * @version 3.8.1
 */
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
         return view('site.html', $data);
    }
    public function edit()
    {
		$post = post();
		unset($post['file']); //移除LAYUI多余表单
		if(!$post['title']){
			error("操作失败", '/'.ADMINNAME.'/site/index/');
		}
		$data = $post;
		$data['area_id'] = $this->session->area_id;
		if($this->model->edit($data)){
			$this->log("site", "[站点信息]编辑");
			success("操作成功", '/'.ADMINNAME.'/site/index/');				
		}else{
			error("操作失败", '/'.ADMINNAME.'/site/index/');
		}
    }
}
