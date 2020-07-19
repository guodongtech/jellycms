<?php
namespace App\Models;
use CodeIgniter\Model;
use \Config;

class FileModel extends Model
{
    public function getList()
    {
		helper('filesystem'); //加载文件系统辅助函数
		$config = new \config\config();
		//home模块目录结构必须是  app/home ，home模板入口文件 index.php可能会在 app同级目录下的public里。用CI全局常量的ROOTPATH做相对位置
		$path = ROOTPATH.'..'.DIRECTORY_SEPARATOR.$config->homeViewName.DIRECTORY_SEPARATOR.$config->theme.DIRECTORY_SEPARATOR.$config->templateFolder;
		//directory_map($source_dir[, $directory_depth = 0[, $hidden = FALSE]]) $directory_depth (int) – 遍历目录量度 (0 = 完全递归, 1 = 最近目录, 等等)
		$result = directory_map($path);
        return $result;
    }
}