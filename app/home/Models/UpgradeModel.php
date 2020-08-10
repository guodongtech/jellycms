<?php
namespace App\Models;
use CodeIgniter\Model;

class UpgradeModel extends Model
{
	//检查最新可用版本信息
    public function checkAvailableMax($version)
    {
		//必须加 and 1=1否则CI会加上is null。 返回空数组，则无可用更新
		$builder = $this->db->table('upgrade_manage');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->where("FIND_IN_SET('$version',fit_versions) and 1=1")
							->orderBy('name', 'DESC')							
							->get()
							->getRowArray();
        return $result;
    }
	//获取最新版本信息
	public function getMax(){
		$builder = $this->db->table('upgrade_manage');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->orderBy('name', 'DESC')
							->get()
							->getRowArray();
        return $result;
	}
}

