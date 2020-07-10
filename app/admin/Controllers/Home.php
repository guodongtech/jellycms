<?php 
namespace App\Controllers;
use \App\Models\HomeModel;
use \App\Models\MenuModel;
class Home extends BaseController
{    
	private $model;
	public function __construct()
    {
        $this->model = new HomeModel();
        $this->MenuModel = new MenuModel();
    }
	public function index()
	{	
		$role_id = $this->session->role_id;
		$menuList = $this->MenuModel->getMenuListByRoleId($role_id);
		foreach($menuList as $key=>$value){
			if($value['pid'] == 0){
				$List[] = $value;
				$Pids[] = $value['id'];
			}
		}
		//print_r($List);
		$data = [
			'list' => $List,
			'mlist' => $menuList,
		];
		
		//$parsercms = \Config\Services::parser();
		//echo $parsercms->setData($data)->render('admin/html/index.html', $data);
		//echo display('admin/html/index.html', $data);
		echo view('html/index.html', $data);
	}
	public function welcome()
	{
		echo view('html/welcome.html');
	}
}
