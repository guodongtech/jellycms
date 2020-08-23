<?php
namespace App\Controllers;
use \App\Models\UpgradeManageModel;
class UpgradeManage extends BaseController
{

    private $model;

    public function __construct()
    {
    	$this->upgradeFolder = 'static'.DIRECTORY_SEPARATOR.'upgrade'.DIRECTORY_SEPARATOR; //升级包存放位置
    	$this->model = new UpgradeManageModel();
    }
    public function index()
    {

        return view('upgradeManage.html');
    }

    public function edit()
    {
        $post = post();
		if(!$post['name'] || !$post['zipfile'] || !$post['detail'] || !$post['fit_versions'] || !$post['md5'] || !$post['description']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		unset($data['file']);
		if(!$post['id']){
			if($this->model->checkName($data['name'])){
				$rdata = [
					"code" => 0,
					"msg" => "该版本已存在",
				];
				return json_encode($rdata);					
			}
			$data['create_time'] = date('Y-m-d H:i:s',time());
		}else{
		    $data['update_time'] = date('Y-m-d H:i:s',time());
		}
		if($data['status'] == 1){
		    $data['start_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
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
		return json_encode($rdata);
    }
    public function getList()
    {
    	$list = $this->model->getList();
    	$data = [
			"code" => 0,
			"msg" => "",
			"data" => $list,
		];
		return json_encode($data);
    }
    public function del()
    {
		$id = post('id');
		if(!$id){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		if($this->model->edit($data)){
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
		return json_encode($rdata);		
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['status'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			'update_time' => date('Y-m-d H:i:s',time()),
			$post['switchName'] => (int)$post['switchValue'],
		];
		if($data['status'] == 1){
		    $data['start_time'] = date('Y-m-d H:i:s',time());
		}
		if($this->model->edit($data)){
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
		return json_encode($rdata);
    }
    public function uploadFile()
	{
		$post = post();
		$file = $this->request->getFile('file');
		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
			$mineType = $file->getMimeType();
			if(strpos($mineType, 'zip') == FALSE && $mineType != 'text/plain' ){
				$data = [
					"code" => 0,
					"msg" => '文件不合法',
				];
				return json_encode($data);
			}
			$newDateFolder = date('Ymd', time());
			$newName = $file->getRandomName();
			$path = $this->upgradeFolder.$newDateFolder.DIRECTORY_SEPARATOR;
			$file->move(FCPATH.$path, $newName);
			$data = [
				"code" => 1,
				"msg" => "上传成功",
				"data" => [
					'name' => $path.$newName,
					'md5' => md5_file(FCPATH.$path.$newName),
				],
			];
			return json_encode($data);
		}
	}
	
	public function generateDetail(){
		$post = post();
		$zipfile = $post['zipfile'];
		$list = [];
 
		$zip = zip_open(FCPATH.$zipfile);
		$i = 0;
		while($zipfile=zip_read($zip)){
			$fileName = zip_entry_name($zipfile);
			//排除空文件及文件夹
			if(strpos($fileName, '.')){
				$list[]['name'] = $fileName;
			}
			//$contents = zip_entry_read($zipfile);//取内容
			//$list[]['md5'] = md5($contents);
			zip_entry_close($zipfile);
		}
		zip_close($zip);
		//解压
/* 		if(class_exists('ZipArchive'))
		{
			if(!file_exists(FCPATH.$zipfile)){
				$data = [
					"code" => 0,
					"msg" => "文件不存在",
				];	
				return json_encode($data);
			}
			$zip = new \ZipArchive();
			if(!$zip->open(FCPATH.$zipfile)){
				$data = [
					"code" => 1,
					"msg" => "打开ZIP文件失败",
				];	
				return json_encode($data);
			}
			if(!$zip->extractTo(FCPATH.'/static/upgrade/upzip/')){
				$zip->close();
				$data = [
					"code" => 0,
					"msg" => "解压失败",
				];	
				return json_encode($data);
			}
			$zip->close();
		}
		//处理文件
		helper('filesystem');
		$map = get_filenames(FCPATH.'/static/upgrade/upzip/');
	 */

		$strDetail = '';
		//在客户端再判断一次。解压后判断MD5。不存在的文件改成添加。只要要更新的文件至少是覆盖操作。
		foreach($list as $key=>$value){
			$strDetail = $strDetail.$value['name'].",覆盖,无 \n";
		}
		$data = [
			"code" => 1,
			"msg" => '操作完成',
			"data" => trim($strDetail),
			
		];
		return json_encode($data);
	}
	
}