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
class Authconfig
{
	public $white = [
		'user'      => [
			'admin',
			'zhaojiabin',
		],
		'auth' => [				//控制器，方法，参数
			"'home','index',''",
			"'Login','index',''",
			"'Area','getList',''",
			"'Menu','getList',''",
			"'Role','getList',''",
			"'SysUser','getList',''",
			"'SysLog','getList',''",
			"'Auth','getList',''",
			"'Model','getList',''",
			"'Label','getList',''",
			"'ModelField','getList',''",
			"'Sorts','getList',''",
			"'Link','getList',''",
			"'Slide','getList',''",
			"'Form','getList',''",
			"'Tags','getList',''",
			"'Db','getList',''",
			"'Auth','rulesDeal',''",
			"'Login','logout',''",
			"'Login','capthcha',''",
			"'Login','act',''",
		],
	];
}
