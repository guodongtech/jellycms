<?php
namespace App\Models;
use CodeIgniter\Model;
class UpgradeManageModel extends Model
{
    public function getList()
    {	
		$builder = $this->db->table('upgrade_manage');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
        return $result;
    }
    public function upgradeEdit($data){
		if(isset($data['id']) && $data['id']>0){
            $id = $data['id'];
			unset($data['id']);
            $builder = $this->db->table('upgrade_manage');
			return  $builder->where(['id'=>$id])->update($data);
            
        }else{
            $builder = $this->db->table('upgrade_manage');
            $builder->insert($data);
            return $this->db->insertID();
        }
	}
    public function checkName($name)
    {
		$builder = $this->db->table('upgrade_manage');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'name'=>$name])
							->get()
							->getRowArray();
        return $result;
    }
}
