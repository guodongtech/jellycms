<?php 
namespace App\Controllers;
class Upload extends BaseController
{
	public function uploadFile()
	{
		$file = $this->request->getFile('file');
		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
			$newDateFolder = date('Ymd', time());
			$newName = $file->getRandomName(); 
			$uploadPath = FCPATH.'/static/upload/'.$newDateFolder;
			//创建目录并设置权限
			$file->move($uploadPath, $newName);
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
