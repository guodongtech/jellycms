<?php
namespace App\Controllers;
use  \App\Models\DbModel;
class Db extends BaseController
{
	private $maxLimit     = 1500;              //设置最大读取数据条数(条)
	private $partSize     = 5000;              //分卷大小(KB)
	private $ctrlRes      = array();           //要操作的资源
	private $fileName     = null;              //当前备份数据的文件名
	private $part         = 1;                 //分卷号初始值
	private $totalSize    = 0;                 //备份数据共占字节数
	private $showMess     = false;             //展示状态信息
	private $dir          = 'backup/database'; //备份路径
	private $fPrefix      = 'jellycms';        //备份文件名前缀
	private $fExtend      = '.sql';            //备份文件扩展名
	private $tablePre     = 'jelly_';       //表前缀
	
    private $model;
    function __construct()
    {
        $this->model = new DbModel();
		$config = new \config\config();
		if(isset($config->dbbackup) && $config->dbbackup != null)
		{
			//$this->dir = FCPATH.$config->dbbackup;
			$this->dir = WRITEPATH.$config->dbbackup; //存放至缓存主目录
		}

		if(isset($config->database['DBPrefix']))
		{
			$this->tablePre = $config->database['DBPrefix'];
		}
		if(!file_exists($this->dir))
		{
			$issetDir = mkdir(iconv("UTF-8", "GBK", $this->dir),0644,true);;
			if(!$issetDir)
			{
				return $this->dir."备份目录不存在";
			}
		}
    }

    // 数据库页面
    public function index()
    {
        return view('db.html');
    }
    // 数据库页面
    public function dbManage()
    {
        return view('dbmanage.html');
    }
	//备份的文件列表
	function getList()
	{
		helper('filesystem'); //加载文件系统辅助函数
		$files = directory_map($this->dir, 1);
		$list = [];
		foreach($files as $key=>$value){
			$list[$key]['name'] = $value;
			$list[$key] = [
				'name' => $value,
				'size' => number_format(filesize($this->dir.'/'.$value)/1024,1).'KB',
				'time' => date('Y-m-d H:i:s', filemtime($this->dir.'/'.$value) )
			];
		}
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		return json_encode($data);
	}
	//删除数据备份文件
	function del()
	{
		$post = post();
		$files = $post['files'];
		foreach($files as $key=>$value)
		{
			//带路径信息的文件名为非法操作 不报错，直接返回
			if(stripos($value,'/')){
				return false;
			}
			//只允许删除sql zip文件
			if(stripos($value,'.sql')||stripos($value,'.zip')&& is_file($this->dir.'/'.$value))
			{
				unlink($this->dir.'/'.$value);
			}
			else
			{
				$data = [
					"code" => 0,
					"msg" => "非法操作！",
				];	
				return json_encode($data);
			}
		}
		$data = [
			"code" => 1,
			"msg" => "操作成功",
		];	
		return json_encode($data);
	}
	//下载文件
	function download($file)
	{
		header('Content-Type: text/html; charset=UTF-8');
		header('Content-Description: File Transfer');
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename='.basename($file));
		readfile($this->dir.'/'.$file);
	}
	//打包下载
	function packDownload()
	{
		$post = post();
		$files = $post['files'];
		if(class_exists('ZipArchive'))
		{
			$fileName = $this->fPrefix.'_'.date('Ymd_His').'.zip';
			$zip = new \ZipArchive();
			$zip->open($this->dir.'/'.$fileName,\ZIPARCHIVE::CREATE);
			foreach($files as $file)
			{
				$attachfile = $this->dir.'/'.$file;
				$zip->addFile($attachfile,basename($attachfile));
			}
			$zip->close();
			$data = [
				"code" => 1,
				"msg" => "打包已完成，单击此处下载",
				"filename" => $fileName,
			];	
			return json_encode($data);
		}
		else
		{
			$data = [
				"code" => 0,
				"msg" => "服务器不支持打包",
			];	
			return json_encode($data);
		}
	}
	
	//执行恢复
	function recovery()
	{
		$post = post();
		$files = $post['files'];
		foreach($files as $val)
		{
			$fileName = $this->dir.'/'.$val;
			$this->parseSQL($fileName);
		}
		$data = [
			"code" => 1,
			"msg" => "数据库还原完成",
		];
		return json_encode($data);
	}

	//解析备份文件中的SQL
	function parseSQL($fileName)
	{
		//忽略外键约束
		$this->db->query("SET FOREIGN_KEY_CHECKS = 0;");
		$fhandle  = fopen($fileName,'r');
		while(!feof($fhandle))
		{
			$lstr = fgets($fhandle);     //获取指针所在的一行数据
			//判断当前行存在字符
			if(isset($lstr[0]) && $lstr[0]!='#')
			{
				$prefix = substr($lstr,0,2);  //截取前2字符判断SQL类型
				switch($prefix)
				{
					case '--' :
					case '//' :
					{
						continue 2;
					}

					case '/*':
					{
						if(substr($lstr,-5) == "*/;\r\n" || substr($lstr,-4) == "*/\r\n")
							continue 2;
						else
						{
							$this->skipComment($fhandle);
							continue 2;
						}
					}

					default :
					{
						$sqlArray[] = trim($lstr);
						if(substr(trim($lstr),-1) == ";")
						{
							$sqlStr   = join($sqlArray);
							$sqlArray = array();
							$this->db->query($sqlStr);
							//回调函数
							$this->actionCallBack($fileName);
						}
					}
				}
			}
		}
		//开启外键约束
		$this->db->query("SET FOREIGN_KEY_CHECKS = 1;");
	}
	//动作执行回调函数
	function actionCallBack($mess)
	{
		//防止超时
		set_time_limit(60);
	}
	//略过注释
	function skipComment($fhandle)
	{
		$lstr = fgets($fhandle,4096);
		if(substr($lstr,-5) == "*/;\r\n" || substr($lstr,-4) == "*/\r\n")
			return true;
		else
			$this->skipComment($fhandle);
	}
	//上传备份文件
	public function upload(){
		$file = $this->request->getFile('file');
		
		if (! $file->isValid())
		{
			$data = [
				"code" => 0,
				"msg" => $file->getError(),
			];
			return json_encode($data);
		}else{ //移动文件
			//$newName = $file->getRandomName(); //此方法会自动更改后缀，此处不能用
			$newName = date('Ymd_His');
			$uploadPath = $this->dir;
			//创建目录并设置权限
			$file->move($uploadPath, $newName.'.sql');
			$name = $file->getName();
			$data = [
				"code" => 1,
				"msg" => "上传成功",
			];
			return json_encode($data);
		}
		
	}
    //表列表
    public function getTableList()
    {
		$list = $this->model->getList();
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => count($list),
			"data" => $list,
		];
		return json_encode($data);
    }
	//优化
	public function optimize(){
		$post = post();
		if($this->model->optimize($post['table'])){
			$data = [
				"code" => 1,
				"msg" => "优化完成",
			];			
		}else{
			$data = [
				"code" => 0,
				"msg" => "优化失败",
			];				
		}

		return json_encode($data);
	}
	//修复
	public function repair(){
		$post = post();
		if($this->model->repair($post['table'])){
			$data = [
				"code" => 1,
				"msg" => "优化完成",
			];
		}else{
			$data = [
				"code" => 0,
				"msg" => "优化失败",
			];
		}

		return json_encode($data);
	}

 
 
}