<?php
namespace App\Controllers;
use \App\Models\UpgradeManageModel;
class UpgradeManage extends BaseController
{

    private $model;

    public function __construct()
    {
    	$this->server = 'http://www.jellycms.com/static/allversion/package/zip/'; //下载zip地址
    	$this->static_path = FCPATH.'static'.DIRECTORY_SEPARATOR;  
    	$this->zip_path = $this->static_path.'allversion'.DIRECTORY_SEPARATOR.'package'.DIRECTORY_SEPARATOR.'zip'.DIRECTORY_SEPARATOR;  // zip存放目录
    	$this->pack_path = $this->static_path.'allversion'.DIRECTORY_SEPARATOR.'package'.DIRECTORY_SEPARATOR.'package'.DIRECTORY_SEPARATOR;  // 解压包存放目录
    	$this->version_path = $this->static_path.'allversion'.DIRECTORY_SEPARATOR.'version'.DIRECTORY_SEPARATOR;  // 所有版本产品存放目录
    	$this->model = new UpgradeManageModel();
        
    }
    public function index()
    {
    	// 获取所有版本
    	$version_list = $this->model->getList();
    	// 获取目录结构
    	helper('filesystem'); //加载文件系统辅助函数
    	$path = $this->version_path;
    	$folder_list = directory_map($path, 1);
    	$data['folder_list'] = $folder_list;
    	$data['version_list'] = $version_list;
        return view('sysuptest.html',$data);
    }

