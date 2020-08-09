<?php
namespace App\Models;
use CodeIgniter\Model;
class UpgradeManageModel extends Model
{
    public function getList()
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('sysup')." where deleted=0";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
    public function edit($data){
		if(isset($data['id']) && $data['id']>0){
            $id = $data['id'];
            unset($data['id']);
            $builder = $this->db->table('sysup');
            $builder->where(['id'=>$id])->update($data);
            return $this->db->affectedRows();
        }else{
            $builder = $this->db->table('sysup');
            $builder->insert($data);
            return $this->db->insertID();
        }
	}
	public function checkEdit($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('sysup')." where version_num='".$data['version_num']."' and deleted=0";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
    public function getMaxVersion(){
		$sql = "SELECT * FROM ".$this->db->prefixTable('sysup')." where deleted=0 and status=1 order by id desc limit 1";
		$result = $this->db->query($sql)->getRowArray();
		return $result['version_num'];
	}
	public function getVersionInfo($version){
		$sql = "SELECT * FROM ".$this->db->prefixTable('sysup')." where deleted=0 and status=1 and prev_version_num = '".$version."'";
		$result = $this->db->query($sql)->getRowArray();
		return $result;
	}
}
