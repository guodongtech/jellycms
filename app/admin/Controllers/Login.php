<?php 
namespace App\Controllers;
use CodeIgniter\Controller;
use \App\Models\LoginModel;
use \App\Models\AreaModel;
class Login extends Controller
{

    private $model;
    private $areaModel;
    private $captcha;
     //会话。此处单独使用

    public function __construct()
    {
        $this->model = new LoginModel();
        $this->areaModel = new AreaModel();
		$this->captcha = new \App\Libraries\Captcha();
		$this->session = \Config\Services::session();
    }
    public function index()
    {	
		//$this->session->destroy();exit;
		//已登录用户跳转回后台首页
		if($this->session->id>0){
			Header("Location: /".ADMINNAME."/home/"); 
			exit;
		}
		echo view('login.html');
    }
    public function capthcha()
    {
		echo $this->captcha->generate();
    }
    public function act()
    {
		$name = post('name');
		$password = post('password');
		$passwordMd5 = md5($password);
		$code = post('code');
		if(!$name || !$password || !$code){
			$data = [
				"code" => 0,
				"msg" => "参数不能为空",
			];
			exit(json_encode($data));
		}
		if(!$this->captcha->validate($code)){
			$data = [
				"code" => 0,
				"msg" => "验证码错误",
			];
			exit(json_encode($data));
		}

		$result = $this->model->getAdmin($name, $passwordMd5);
		if(is_array($result)){
			$resultArea = $this->areaModel->getDefalutArea();
			//设置会话
			$data = array(
				'id' => $result['id'],
				'adminname' => $result['name'],
				'role_id' => $result['role_id'],
				'area_id' => $resultArea['id'],
			);
			
			$this->session->set($data);
			//返回数据组装
			$data = [
				"code" => 1,
				"msg" => "验证通过",
			];
		}else{
			$data = [
				"code" => 0,
				"msg" => "账号或密码错误",
			];			
		}
		echo json_encode($data);
    }
	
	public function logout(){
		session_destroy();
		success("操作成功", '/'.ADMINNAME.'/login/');	
	}
	
}
