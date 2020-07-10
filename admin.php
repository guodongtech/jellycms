<?php
// Valid PHP Version?
$minPHPVersion = '7.2';
if (phpversion() < $minPHPVersion)
{
	die("Your PHP version must be {$minPHPVersion} or higher to run CodeIgniter. Current version: " . phpversion());
}
define('AUTH', true);
define('ADMINNAME', basename(__FILE__));  //当前脚本名 菜单URL前缀
unset($minPHPVersion);
define('FCPATH', __DIR__ . DIRECTORY_SEPARATOR);
$pathsPath = FCPATH . 'app/admin/Config/Paths.php';
require FCPATH . 'app/Config.php'; //引入主配置文件
chdir(__DIR__);
require $pathsPath;
$paths = new Config\Paths();
$app = require rtrim($paths->systemDirectory, '/ ') . '/bootstrap.php';
$app->run();
