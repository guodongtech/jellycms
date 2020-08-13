<?php 
namespace App\Controllers;
class Upload extends BaseController
{
	public function uploadFile()
	{
		$file = $this->request->getFile('file');
		$mineType = $file->getMimeType();
		//通过伪造 header可能存在的场景：php代码存入图片，在最终命名文件的时候不会出现.php，
		if(strpos($mineType, 'php') !== FALSE || strpos($mineType, 'jsp')!== FALSE || strpos($mineType, 'asp')!== FALSE){
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
			$name = $file->getName();
			$waterImage = $uploadPath.'/'.$name;
			//移动完后处理水印
			if($GLOBALS['water_status']&&strpos($mineType, 'image') !== FALSE){
				$position = $this->calcCropCoords($GLOBALS['water_position']);
				//优先处理文字水印
				if($GLOBALS['water_text'] !== ''){
					$image = \Config\Services::image()->withFile($waterImage);
					$image->text($GLOBALS['water_text'], [
								'color'      => $GLOBALS['water_color'],
								'opacity'    => $GLOBALS['water_opacity'],
								'withShadow' => false,
								'hAlign'     => $position['hAlign'],
								'vAlign'     => $position['vAlign'],
								'fontSize'   => 20,
								'fontPath'   => FCPATH.$GLOBALS['water_font'],
							])->save($waterImage);
				}else if($GLOBALS['water_pic'] !== ''){
					$image = \Config\Services::image()->withFile($waterImage);
					$image->imageWaterMark(FCPATH.$GLOBALS['water_pic'], [
						'opacity'    => $GLOBALS['water_opacity'],
						'hAlign'     => $position['hAlign'],
						'vAlign'     => $position['vAlign'],
						'proportion'     => $GLOBALS['water_proportion'],
					])->save($waterImage);
		
				}
				
			}
			
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
	
	protected function calcCropCoords($position)
	{
		$position = strtolower($position);
		switch ($position)
		{
			case 'top-left':
				$hAlign = 'left';
				$vAlign = 'top';
				break;
			case 'top':
				$hAlign = 'center';
				$vAlign = 'top';
				break;
			case 'top-right':
				$hAlign = 'right';
				$vAlign = 'top';
				break;
			case 'left':
				$hAlign = 'left';
				$vAlign = 'middle';
				break;
			case 'center':
				$hAlign = 'center';
				$vAlign = 'middle';
				break;
			case 'right':
				$hAlign = 'right';
				$vAlign = 'middle';
				break;
			case 'bottom-left':
				$hAlign = 'left';
				$vAlign = 'bottom';
				break;
			case 'bottom':
				$hAlign = 'center';
				$vAlign = 'bottom';
				break;
			case 'bottom-right':
				$hAlign = 'right';
				$vAlign = 'bottom';
				break;
		}

		return [
			'hAlign' => $hAlign,
			'vAlign' => $vAlign,
		];
	}
	public function ueUpload($type){
		$file = $this->request->getFile('upfile');
		$mineType = $file->getMimeType();
		//通过伪造 header可能存在的场景：php代码存入图片，在最终命名文件的时候不会出现.php，
		if(strpos($mineType, 'php') !== FALSE || strpos($mineType, 'jsp')!== FALSE || strpos($mineType, 'asp')!== FALSE){
			//禁止上传可执行文件，尽管已经对目录及文件设置了0644，但依然禁止
			$data = [
				"state" => '非法操作，禁止上传的类型，已将此'.$this->request->getIPAddress().'列为危险IP，再次上传将封禁IP！',
			];
			return json_encode($data);
		}
		if (! $file->isValid())
		{
			$data = [
				"state" => $file->getError(),
			];
			return json_encode($data);
		}else{
			$newDateFolder = date('Ymd', time());
			//不管如何伪装，getMimeType()已将能判断出的类型排除了，也就是不可能出现生成xx.php的情况。
			$newName = $file->getRandomName();
			//防止CI生成.php文件，此处可能性不大。但还是再处理一遍
			if(strpos($newName, '.php')){
				$data = [
					"state" => '非法操作',
				];
				return json_encode($data);
			}
			if($type == 'uploadimage'){
				$uploadPath = 'ueditor/php/upload/image/'.$newDateFolder;
				$title = "图片";
			}elseif($type == 'uploadfile'){
				$uploadPath = 'ueditor/php/upload/file/'.$newDateFolder;
				$title = "附件";
			}elseif($type == 'uploadvideo'){
				$uploadPath = 'ueditor/php/upload/video/'.$newDateFolder;
				$title = "视频";
			}
			
			//创建目录并设置权限
			$file->move($uploadPath, $newName);
			$result = [
                'state' => 'SUCCESS',
                'url' => "/".$uploadPath.'/'.$newName,
                'title' => $title,
                'original' => ''
            ];

            return json_encode($result);
		}

	}
	
}
