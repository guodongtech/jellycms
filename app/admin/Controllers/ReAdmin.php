<?php 
namespace App\Controllers;

class ReAdmin extends BaseController
{
	public function changeAdmin()
	{
		$post = $this->request->getPost();
		if(strpos($post['newName'], '.php') < 6 || strlen($post['newName']) < 10){
			$data = [
				"code" => 0,
				"msg" => "修改失败,新后台地址总长度必须大于10个字符，必须以.php结尾",
			];
			return json_encode($data);
		}
		if(rename(FCPATH.ADMINNAME,FCPATH.$post['newName']))
		{
			$data = [
				"code" => 1,
				"msg" => "修改成功，请牢记当前后台地址，并定期修改",
				"newName" => $post['newName'],
			];
		}else{
			$data = [
				"code" => 0,
				"msg" => "修改失败",
			];
		}
		return json_encode($data);
	}
}