<?php
namespace App\Models;
use CodeIgniter\Model;

class UpgradeModel extends Model
{
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

