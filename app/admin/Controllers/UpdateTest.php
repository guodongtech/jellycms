<?php
namespace App\Controllers;
use \App\Models\SysLogModel;
class UpdateTest extends BaseController
{

    // 服务器地址
    private $server;

    // 当前版本
    private $curent_version;

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
        $this->curent_version = $this->getCmsVersion();
        $this->server = 'https://www.pbootcms.com/version/version?curent_version='.$this->curent_version;  //先随便写一个
      //  error_reporting(0);
       // $this->branch = $this->config('upgrade_branch') == '2.X.dev' ? '2.X.dev' : '2.X';
      //  $this->force = $this->config('upgrade_force') ?: 0;
        //$this->revise = $this->config('revise_version') ?: 0;
    }

    public function index()
    {
        return view('update_test.html');
    }

    // 检查更新
    public function check()
    {
        $url = $this->server; 
        // $context = stream_context_set_default(array('http' => array('timeout' => 5,'method'=>'GET')));
        // $serviceVersionList = @file_get_contents($url,false,$context);   
        // $serviceVersionList = json_decode($serviceVersionList,true);
        // 远程拉取更新数据  暂用死数据
        $serviceVersionList = $this->serviceVersionList();
        // print_r($serviceVersionList);die;
        if(!empty($serviceVersionList))
        {
            $data['msg'] = "小提示：系统更新不会涉及前台模板及网站数据等。<br>升级将覆盖部分文件，系统会自动备份源文件在data/backup目录下";
            $data['curent_version'] = $this->curent_version;
            $data['target_version'] = $serviceVersionList['target_version'];
            $data['max_version'] = $serviceVersionList['max_version'];
            $data['upgrade'] = $serviceVersionList['upgrade']; //文件列表
            /*--end*/
            return json_encode(['code' => 2, 'data' => $data]);
        }
        return json_encode(['code' => 1, 'msg' => '已是最新版']);
    }
    /**
    * 检测目录权限、当前版本的数据库是否与官方一致
    */
    public function checkAuthority(){
        $filelist = post('filelist'); // 暂不加密
        $dirs = array();
        $i = -1;
        foreach($filelist as $filename)

        {
            $tfilename = $filename;
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
            /*↓↓↓↓获取远程服务器提供的数据库更新信息↓↓↓↓*/
            // 暂时写死
            $params = $this->getDbInfo();
            if (false == $params) {
                return json_encode(['msg'=>'连接升级服务器超时，请刷新重试，或者联系技术支持！','code'=>2]);
            }
        /*↑↑↑↑获取远程服务器提供的数据库更新信息↑↑↑↑*/
            if (is_array($params)) {
                if (1 == intval($params['code'])) {
                /*------------------组合本地数据库信息----------------------*/

                    $dbtables = $this->db->query("SHOW TABLE STATUS")->getResultArray();
                    $local_database = array();
                    foreach ($dbtables as $k => $v) {
                        $table = $v['Name'];
                        if (preg_match('/^'.$this->DBPrefix.'/i', $table)) {
                            $local_database[$table] = [
                                'name'  => $table,
                                'field' => [],
                            ];
                        }
                    }
                    /*------------------end----------------------*/
                    /*------------------组合官方远程数据库信息----------------------*/
                    $info = $params['info'];
                    $info = preg_replace("#[\r\n]{1,}#", "\n", $info);
                    $infos = explode("\n", $info);
                    $infolists = [];
                    foreach ($infos as $key => $val) {
                        if (!empty($val)) {
                            $arr = explode('|', $val);
                            $infolists[$arr[0]] = $val;
                        }
                    }
                    /*------------------end----------------------*/
                    /*------------------校验数据库是否合格----------------------*/
                    foreach ([1] as $testk => $testv) {
                        // 对比数据表数量
                        if (count($local_database) < count($infolists)) {
                            $is_pass = false;
                            break;
                        }

                        // 对比数据表字段数量
                        foreach ($infolists as $k1 => $v1) {
                            $arr1 = explode('|', $v1);
                            
                            if (1 >= count($arr1)) {
                                continue; // 忽略不对比的数据表
                            }

                            $fieldArr = explode(',', $arr1[1]);
                            $table = preg_replace('/^ey_/i', $this->DBPrefix, $arr1[0]);
                            // $local_fields = Db::getFields($table); // 本地数据表字段列表
                            $local_fields =$this->db->getFieldNames($table); // 本地数据表字段列表
                            $local_database[$table]['field'] = $local_fields;
                            if (count($local_fields) < count($fieldArr)) {
                                $is_pass = false;
                                break;
                            }
                        }
                        if (false == $is_pass) break;
                    }
                    /*------------------end----------------------*/
                }elseif(2 == intval($params['code'])){
                    return json_encode(['msg'=>'官方缺少版本号'.$this->getCmsVersion().'的数据库比较文件，请第一时间联系技术支持！','code'=>2]);
                }
                if (true == $is_pass) {
                    return json_encode(['msg'=>'环境检测完成','code'=>1]);
                } else {
                    return json_encode(['msg'=>'当前数据库结构与官方不一致，请查看官方解决教程！','code'=>2]);
                }
            }
        }else{
            return json_encode(['msg'=>$msg,'code'=>2]);
        }
    }
     function getDbInfo(){
        return array(
            'code' => 1,
            'info' =>"gd_test|id,a,b,c,d,e|;;;;;|
gd_test1|id,a,b,c,d,e|;;;;;|",
        );
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
    function getCmsVersion()
    {
        $ver              = '3.8.0';
        $version_txt_path = ROOTPATH . '..\version\conf\version.txt';
        if (file_exists($version_txt_path)) {
            $fp      = fopen($version_txt_path, 'r');
            $content = @fread($fp, filesize($version_txt_path));
            fclose($fp);
            $ver = $content ? $content : $ver;
            // echo $ver;die;
        } else {
            $r = $this->ciMkdir(dirname($version_txt_path));
            if ($r) {
                $fp = fopen($version_txt_path, "w+") or die("请设置" . $version_txt_path . "的权限为777");
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
    public function serviceVersionList(){

        return Array
        (
            'id' => '156',
            'target_version' => '3.8.1',
            'down_url' => 'http://service.eyoucms.com/uploads/package/20200730/151423/1-200I01514235K.zip',
            'file_md5' => '86ba8daa088a963405eee40ab3c067ad',
            'file_size' => '1174773',
            'sql_file' => Array
                (
                    '0' => 'v1.4.7.1.sql'
                ),
            'intro' => "&lt;font color=&quot;red&quot;&gt;'安全'修复存在SQL注入的漏洞；&lt;/font&gt;
            &lt;font color=&quot;red&quot;&gt;'安全'修复存在命令执行的漏洞；&lt;/font&gt;
            &lt;font color=&quot;red&quot;&gt;'安全'修复个别功能存在安全隐患的漏洞；&lt;/font&gt;
            [新增]视频付费播放功能；
            [新增]会员中心支持图集模型的投稿；
            [新增]后台tag标签管理的每个tag标签的seo信息；
            [新增]补充个别文档列表遗漏的批量审核；
            [新增]批量新增/删除文档属性的功能；
            [新增]下载模型与会员等级关联的下载次数限制逻辑；",
            'notice' => '&lt;font color=&quot;red&quot;&gt;小提示：系统更新不会涉及前台模板及网站数据等。&lt;/font&gt;',
            'tips' => "检测到新版本'点击查看'",
            'upgrade_title' => '升级将覆盖以下文件，系统会自动备份源文件在version/backup目录下',
            'upgrade' => Array
                (
                    '0' => 'version/conf/version.txt',
                    '1' => 'version/sqldata/version.sql',
                    '2' => 'version/sqldata/version1.sql',
                    '3' => 'version/sqldata/version2.sql',
                ),
            'status' => 1,
            'add_time' => '1595821031',
            'update_time' => '1596100252',
            'max_version' => '3.8.1',
        );
        

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
    function ciMkdir($path, $purview = 0777)
    {
        if (!is_dir($path)) {
            ciMkdir(dirname($path), $purview);
            if (!mkdir($path, $purview)) {
                return false;
            }
        }
        return true;
    }

    // 执行下载
    public function down()
    {
        if (! ! $list = get('list')) {
            if (! is_array($list)) { // 单个文件转换为数组
                $list = array(
                    $list
                );
            }
            $len = count($list) ?: 0;
            foreach ($list as $value) {
                // 过滤掉相对路径
                $value = preg_replace_r('{\.\.(\/|\\\\)}', '', $value);
                // 本地存储路径
                $path = RUN_PATH . '/upgrade' . $value;
                // 自动创建目录
                if (! check_dir(dirname($path), true)) {
                    json(0, '目录写入权限不足，无法下载升级文件！' . dirname($path));
                }
                
                // 定义执行下载的类型
                $types = '.zip|.rar|.doc|.docx|.ppt|.pptx|.xls|.xlsx|.chm|.ttf|.otf|';
                $pathinfo = explode(".", basename($path));
                $ext = end($pathinfo); // 获取扩展
                if (preg_match('/\.' . $ext . '\|/i', $types)) {
                    $result = $this->getServerDown('/release/' . $this->branch . $value, $path);
                } else {
                    $result = $this->getServerFile($value, $path);
                }
            }
            if ($len == 1) {
                json(1, "更新文件 " . basename($value) . " 下载成功!");
            } else {
                json(1, "更新文件" . basename($value) . "等文件全部下载成功!");
            }
        } else {
            json(0, '请选择要下载的文件！');
        }
    }

    // 执行更新
    public function update()
    {
        if ($_POST) {
            if (! ! $list = post('list')) {
                $list = explode(',', $list);
                $backdir = date('YmdHis');
                
                // 分离文件
                foreach ($list as $value) {
                    // 过滤掉相对路径
                    $value = preg_replace_r('{\.\.(\/|\\\\)}', '', $value);
                    
                    if (stripos($value, '/script/') === 0 && preg_match('/\.sql$/i', $value)) {
                        $sqls[] = $value;
                    } else {
                        $path = RUN_PATH . '/upgrade' . $value;
                        $des_path = ROOT_PATH . $value;
                        $back_path = DOC_PATH . STATIC_DIR . '/backup/upgrade/' . $backdir . $value;
                        if (! check_dir(dirname($des_path), true)) {
                            json(0, '目录写入权限不足，无法正常升级！' . dirname($des_path));
                        }
                        if (file_exists($des_path)) { // 文件存在时执行备份
                            check_dir(dirname($back_path), true);
                            copy($des_path, $back_path);
                        }
                        
                        // 如果后台入口文件修改过名字，则自动适配
                        if (stripos($path, 'admin.php') !== false && stripos($_SERVER['SCRIPT_FILENAME'], 'admin.php') === false) {
                            if (file_exists($_SERVER['SCRIPT_FILENAME'])) {
                                $des_path = $_SERVER['SCRIPT_FILENAME'];
                            }
                        }
                        
                        $files[] = array(
                            'sfile' => $path,
                            'dfile' => $des_path
                        );
                    }
                }
                
                // 更新数据库
                if (isset($sqls)) {
                    $db = new DatabaseController();
                    switch (get_db_type()) {
                        case 'sqlite':
                            copy(DOC_PATH . $this->config('database.dbname'), DOC_PATH . STATIC_DIR . '/backup/sql/' . date('YmdHis') . '_' . basename($this->config('database.dbname')));
                            break;
                        case 'mysql':
                            $db->backupDB();
                            break;
                    }
                    sort($sqls); // 排序
                    foreach ($sqls as $value) {
                        $path = RUN_PATH . '/upgrade' . $value;
                        if (file_exists($path)) {
                            $sql = file_get_contents($path);
                            if (! $this->upsql($sql)) {
                                $this->log("数据库 $value 更新失败!");
                                json(0, "数据库" . basename($value) . " 更新失败！");
                            }
                        } else {
                            json(0, "数据库文件" . basename($value) . "不存在！");
                        }
                    }
                }
                
                // 替换文件
                if (isset($files)) {
                    foreach ($files as $value) {
                        if (! copy($value['sfile'], $value['dfile'])) {
                            $this->log("文件 " . $value['dfile'] . " 更新失败!");
                            json(0, "文件 " . basename($value['dfile']) . " 更新失败，请重试!");
                        }
                    }
                }
                
                // 清理缓存
                path_delete(RUN_PATH . '/upgrade', true);
                path_delete(RUN_PATH . '/cache');
                path_delete(RUN_PATH . '/complite');
                path_delete(RUN_PATH . '/config');
                
                $this->log("系统更新成功!");
                json(1, '系统更新成功！');
            } else {
                json(0, '请选择要更新的文件！');
            }
        }
    }

    // 缓存文件
    private function local()
    {
        $files = $this->getLoaclList(RUN_PATH . '/upgrade');
        $files = json_decode(json_encode($files));
        foreach ($files as $key => $value) {
            $file = ROOT_PATH . $value->path;
            if (file_exists($file)) {
                $files[$key]->type = '<span style="color:Red">覆盖</span>';
                $files[$key]->ltime = date('Y-m-d H:i:s', filemtime($file));
            } else {
                $files[$key]->type = '新增';
                $files[$key]->ltime = '无';
            }
            $files[$key]->ctime = date('Y-m-d H:i:s', $files[$key]->ctime);
            $upfile[] = $files[$key];
        }
        return $upfile;
    }

    // 执行更新数据库
    private function upsql($sql)
    {
        $sql = explode(';', $sql);
        $model = new Model();
        foreach ($sql as $value) {
            $value = trim($value);
            if ($value) {
                $model->amd($value);
            }
        }
        return true;
    }

    // 获取列表
    private function getServerList()
    {
        $param = array(
            'version' => APP_VERSION . '.' . RELEASE_TIME . '.' . $this->revise,
            'branch' => $this->branch,
            'force' => $this->force,
            'site' => get_http_url(),
            'snuser' => $this->config('sn_user')
        );
        $url = $this->server . '/index.php?p=/upgrade/getlist&' . http_build_query($param);
        if (! ! $rs = json_decode(get_url($url, '', '', true))) {
            if ($rs->code) {
                if (is_array($rs->data)) {
                    return $rs->data;
                } else {
                    json(1, $rs->data);
                }
            } else {
                json(0, $rs->data);
            }
        } else {
            $this->log('连接更新服务器发生错误，请稍后再试！');
            json(0, '连接更新服务器发生错误，请稍后再试！');
        }
    }

    // 获取文件
    private function getServerFile($source, $des)
    {
        $url = $this->server . '/index.php?p=/upgrade/getFile&branch=' . $this->branch;
        $data['path'] = $source;
        $file = basename($source);
        if (! ! $rs = json_decode(get_url($url, $data, '', true))) {
            if ($rs->code) {
                if (! file_put_contents($des, base64_decode($rs->data))) {
                    $this->log("更新文件  " . $file . " 下载失败!");
                    json(0, "更新文件 " . $file . " 下载失败!");
                } else {
                    return true;
                }
            } else {
                json(0, $rs->data);
            }
        } else {
            $this->log("更新文件 " . $file . " 获取失败!");
            json(0, "更新文件 " . $file . " 获取失败!");
        }
    }

    // 获取非文本文件
    private function getServerDown($source, $des)
    {
        $url = $this->server . $source;
        $file = basename($source);
        if (($sfile = fopen($url, "rb")) && ($dfile = fopen($des, "wb"))) {
            while (! feof($sfile)) {
                $fwrite = fwrite($dfile, fread($sfile, 1024 * 8), 1024 * 8);
                if ($fwrite === false) {
                    $this->log("更新文件 " . $file . " 下载失败!");
                    json(0, "更新文件 " . $file . " 下载失败!");
                }
            }
            if ($sfile) {
                fclose($sfile);
            }
            if ($dfile) {
                fclose($dfile);
            }
            return true;
        } else {
            $this->log("更新文件 " . $file . " 获取失败!");
            json(0, "更新文件 " . $file . " 获取失败!");
        }
    }

    // 获取文件列表
    private function getLoaclList($path)
    {
        $files = scandir($path);
        foreach ($files as $value) {
            if ($value != '.' && $value != '..') {
                if (is_dir($path . '/' . $value)) {
                    $this->getLoaclList($path . '/' . $value);
                } else {
                    $file = $path . '/' . $value;
                    
                    // 避免中文乱码
                    if (! mb_check_encoding($file, 'utf-8')) {
                        $out_path = mb_convert_encoding($file, 'UTF-8', 'GBK');
                    } else {
                        $out_path = $file;
                    }
                    
                    $out_path = str_replace(RUN_PATH . '/upgrade', '', $out_path);
                    
                    $this->files[] = array(
                        'path' => $out_path,
                        'md5' => md5_file($file),
                        'ctime' => filemtime($file)
                    );
                }
            }
        }
        return $this->files;
    }

    // 比较程序本号
    private function compareVersion($sv, $cv)
    {
        if (empty($sv) || $sv == $cv) {
            return 0;
        }
        $sv = explode('.', $sv);
        $cv = explode('.', $cv);
        $len = count($sv) > count($cv) ? count($sv) : count($cv);
        for ($i = 0; $i < $len; $i ++) {
            $n1 = $sv[$i] or 0;
            $n2 = $cv[$i] or 0;
            if ($n1 > $n2) {
                return 1;
            } elseif ($n1 < $n2) {
                return 0;
            }
        }
        return 0;
    }
}