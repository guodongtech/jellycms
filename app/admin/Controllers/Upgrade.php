<?php
namespace App\Controllers;
use \App\Models\SysLogModel;
use \config;
class Upgrade extends BaseController
{

    // 服务器地址  获取更新内容
    private $upgradeUrl;

    // 当前版本
    private $currentVersion;
    // 版本文件路径
    private $versionPath;
    // 下载到
    private $downloadPath;
    // 备份到
    private $backupPath;
    // 更新分支
    private $branch;

    // 强制同步文件
    private $force;

    // 修改版本
    private $revise;

    // 文件列表
    public $files = array();

    public function __construct()
    {
        $config = new \Config\Config();
        $this->rootPath = FCPATH;
        $this->versionPath = $this->rootPath.'version'.DIRECTORY_SEPARATOR.'conf'.DIRECTORY_SEPARATOR.'version.txt'; // 版本文件路径
        $this->currentVersion = $this->getCmsVersion();
		$this->upgradeUrl = 'http://cms-demo.guodong.tech/index.php/upgrade/check/'.$this->currentVersion;
        $this->prefix = $config->database['DBPrefix'];
        $this->downloadPath = $this->rootPath.'version'.DIRECTORY_SEPARATOR.'download'.DIRECTORY_SEPARATOR;
        $this->backupPath = $this->rootPath.'version'.DIRECTORY_SEPARATOR.'backup'.DIRECTORY_SEPARATOR;
    }
    public function index()
    {
        return view('update_test.html');
    }
    public function getList()
    {
        $serverResult = $this->getUpgradeData();
		print_r($serverResult);
        if($serverResult === false){
            $data = [
                "code" => 0,
                "msg" => '请求远程服务器失败',
                "data" => '',
            ];
            return json_encode($data);
        }
        if($serverResult['code'] != 1){
            $data = [
                "code" => 0,
                "msg" => $serverResult['msg'],
                "data" => '',
            ];
            return json_encode($data);
        }
        $upgradeList = $serverResult['upgrade'];
        foreach($upgradeList as $k=>$v){
            $upgradeList[$k]['update_time'] = $serverResult['update_time'];
            if(!file_exists($this->rootPath.$v['filename'])){
                $upgradeList[$k]['is_same'] = '';
                continue;
            }
            // 校验文件MD5
            if(md5_file($this->rootPath.$v['filename']) == $v['curent_file_md5']){
                $upgradeList[$k]['is_same'] = '一致';
            }else{
                $upgradeList[$k]['is_same'] = '不一致';
            }
        }
        $data = [
            "code" => 0,
            "msg" => $serverResult['msg'],
            "data" => $upgradeList,
        ];
        return json_encode($data);
    }
    // 获取官方更新数据 
    public function getUpgradeData(){
      $url = $this->upgradeUrl; 
        $context = stream_context_set_default(array('http' => array('timeout' => 5,'method'=>'GET')));
        $result = @file_get_contents($url,false,$context);
        if($result == false){
            return false;
        }
        $result = json_decode($result,true);
        if(!is_array($result)){
            return false;
        }
        return $result;
    }
    // 检查更新
    public function check()
    {
        // 远程拉取更新数据 
       $serverResult = $this->updateList;
       if($serverResult === false){
            return json_encode(['code' => 1, 'msg' => '请求远程服务器失败']);
       }
       if($serverResult['code'] != 1){
            return json_encode(['code' => 1, 'msg' => $serverResult['msg']]);
       }

        if(!empty($serverResult))
        {
            $data['msg'] = "<style>.clear {text-indent:25px;font-size: 14px;line-height: 24px;}</style><div class='clear'>".$serverResult['intro'].$serverResult['description']."</div>";
            $data['currentVersion'] = $this->currentVersion; //当前版本
            $data['target_version'] = $serverResult['target_version']; // 目标版本
            $data['max_version'] = $serverResult['max_version'];  // 最新版本
            $data['upgrade'] = $serverResult['upgrade']; //文件列表
            /*--end*/
            return json_encode(['code' => 2, 'data' => $data]);
        }
        return json_encode(['code' => 1, 'msg' => '当前已是最新版']);
    }
    /**
    * 检测目录权限、当前版本的数据库是否与官方一致
    */
    public function checkAuthority(){
        // 远程拉取更新数据 
       $serverResult = $this->getUpgradeData();
       if($serverResult === false){
            return json_encode(['code' => 2, 'msg' => '请求远程服务器失败']);
       }
       if($serverResult['code'] != 1){
            return json_encode(['code' => 2, 'msg' => $serverResult['msg']]);
       }
        $serverResult['upgrade'] = post('filelist');
        $filelist = $serverResult['upgrade'];
        $dirs = array();
        $i = -1;
        foreach($filelist as $filename)

        {
            $tfilename = $filename['filename']; 
            //取文件路径
            $curdir = $this->GetDirName($tfilename);
            if (empty($curdir)) {
                continue;
            }
            if( !isset($dirs[$curdir]) ) 
            {
                $dirs[$curdir] = $this->TestIsFileDir($curdir);
            }

            if($dirs[$curdir]['isdir'] == FALSE) 
            {
                continue;
            }
            else {
                @$this->ciMkdir($curdir, 0777);
                $dirs[$curdir] = $this->TestIsFileDir($curdir);
            }
            $i++;
        }
        $is_pass = true;
        $msg = '检测通过';
        if($i > -1)
        {
            $n = 0;
            $dirinfos = '';
            foreach($dirs as $curdir)
            {
                $dirinfos .= $curdir['name']."&nbsp;&nbsp;状态：";
                if ($curdir['writeable']) {
                    $dirinfos .= "[√正常]";
                } else {
                    $is_pass = false;
                    $n++;
                    $dirinfos .= "<font color='red'>[×不可写]</font>";
                }
                $dirinfos .= "<br />";
            }
            $title = "本次升级需要在下面文件夹写入更新文件，已检测站点有 <font color='red'>{$n}</font> 处没有写入权限：<br />";
            $title .= "<font color='red'>问题分析（如有问题，请咨询技术支持）：<br />";
            $title .= "1、检查站点目录的用户组与所有者，禁止是 root ;<br />";
            $title .= "2、检查站点目录的读写权限，一般权限值是 0755 ;<br />";
            $title .= "</font>涉及更新目录列表如下：<br />";
            $msg = $title . $dirinfos;
        }
        if($is_pass == true){
            return json_encode(['msg'=>'环境检测完成','code'=>1]);
        }else{
            return json_encode(['msg'=>$msg,'code'=>2]);
        }
    }
    /**
     * 执行更新
     */
    public function Upgrade(){
        error_reporting(0);//关闭所有错误报告
        $allow_url_fopen = ini_get('allow_url_fopen');
        if (!$allow_url_fopen) {
            return json_encode(['code' => 0, 'msg' => "请联系空间商，设置 php.ini 中参数 allow_url_fopen = 1"]);
        }     
               
        if (!extension_loaded('zip')) {
            return json_encode(['code' => 0, 'msg' => "请联系空间商，开启 php.ini 中的php-zip扩展"]);
        }

        $serverResult = $this->updateList;
        if (false === $serverResult) {
            return json_encode(['code' => 0, 'msg' => "无法连接远程升级服务器！"]);
        } else {
            if (empty($serverResult)) {
                return json_encode(['code' => 0, 'msg' => "当前没有可升级的版本！"]);
            }
        }
        // 放入选中文件
        $serverResult['upgrade'] = post('filelist');

        clearstatcache(); // 清除文件夹权限缓存
        if (!is_writeable($this->versionPath)) {
            return json_encode(['code' => 0, 'msg' => '文件'.$this->versionPath.' 不可写，不能升级!!!']);
        }
        /*--end*/
        /* 下载更新包到backup/download*/
        $result = $this->downloadFile($serverResult['down_url'], $serverResult['zip_file_md5']);
        if (!isset($result['code']) || $result['code'] != 1) {
            return json_encode($result);
        }
        /*解压到更新包的文件夹*/
        $DownFileName = explode('/', $serverResult['down_url']);    
        $DownFileName = end($DownFileName);
        $folderName = str_replace(".zip", "", $DownFileName);  // 文件夹

        // 将所有文件放进一维数组，解压时用
        $zip_file_list = array();
        foreach($serverResult['upgrade'] as $k=>$v){
            $zip_file_list[] = 'www/'.$v['filename'];
        }
        /*--end*/
        /*解压之前，删除已重复的文件夹*/
        $this->delFile($this->downloadPath.$folderName);
        /*--end*/

        /*解压文件*/
        $zip = new \ZipArchive();//新建一个ZipArchive的对象
        if ($zip->open($this->downloadPath.$DownFileName) != true) {
            return json_encode(['code' => 0, 'msg' => "升级包读取失败!"]);
        }
        // for($i; $i<$zip->numFiles;$i++){
        //     echo $zip->getNameIndex($i)."<br>";
        // }
        // die;
        $zip->extractTo($this->downloadPath.$folderName.'/',$zip_file_list);//解压缩到在当前路径下backup文件夹内
        $zip->close();//关闭处理的zip文件
        /*--end*/
        /*升级之前，备份涉及的源文件*/
        $upgrade = $serverResult['upgrade'];
        if (!empty($upgrade) && is_array($upgrade)) {
            foreach ($upgrade as $key => $val) {
                $source_file = $this->rootPath.$val['filename'];
                if (file_exists($source_file)) {
                    $destination_file = $this->backupPath.$this->currentVersion.'_jelly/'.$val['filename'];
                    $this->ciMkdir(dirname($destination_file));
                    $copy_bool = @copy($source_file, $destination_file);
                    if (false == $copy_bool) {
                        return json_encode(['code' => 0, 'msg' => "更新前备份文件失败，请检查所有目录是否有读写权限"]);
                    }
                }
            }
        }
        /*--end*/

        /*升级的 sql文件*/
        if(!empty($serverResult['sql_file']))
        {
            //读取数据文件
            $sqlpath = $this->downloadPath.$folderName.'/sql/'.trim($serverResult['sql_file']);
            $execute_sql = file_get_contents($sqlpath);
            $sqlFormat = $this->sql_split($execute_sql, $this->prefix);
            /**
             * 执行SQL语句
             */
            try {
                $counts = count($sqlFormat);

                for ($i = 0; $i < $counts; $i++) {
                    $sql = trim($sqlFormat[$i]);

                    if (stristr($sql, 'CREATE TABLE')) {
                        $this->db->query($sql);
                    } else {
                        if(trim($sql) == '')
                           continue;
                        $this->db->query($sql);
                    }
                }
            } catch (\Exception $e) {
                return json_encode(['code' => -2, 'msg' => "数据库执行中途失败，请查看官方解决教程，否则将影响后续的版本升级！"]);
            }
        } 
        /*--end*/
        // 递归复制文件夹 
        $copy_data = $this->recurseCopy($this->downloadPath.$folderName.'/www', rtrim($this->rootPath, '/'), $folderName);
        /*覆盖自定义后台入口文件*/
        // $login_php = 'admin.php';
        // $rootLoginFile = $this->downloadPath.$folderName.'/www/'.$login_php;
        // if (file_exists($rootLoginFile)) {
        //     $adminbasefile = preg_replace('/^(.*)\/([^\/]+)$/i', '$2', request()->baseFile());
        //     if ($login_php != $adminbasefile && is_writable($this->root_path.$adminbasefile)) {
        //         if (!@copy($rootLoginFile, $this->root_path.$adminbasefile)) {
        //             return ['code' => 0, 'msg' => "更新入口文件失败，请第一时间请求技术支持，否则将影响部分功能的使用！"];
        //         }
        //         @unlink($this->root_path.$login_php);
        //     } 
        // }
        /*--end*/
        /*修改版本文件 version.txt*/
        $r = $this->ciMkdir(dirname($this->versionPath));
        if ($r) {
            $fp = fopen($this->versionPath, "w+") or die("请设置" . $this->versionPath . "的权限为777");
            $web_version = $serverResult['target_version'];
            $ver         = !empty($web_version) ? $web_version : $ver;
            if (fwrite($fp, $ver)) {
                fclose($fp);
            }
        }
        /*--end*/   

        /*删除下载的升级包*/
        $ziplist = glob($this->downloadPath.'*.zip');
        @array_map('unlink', $ziplist);
        /*--end*/
        // 推送回服务器  记录升级成功
        // $this->UpgradeLog($serviceVersion['key_num']);
        
        return json_encode(['code' => $copy_data['code'], 'msg' => "升级成功{$copy_data['msg']}"]); //code 1 成功  2失败

    }
    /**     
     * @param type $fileUrl 下载文件地址
     * @param type $md5File 文件MD5 加密值 用于对比下载是否完整
     * @return string 错误或成功提示
     */
    private function downloadFile($fileUrl,$md5File)
    {
        $downFileName = explode('/', $fileUrl);
        $downFileName = end($downFileName);
        $saveDir = $this->downloadPath.$downFileName; // 保存目录
        $this->ciMkdir(dirname($saveDir));
        $content = @file_get_contents($fileUrl, 0, null, 0, 1);
        if (false === $content) {                 
            $fileUrl = str_replace('http://', 'https://', $fileUrl);
            $content = @file_get_contents($fileUrl, 0, null, 0, 1);
        }

        if(!$content){
            return ['code' => 0, 'msg' => '官方升级包不存在']; // 文件存在直接退出
        }
        if (!stristr($fileUrl, 'https://')) {
            $ch = curl_init($fileUrl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
            $file = curl_exec ($ch);
        } else {
            $file = httpRequest($fileUrl);
        }

        if (preg_match('#__HALT_COMPILER()#i', $file)) {
            return ['code' => 0, 'msg' => '下载包损坏，请联系官方客服！'];
        }
        curl_close ($ch);                                                            
        $fp = fopen($saveDir,'w');
        fwrite($fp, $file);
        fclose($fp);
        if(!$this->eyPreventShell($saveDir) || !file_exists($saveDir) || $md5File != md5_file($saveDir))
        {
            return ['code' => 0, 'msg' => '下载保存升级包失败，请检查所有目录的权限以及用户组不能为root'];
        }
        return ['code' => 1, 'msg' => '下载成功'];
    }
     /**
     * 获取文件的目录路径
     * @param string $filename 文件路径+文件名
     * @return string
     */
    private function GetDirName($filename)
    {
        $dirname = preg_replace("#[\\\\\/]{1,}#", '/', $filename);
        $dirname = preg_replace("#([^\/]*)$#", '', $dirname);
        return $dirname;
    }
    /**
     * 获取当前CMS版本号
     *
     * @return string
     */
    public function getCmsVersion()
    {
        $ver              = '3.8.0';
        $versionPath = $this->versionPath;
        if (file_exists($versionPath)) {
            $fp      = fopen($versionPath, 'r');
            $content = @fread($fp, filesize($versionPath));
            fclose($fp);
            $ver = $content ? $content : $ver;
            // echo $ver;die;
        } else {
            $r = $this->ciMkdir(dirname($versionPath));
            if ($r) {
                $fp = fopen($versionPath, "w+") or die("请设置" . $versionPath . "的权限为777");
                // 读缓存 数据库 暂时写死
                $web_version = '3.8.1';
                $ver         = !empty($web_version) ? $web_version : $ver;
                if (fwrite($fp, $ver)) {
                    fclose($fp);
                }
            }

        }
        return $ver;
    }
    /**
     * 测试目录路径是否有读写权限
     * @param string $dirname 文件目录路径
     * @return array
     */
    private function TestIsFileDir($dirname)
    {
        $dirs = array('name'=>'', 'isdir'=>FALSE, 'writeable'=>FALSE);
        $dirs['name'] =  $dirname;
        $this->ciMkdir($dirname);
        if(is_dir($dirname))
        {
            $dirs['isdir'] = TRUE;
            $dirs['writeable'] = $this->TestWriteAble($dirname);
        }
        return $dirs;
    }
    /**
     * 测试目录路径是否有写入权限
     * @param string $d 目录路劲
     * @return boolean
     */
    private function TestWriteAble($d)
    {
        $tfile = '_jelly.txt';
        $fp = @fopen($d.$tfile,'w');
        if(!$fp) {
            return false;
        }
        else {
            fclose($fp);
            $rs = @unlink($d.$tfile);
            return true;
        }
    }
    /**
     *  过滤换行回车符
     *
     * @param     string $str 字符串信息
     * @return    string
     */
    function filterLineReturn($str = '', $replace = '')
    {
        return str_replace(PHP_EOL, $replace, $str);
    }
    /**
     * 递归创建目录
     *
     * @param string $path 目录路径，不带反斜杠
     * @param intval $purview 目录权限码
     * @return boolean
     */
    function ciMkdir($path, $purview = 0644)
    {
        if (!is_dir($path)) {
            $this->ciMkdir(dirname($path), $purview);
            if (!mkdir($path, $purview)) {
                return false;
            }
        }
        return true;
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
    private function sql_split($sql, $tablepre) {

        if ($tablepre != "gd_")
            $sql = str_replace("`gd_", '`'.$tablepre, $sql);
              
        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }
    /**
     * 自定义函数递归的复制带有多级子目录的目录
     * 递归复制文件夹
     *
     * @param string $src 原目录
     * @param string $dst 复制到的目录
     * @param string $folderName 存放升级包目录名称
     * @return string
     */                        
    //参数说明：            
    //自定义函数递归的复制带有多级子目录的目录
    private function recurseCopy($src, $dst, $folderName)
    {
        static $badcp = 0; // 累计覆盖失败的文件总数
        static $n = 0; // 累计执行覆盖的文件总数
        static $total = 0; // 累计更新的文件总数
        $dir = opendir($src);
        $this->ciMkdir($dst);
        while (false !== $file = readdir($dir)) {
            if (($file != '.') && ($file != '..')) {
                if (is_dir($src . '/' . $file)) {
                    $this->recurseCopy($src . '/' . $file, $dst . '/' . $file, $folderName);
                }
                else {
                    if (file_exists($src . DIRECTORY_SEPARATOR . $file)) {
                        $rs = @copy($src . DIRECTORY_SEPARATOR . $file, $dst . DIRECTORY_SEPARATOR . $file);
                        if($rs) {
                            $n++;
                            // 删除已copy的文件
                            // @unlink($src . DIRECTORY_SEPARATOR . $file);
                        } else {
                            $n++;
                            $badcp++;
                        }
                    } else {
                        $n++;
                    }
                    $total++;
                }
            }
        }
        closedir($dir);

        $code = 1;
        $msg = '！';
        if($badcp > 0)
        {
            $code = 2;
            $msg = "，其中失败 <font color='red'>{$badcp}</font> 个文件，<br />请从升级包目录[<font color='red'>data/download/{$folderName}/www</font>]中的取出全部文件覆盖到根目录，完成手工升级。";
        }

        $this->copySpeed($n, $total);

        return ['code'=>$code, 'msg'=>$msg];
    }

    /**
     * 复制文件进度
     */
    private function copySpeed($n, $total)
    {
        $data = false;

        if ($n < $total) {
            $this->copySpeed($n, $total);
        } else {
            $data = true;
        }
        
        return $data;
    }
    /**
     * 验证是否shell注入
     * @param mixed        $data 任意数值
     * @return mixed
     */
    function eyPreventShell($data = '')
    {
        $data = true;
        if (is_string($data) && (preg_match('/^phar:\/\//i', $data) || stristr($data, 'phar://'))) {
            $data = false;
        } else if (is_numeric($data)) {
            $data = intval($data);
        }

        return $data;
    }





}