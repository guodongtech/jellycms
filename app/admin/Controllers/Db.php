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
	//执行备份
	function runTableBakup()
	{
		$post = post();
		$tables = $post['tables'];
		//循环表
		foreach($tables as $name)
		{
			
			$tableStruct = $this->createStructure($name);//生成表结构
			$sumTime     = $this->countTime($name);      //计算写入文件的总次数
			//生成表数据
			$tableData = '';
			for($time = 0;$time < $sumTime;$time++)
			{
				$offset = $time * $this->maxLimit;        //计算读取开始偏移值
				$data   = $this->getData($name,$offset);  //根据偏移值获取数据

				//数据存在
				if($data)
				{
					$tableData = "INSERT INTO `".$name."` VALUES\r\n";
				}

				foreach($data as $rs)
				{

					$tableData .= "(";
					foreach($rs as $key => $val)
					{
						if(is_int($key)) continue;
						$tableData .= '\''.addslashes(str_replace(array("\n","\r\n","\r","\t"),"",$val)).'\',';
					}
					$tableData  = rtrim($tableData,',');
					$tableData .= "),\r\n";
				}
					
				if($tableData)
				{
					$tableData  = rtrim($tableData,",\r\n");
					$tableData .= ";\r\n\r\n";
				}

				//表结构和$time次的表数据 总和
				$content = $tableStruct.$tableData;

				//判断文件是否溢出,如果溢出则分卷
				if($this->checkOverflow(strlen($content)))
				{
					$this->part+=1;
				}

				//清空数据
				$tableStruct = '';
				$tableData   = '';
				$this->writeFile($this->dir.'/'.$this->getFilename($name), $content); //写入文件
			}
			//回调函数
			$this->actionCallBack($name);
		}
		$data = [
			"code" => 1,
			"msg" => "数据库备份完成",
		];
		return json_encode($data);
	}
	//执行全部表备份
	function runDatabaseBackup()
	{
		$post = post();
		$tables = $post['tables'];
		$thisFileName = $post['thisfilename'];
		$part = $post['part'];

		//未传文件名，则为新增全量备份
		if(!$thisFileName){
			$this->getFilename('全量备份');//调用一次，设置$this->fileName
			$this->fileName = $this->fileName;
			$this->part = $part;
		}else{
			$this->fileName = $thisFileName;
		}
	
		//循环表
		foreach($tables as $name)
		{
			
			$tableStruct = $this->createStructure($name);//生成表结构
			$sumTime     = $this->countTime($name);      //计算写入文件的总次数
			//生成表数据
			$tableData = '';
			for($time = 0;$time < $sumTime;$time++)
			{
				$offset = $time * $this->maxLimit;        //计算读取开始偏移值
				$data   = $this->getData($name,$offset);  //根据偏移值获取数据

				//数据存在
				if($data)
				{
					$tableData = "INSERT INTO `".$name."` VALUES\r\n";
				}

				foreach($data as $rs)
				{

					$tableData .= "(";
					foreach($rs as $key => $val)
					{
						if(is_int($key)) continue;
						$tableData .= '\''.addslashes(str_replace(array("\n","\r\n","\r","\t"),"",$val)).'\',';
					}
					$tableData  = rtrim($tableData,',');
					$tableData .= "),\r\n";
				}
					
				if($tableData)
				{
					$tableData  = rtrim($tableData,",\r\n");
					$tableData .= ";\r\n\r\n";
				}

				//表结构和$time次的表数据 总和
				$content = $tableStruct.$tableData;
				//已存文件大小
				if(file_exists($this->dir.'/'.$this->getFilename())){
					$thisContent = filesize($this->dir.'/'.$this->getFilename());
				}else{
					$thisContent = 0;
				}
				
				//判断文件是否溢出,如果溢出则分卷
				if($this->checkOverflow(strlen($content)+$thisContent))
				{
					$this->part+=1;
				}

				//清空数据
				$tableStruct = '';
				$tableData   = '';
				$this->writeFile($this->dir.'/'.$this->getFilename(), $content); //写入文件
			}
			//回调函数
			$this->actionCallBack($name);
		}
		$data = [
			"code" => 1,
			"msg" => "数据库备份完成",
			"thisfilename" => $this->fileName,
			"part" => $this->part,
		];
		return json_encode($data);
	}
	//设置最大读取数据条数(条)
	function setMaxLimit($maxLimit)
	{
		$this->maxLimit = $maxLimit;
	}
	//写入文件
	function writeFile($fileName,$content)
	{
		helper('filesystem');
		write_file($fileName, $content, 'a+');
	}

	//检测文件是否存放的数据是否溢出
	function checkOverflow($cSize)
	{
		$this->totalSize+=$cSize;
		if($this->totalSize >= ($this->partSize<<10)*$this->part)
			return true;
		else
			return false;
	}

	//生成文件名
	function getFilename($name='')
	{
		if($this->fileName === null)
		{
			//获取当前时间:年月日_时分秒
			$nowTime = date('Ymd_His');
			$this->fileName = $this->fPrefix.'_'.$name.'_'.$nowTime.'_'.rand(1000000,9999999);
			return $this->fileName.'_'.$this->part.$this->fExtend;
		}
		else
			return $this->fileName.'_'.$this->part.$this->fExtend;
	}

	//获取分段数据(数据库)
	function getData($name,$offset=0)
	{
		//获取从$start至$limitNum这段数据
		$sql   = 'SELECT * FROM '.$name.' LIMIT '.$offset.','.$this->maxLimit;
		$data  = $this->db->query($sql)->getResultArray();
		return $data;
	}

	//计算$name数据表写入次数(数据库)
	function countTime($name)
	{
		//获取数据表总的数据条数
		$sql      = 'SELECT COUNT(*) as num FROM '.$name;
		$numArray = $this->db->query($sql)->getRowArray();
		$dataNum  = $numArray['num'];
		//计算读取的分页数
		if($dataNum > 0)
			return ceil($dataNum/$this->maxLimit);
		else
			return 1;
	}

	//创建$name数据表结构的SQL语句(数据库)
	function createStructure($name)
	{
		//获取表结构创建语句
		$tableArray  = $this->db->query('SHOW CREATE TABLE `'.$name.'`')->getRowArray();
		$tableString = $tableArray['Create Table'];
		//SQL初始化拼接字符串
		$bakContent = "DROP TABLE IF EXISTS `".$name."`;\r\n".$tableString.";\r\n\r\n";
		return $bakContent;
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
			//强制改后缀，防止上传php文件
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