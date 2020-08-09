<?php namespace App\Controllers;
use  \App\Models\UpgradeModel;

class Upgrade extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		$this->model = new UpgradeModel();
	}
	// 对外输出
	public function check($version){
 
		// 获取当前最高版本
		$maxVersion = $this->model->getMaxVersion();
		if($version == $maxVersion){
			return json_encode(['code' => 2, 'msg' => "已是最新版本"]);
		}
		// 获取用户要升级的版本信息
		$versionInfo = $this->model->getVersionInfo($version);
		if(empty($versionInfo)){
			return json_encode(['code' => 2, 'msg' => "没有检测到需要更新的内容，或联系技术支持"]);
		}

		if(!file_exists($this->zip_path.$versionInfo['zip_file'])){
			return json_encode(['code' => 2, 'msg' => "升级包缺失，请联系技术支持!"]);
		}
		// 处理更新的文件数据
        $folder_name = str_replace(".zip", "", $versionInfo['zip_file']);  // 文件夹
    /*step1  获取更新包里的文件路径*/  
    	$tree_path = $this->pack_path.$folder_name.DIRECTORY_SEPARATOR.'www';
    	$this->fileTree($file_list,$tree_path);
    /*step2  比对上个版本的原始文件*/ 
    	$prev_version_path = $this->version_path.$versionInfo['prev_version_path'].'www'.DIRECTORY_SEPARATOR;
    	foreach($file_list as $k=>$v){
    		if(file_exists($prev_version_path.$v)){
    			$version_list[$k]['filename'] = $v;
    			$version_list[$k]['type'] = "<font color='red'>覆盖</font>";
    			$version_list[$k]['curent_file_md5'] = md5_file($prev_version_path.$v);
    		}else{
    			$version_list[$k]['filename'] = $v;
    			$version_list[$k]['type'] = "新增";
    			$version_list[$k]['curent_file_md5'] = '';
    		}
    	}
    /*step3  获取sql文件名*/ 
    	helper('filesystem'); //加载文件系统辅助函数
    	$sql_file = get_filenames($this->pack_path.$folder_name.DIRECTORY_SEPARATOR.'sql');
    	if(count($sql_file)>0){
    		$data['sql_file'] = $sql_file[0];
    	}
    /*  end  */ 
    	// 整合数据
    	$data['code'] = 1;
    	$data['target_version'] = $versionInfo['version_num'];
    	$data['description'] = $versionInfo['description'];
    	$data['intro'] = "<p>小提示：</p><p>1、系统更新不会涉及前台模板及网站数据等。</p><p>2、升级将覆盖部分文件，系统会自动备份源文件在version/backup目录下</p><p>3、升级时，请先选中要升级的文件，点击【执行更新】</p>";
    	$data['max_version'] = $maxVersion;
    	$data['down_url'] = $versionInfo['zip_download'];
    	$data['zip_file_md5'] = $versionInfo['zip_file_md5'];
    	$data['upgrade'] = $version_list;
    	$data['create_time'] = $versionInfo['create_time'];
    	$data['update_time'] = $versionInfo['update_time'];
    	return json_encode($data);

	}

}
