<?php
namespace Config;
/**
 * @copyright (c) 2015-2099 www.guodong.tech
 * @file Config.php
 * @brief 公共配置文件 模块调用使用Config命名空间
 * @author zhangteng
 * @date 2014/7/14 23:11:50
 * @version 1.0.0
 */
class Config
{
	public $database = [
		'DSN'      => '',
		'hostname' => '{DB_R_ADDRESS}', //数据库地址 本机为localhost 或127.0.0.1
		'username' => '{DB_R_USER}',	//数据库用户名
		'password' => '{DB_R_PWD}',	//数据库密码
		'database' => '{DB_R_NAME}',	//数据库名
		'DBDriver' => 'MySQLi',
		'DBPrefix' => '{TABLE_PREFIX}',	//表前缀
		'pConnect' => false,
		'cacheOn'  => false,
		'cacheDir' => '',
		'charset'  => 'utf8',
		'DBCollat' => 'utf8_general_ci',
		'swapPre'  => '',
		'encrypt'  => false,
		'compress' => false,
		'strictOn' => false,
		'failover' => [],
		'port'     => 3306,
	];
	public $dbbackup = 'backup/database';
	public $version = '3.8.1';
	public $sessionExpiration = 7200;//session超时时间 秒
	public $appTimezone = 'Asia/Shanghai';
	public $homeViewName = 'template';//home模板文件夹
	public $adminTemplateFolder = 'html';
	public $adminViewName = 'view'; 
	public $adminTheme = 'admin'; //后台模板目录在app/admin/view中
}

?>