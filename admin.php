<?php
// Valid PHP Version?
$minPHPVersion = '7.2';
if (phpversion() < $minPHPVersion)
{
	die("PHP版本不能低于{$minPHPVersion}，当前PHP版本: " . phpversion());
}
define('AUTH', true);
define('ADMINNAME', basename(__FILE__));  //当前脚本名 菜单URL前缀
define('ENTRANCE', basename(__FILE__));  //当前脚本名 替换ADMINNAME
unset($minPHPVersion);
define('FCPATH', __DIR__ . DIRECTORY_SEPARATOR);
$pathsPath = FCPATH . 'app/admin/Config/Paths.php';
require FCPATH . 'app/Config.php'; //引入主配置文件
chdir(__DIR__);
require $pathsPath;
$paths = new Config\Paths();
$app = require rtrim($paths->systemDirectory, '/ ') . '/bootstrap.php';
$app->run();
