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
		'hostname' => '123.56.224.1', //数据库地址 本机为localhost 或127.0.0.1
		'username' => 'cms_demo_guodong',	//数据库用户名
		'password' => 'dAxfStNwWsm828Dt',	//数据库密码
		'database' => 'cms_demo_guodong',	//数据库名
		'DBDriver' => 'MySQLi',
		'DBPrefix' => 'gd_',	//表前缀
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
	public $appTimezone = 'Asia/Shanghai';
	public $theme = 'default'; //前台模板目录在/template中
	public $adminTheme = 'admin'; //后台模板目录在app/admin/view中
}
