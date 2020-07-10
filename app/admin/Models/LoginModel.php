<?php
namespace App\Models;
use CodeIgniter\Model;

class LoginModel extends Model
{

    public function getAdmin($name, $passwordMd5)
    {
		if($name =='' || $passwordMd5 ==''){
			return 0;
		}
		$sql = "SELECT * FROM ".$this->db->prefixTable('admin')." where name='{$name}' and password='{$passwordMd5}'";
		$result = $this->db->query($sql)->getRowArray();
        return $result;
    }
	
	public function getMenu($role_id){
		$sql = "SELECT * FROM ".$this->db->prefixTable('menu')." where JSON_CONTAINS(roles_id->'$[*]', '{$role_id}', '$')";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
	}
	public function getArea($role_id){
		//$sql = "SELECT * FROM ".$this->db->prefixTable('area')." where JSON_CONTAINS(roles_id->'$[*]', '{$role_id}', '$') and is_default=1";
		//$result = $this->db->query($sql)->getRowArray();
      //  return $result;
	}
}