    public function edit()
    {
        $post = post();
		if(!$post['version_num'] || !$post['version_path'] || !$post['prev_version_num'] || !$post['prev_version_path'] || !$post['zip_file'] || !$post['zip_download'] || !$post['description']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		unset($data['file']);
		if($data['status'] == 1){
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		// 该版本是否存在
		$check = $this->model->checkEdit($data);
		if(!$post['id']){
			if(count($check)>0){
				$rdata = [
					"code" => 0,
					"msg" => "该版本已存在",
				];
				return json_encode($rdata);	
			}
			$data['create_time'] = date('Y-m-d H:i:s',time());
			
		}else{
			if(count($check)>0 && $check[0]['id']!=$data['id']){
				$rdata = [
					"code" => 0,
					"msg" => "该版本已存在",
				];
				return json_encode($rdata);	
			}
		}
		if($this->model->edit($data)){
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
				"url" => '/'.ADMINNAME.'/sysuptest/index/',
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
			$post['switchName'] => (int)$post['switchValue'],
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
    public function uploadFile()
	{
		$post = post();
		$version = $post['version_num'];
		if(empty($version) || !isset($version)){
			$data = [
				"code" => 0,
				"msg" => '请先填写版本号',
			];
			return json_encode($data);
		}
		// 检查版本
		$check = $this->model->checkEdit($post);
		if(!$post['id'] && count($check)>0){
			$data = [
				"code" => 0,
				"msg" => '该版本已存在',
			];
			return json_encode($data);
		}

		if($post['id']>0 && count($check)>0 && $post['id']!=$check[0]['id']){
			$data = [
				"code" => 0,
				"msg" => '该版本已存在',
			];
			return json_encode($data);
		}

		$file = $this->request->getFile('file');
		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
			$name = $file->getName();
			$suffix = end(explode('.',$name));
			if($suffix != 'zip'){
				$data = [
					"code" => 0,
					"msg" => '文件不合法',
				];
				return json_encode($data);
			}
			$newName = $version.'.zip';
			$uploadPath = $this->zip_path;
			// $this->ciMkdir($uploadPath);
			if(file_exists($uploadPath.$newName)){
				@unlink($uploadPath.$newName);
			}
			//创建目录并设置权限
			$file->move($uploadPath, $newName);
			/*解压到更新包的文件夹*/
	        $folder_name = $version;  // 文件夹
	        /*解压之前，删除已重复的文件夹*/
	        $this->delFile($this->pack_path.$folder_name,true);
	        /*解压文件*/
	        $zip = new \ZipArchive();//新建一个ZipArchive的对象
	        if ($zip->open($this->zip_path.$newName) != true) {
	        	$data = [
					"code" => 0,
					"msg" => '读取压缩文件失败',
				];
				return json_encode($data);
	        }
	        if(!$this->ciMkdir($this->pack_path.$folder_name)){
	        	$data = [
					"code" => 0,
					"msg" => '创建解压目录失败',
				];
				return json_encode($data);
	        }
	        $zip->extractTo($this->pack_path.$folder_name.'/');
	        $zip->close();//关闭处理的zip文件
	        /*--end*/

			$data = [
				"code" => 1,
				"msg" => "上传成功",
				"data" => [
					'zip_download' => $this->server.$newName,
					'zip_file' => $newName,
					'zip_file_md5' => md5_file($this->zip_path.$newName),
				],
			];
			return json_encode($data);
		}
	}
	public function uploadVersionFile()
	{
		$post = post();
		$version = $post['version_num'];
		if(empty($version) || !isset($version)){
			$data = [
				"code" => 0,
				"msg" => '请先填写版本号',
			];
			return json_encode($data);
		}
		// 检查版本
		$check = $this->model->checkEdit($post);
		if(!$post['id'] && count($check)>0){
			$data = [
				"code" => 0,
				"msg" => '该版本已存在',
			];
			return json_encode($data);
		}
		if($post['id']>0 && count($check)>0 && $post['id']!=$check[0]['id']){
			$data = [
				"code" => 0,
				"msg" => '该版本已存在',
			];
			return json_encode($data);
		}
		$file = $this->request->getFile('file');
		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
	        $folder_name = $version;  // 目标文件夹
			$name = $file->getName();
			$suffix = end(explode('.',$name));
			if($suffix != 'zip'){
				$data = [
					"code" => 0,
					"msg" => '文件不合法',
				];
				return json_encode($data);
			}
			$newName = $version.'.zip';
			$uploadPath = $this->version_path;
			// $this->ciMkdir($uploadPath);
			if(file_exists($uploadPath.$newName)){
				@unlink($uploadPath.$newName);
			}
			//创建目录并设置权限
			$file->move($uploadPath, $newName);
			
	        /*解压之前，删除已重复的文件夹*/
	        $this->delFile($this->version_path.$folder_name,true);
	        /*解压文件*/
	        $zip = new \ZipArchive();//新建一个ZipArchive的对象
	        if ($zip->open($this->version_path.$newName) != true) {
	        	$data = [
					"code" => 0,
					"msg" => '读取压缩文件失败',
				];
				return json_encode($data);
	        }
	        if(!$this->ciMkdir($this->version_path.$folder_name)){
	        	$data = [
					"code" => 0,
					"msg" => '创建解压目录失败',
				];
				return json_encode($data);
	        }
	        $zip->extractTo($this->version_path.$folder_name.'/');
	        $zip->close();//关闭处理的zip文件
	        /*--end*/
	        // 上传成功 写入数据库
	        if($post['id']){
	        	$re['id'] = $post['id'];
	        }
	        $re['version_num'] = $version;
	        $re['version_path'] = $folder_name.DIRECTORY_SEPARATOR;
	        $re['create_time'] = date('Y-m-d H:i:s',time());
	        $res = $this->model->edit($re);
	        if($res < 1){
	        	$data = [
					"code" => 0,
					"msg" => '写库失败',
				];
				return json_encode($data);
	        }
	        // 删除zip文件
	        @unlink($uploadPath.$newName);

			$data = [
				"code" => 1,
				"msg" => "上传成功",
				"data" => [
					'version_path' => $folder_name.DIRECTORY_SEPARATOR,
				],
			];
			return json_encode($data);
		}
	}

	/**
     * 递归删除文件夹
     *
     * @param string $path 目录路径
     * @param boolean $delDir 是否删除空目录
     * @return boolean
     */
    function delFile($path, $delDir = FALSE)
    {
        if (!is_dir($path))
            return FALSE;
        $handle = @opendir($path);
        if ($handle) {
            while (false !== ($item = readdir($handle))) {
                if ($item != "." && $item != "..")
                    is_dir("$path/$item") ? $this->delFile("$path/$item", $delDir) : @unlink("$path/$item");
            }
            closedir($handle);
            if ($delDir) {
                return @rmdir($path);
            }
        } else {
            if (file_exists($path)) {
                return @unlink($path);
            } else {
                return FALSE;
            }
        }
    }
    // 遍历文件夹下所有文件路径
    function fileTree(&$arr_file, $directory, $dir_name='') 
	{

	    $mydir = dir($directory);
	    while($file = $mydir->read())
	    {
	        if((is_dir("$directory/$file")) AND ($file != ".") AND ($file != ".."))
	        {
	            $this->fileTree($arr_file, "$directory/$file", "$dir_name/$file");
	        }
	        else if(($file != ".") AND ($file != ".."))
	        {
	            $arr_file[] = trim("$dir_name/$file",'/');
	        }
	    }
	    $mydir->close();
	}
	    /**
     * 递归创建目录
     *
     * @param string $path 目录路径，不带反斜杠
     * @param intval $purview 目录权限码
     * @return boolean
     */
    function ciMkdir($path, $purview = 0777)
    {
        if (!is_dir($path)) {
            $this->ciMkdir(dirname($path), $purview);
            if (!mkdir($path, $purview)) {
                return false;
            }
        }
        return true;
    }
    
}