<?php 
/**
 * @file Form.php
 * @brief 表单处理
 * @author jellypa
 * @date 2015-01-02
 * @version 3.8.1
 */
namespace App\Controllers;
use  \App\Models\FormModel;
class Form extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	private $captcha;
	public function __construct()
	{
		$this->captcha = new  \CodeIgniter\Captcha\Captcha();
		$this->model = new FormModel();
		$this->session = \Config\Services::session();
		
	}
	/**
	 * @author jellypa
	 * @dateTime  2015-01-02
	 * @brief     前台表单提交
	 * @copyright [jellyCMS]
	 * @param     [string]     $name [表单名称]
	 */
	public function index($name)
	{	
		//取当前表单
		$form = $mustField = $this->model->getForm($name);
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
		if($post['code'] && !$this->captcha->validate($post['code'])){
			$rdata = [
				"code" => 0,
				"msg" => "验证码错误",
			];
			exit(json_encode($rdata));
		}
		unset($post['code']);
		$fields = $this->model->getFields($name);
		foreach($fields as $key=>$value){
			$data[$value] = $post[$value];
		}
		// 两个内置表
		if($name == 'message'){
			$data['username'] = $post['username'];
			$data['sex'] = $post['sex'];
			$data['icon'] = $post['icon'];
			$data['mobile'] = $post['mobile'];
			$data['content'] = $post['content'];
		}
		if($name == 'comment'){
			$data['nickname'] = $post['nickname'];
			$data['icon'] = $post['icon'];
			$data['content_id'] = $post['content_id'];
			$data['content'] = $post['content'];
		}
		//创建表单时 create_time  status ip deleted area_id字段必须创建，不管会不会用到。此处统一
		$data['create_time'] = date("Y-m-d H:i:s",time());
		$data['area_id'] = session('area_id');
		$data['deleted'] = 0;
		$data['pid'] = $data['pid']?$data['pid']:0;
		$data['ip'] = $this->request->getIPAddress();
		$data['status'] = $form['type']; //0：前台不显示 待审核；1：前台展示；2:审核不通过；  与form表type关联
		
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
	/**
	 * @author jellypa
	 * @dateTime  2015-01-02
	 * @brief     图形验证码
	 * @copyright jellyCMS
	 */
	 public function capthcha()
    {
		return $this->captcha->generate();
    }

}
