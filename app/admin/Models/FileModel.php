<?php
namespace App\Models;
use CodeIgniter\Model;
use \Config;

class FileModel extends Model
{
	//获取当前主题下模板文件列表
    public function getTemplateList()
    {
		$builder = $this->db->table('area');
		$area   = $builder->select('*')
							->where(['id'=>session('area_id')])
							->get()
							->getRowArray();
		helper('filesystem'); //加载文件系统辅助函数
		$config = new \config\config();
		//home模块目录结构必须是  app/home ，home模板入口文件 index.php可能会在 app同级目录下的public里。用CI全局常量的ROOTPATH做参考位置
		$path = ROOTPATH.'..'.DIRECTORY_SEPARATOR.$config->homeViewName.DIRECTORY_SEPARATOR.$area['pctheme'].DIRECTORY_SEPARATOR.$area['htmlfolder'];
		//directory_map($source_dir[, $directory_depth = 0[, $hidden = FALSE]]) $directory_depth (int) – 遍历目录量度 (0 = 完全递归, 1 = 最近目录, 等等)
		$result = directory_map($path, 1);
        return $result;
    }
	//获取主题列表
    public function getThemeList()
    {
		$builder = $this->db->table('area');
		$area   = $builder->select('*')
							->where(['id'=>session('area_id')])
							->get()
							->getRowArray();
		helper('filesystem'); //加载文件系统辅助函数
		$config = new \config\config();
		$path = ROOTPATH.'..'.DIRECTORY_SEPARATOR.$config->homeViewName;
		$result = directory_map($path, 1);
		//处理数组元素末尾 /  \  兼容window linux 目录分隔符
		foreach($result as $key=>$value){
			$result[$key] = str_replace(DIRECTORY_SEPARATOR, '', $value);
		}
        return $result;
    }
}