<?php
$minPHPVersion = "7.2";
if (phpversion() < $minPHPVersion)
{
	die("Your PHP version must be {$minPHPVersion} or higher to run CodeIgniter. Current version: " . phpversion());
}
unset($minPHPVersion);
define("AUTHTHEME", true); //自动切换移动端模板
define("ENTRANCE", basename(__FILE__));  //当前脚本名
// Path to the front controller (this file)
define("FCPATH", __DIR__ . DIRECTORY_SEPARATOR);
// 文件相对于网站根目录的位置地址
$self_path = substr(htmlentities($_SERVER['PHP_SELF']), 0, strpos(htmlentities($_SERVER['PHP_SELF']), ENTRANCE));
$GLOBALS['self_path']  = rtrim($self_path,"/");

$pathsPath = FCPATH . "app/home/Config/Paths.php";
require FCPATH . "app/Config.php"; //引入主配置文件
chdir(__DIR__);
require $pathsPath;
$paths = new Config\Paths();

// Location of the framework bootstrap file.
$app = require rtrim($paths->systemDirectory, "/ ") . "/bootstrap.php";
$app->run();