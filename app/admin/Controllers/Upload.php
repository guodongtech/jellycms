<?php 
namespace App\Controllers;
class Upload extends BaseController
{
	public function uploadFile()
	{
		$file = $this->request->getFile('file');
		//通过伪造 header可能存在的场景：php代码存入图片，在最终命名文件的时候不会出现.php，
		if(strpos($file->getMimeType(), 'php') || strpos($file->getMimeType(), 'jsp') || strpos($file->getMimeType(), 'asp')){
			//禁止上传可执行文件，尽管已经对目录及文件设置了0644，但依然禁止
			$data = [
				"code" => 0,
				"msg" => '非法操作，禁止上传的类型，已将此'.$this->request->getIPAddress().'列为危险IP，再次上传将封禁IP！',
			];
			return json_encode($data);
		}

		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
			$newDateFolder = date('Ymd', time());
			//不管如何伪装，getMimeType()已将能判断出的类型排除了，也就是不可能出现生成xx.php的情况。
			$newName = $file->getRandomName();
			//防止CI生成.php文件，此处可能性不大。但还是再处理一遍
			if(strpos($newName, '.php')){
				$data = [
					"code" => 0,
					"msg" => '非法操作',
				];
				return json_encode($data);
			}
			$uploadPath = FCPATH.'/static/upload/'.$newDateFolder;
			//创建目录并设置权限
			$file->move($uploadPath, $newName);
			//移动完后处理水印
			if($GLOBALS['water_status']){
				$image = Config\Services::image();
				//优先处理文字水印
				if($GLOBALS['water_text'] !== ''){
					
				}
				
			}
			
			
			
			
			$name = $file->getName();
			$data = [
				"code" => 1,
				"msg" => "上传成功",
				"data" => [
					'path' => '/static/upload/'.$newDateFolder.'/'.$name,
				],
			];
			return json_encode($data);
		}
	}
}
