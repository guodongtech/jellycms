<?php 
namespace App\Controllers;
use CodeIgniter\Controller;
use \App\Models\LoginModel;
use \App\Models\AreaModel;
class Login extends Base
{

    private $model;
    private $areaModel;
    private $captcha;
     //会话。此处单独使用

    public function __construct()
    {
        $this->model = new LoginModel();
        $this->areaModel = new AreaModel();
		$this->captcha = new  \CodeIgniter\Captcha\Captcha();
		$this->session = \Config\Services::session();
    }
    public function index()
    {	
		//已登录用户跳转回后台首页
		if($this->session->id>0){
			Header("Location: /".ADMINNAME."/home/"); 
			exit;
		}
		return view('login.html');
    }
    public function capthcha()
    {
		return $this->captcha->generate();
    }
    public function act()
    {
		//锁定期处理
		if((time() - $this->session->lockTime) <= 0){
			$data = [
				"code" => 0,
				"msg" => ($this->session->lockTime - time())."秒后解锁",
			];
			return json_encode($data);
		}
		$name = post('name');
		$password = post('password');
		$passwordMd5 = md5($password);
		$code = post('code');
		if(!$name || !$password || !$code){
			$data = [
				"code" => 0,
				"msg" => "参数不能为空",
			];
			return json_encode($data);
		}
		if(!$this->captcha->validate($code)){
			$data = [
				"code" => 0,
				"msg" => "验证码错误",
			];
			return json_encode($data);
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
			//错误次数加1
			$countFalse = isset($this->session->countFalse)?$this->session->countFalse:0;
			$this->session->set('countFalse',$countFalse + 1);
			if($this->session->countFalse >= $GLOBALS['lock_count']){
				$this->session->set('lockTime',time() + $GLOBALS['lock_time']);//设置解锁时间
				$data = [
					"code" => 0,
					"msg" => "错误次数太多，已被锁定".$GLOBALS['lock_time']."秒",
				];
			}else{
				$data = [
					"code" => 0,
					"msg" => "账号或密码错误",
				];
			}

		}
		return json_encode($data);
    }
	
	public function logout(){
		session_destroy();
		success("操作成功", '/'.ADMINNAME.'/login/');	
	}
	
}
