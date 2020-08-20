<?php 
namespace App\Controllers;
use \App\Models\HomeModel;
use \App\Models\MenuModel;
use \App\Models\AreaModel;
use \App\Models\MessageModel;
class Home extends BaseController
{    
	private $model;
	public function __construct()
    {
        $this->model = new HomeModel();
        $this->areaModel = new AreaModel();
        $this->MenuModel = new MenuModel();
        $this->MessageModel = new MessageModel();
    }
	public function index()
	{	
		$role_id = $this->session->role_id;
		$menuList = $this->MenuModel->getMenuListByRoleId($role_id);
		$areaList = $this->areaModel->getList();
		foreach($menuList as $key=>$value){
			if($value['pid'] == 0){
				$List[] = $value;
				$Pids[] = $value['id'];
			}
		}
		// 修改信息 安全管理地址信息
		$sysuser = $this->MenuModel->getMenuInfo('SysUser','index');
		$syssafe = $this->MenuModel->getMenuInfo('Config','index');

		$data = [
			'sysuser' => $sysuser,
			'syssafe' => $syssafe,
			'list' => $List,
			'mlist' => $menuList,
			'arealist' => $areaList,
			'areaid' => $this->session->area_id,
		];
		return view('index.html', $data);
	}
	public function switch(){
		$area_id = post('area_id');
		//设置会话
		$data = array(
			'area_id' => $area_id,
		);
		$this->session->set($data);
		$this->log('home', "[区域]切换区域");
		$rdata = [
			"code" => 1,
			"msg" => "切换区域",
		];
		return json_encode($rdata);
	}
	public function welcome()
	{
		// 取快捷显示栏内容
		$fast_menu = $this->MenuModel->getFastMenu();
		$fast_menu = array_chunk($fast_menu,8);
		// 待审评论 留言
		$message_check_count = $this->MessageModel->getMessageCount();
		$comment_check_count = $this->MessageModel->getCommentCount();
		$message_menu = $this->MenuModel->getMenuInfo('Message','index');

		$data['fast_menu'] = $fast_menu;
		$data['message_check_count'] = $message_check_count;
		$data['comment_check_count'] = $comment_check_count;
		$data['message_menu'] = $message_menu;
		
		return view('welcome.html',$data);
	}
}
