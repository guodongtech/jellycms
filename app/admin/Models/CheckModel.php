<?php
namespace App\Models;
use CodeIgniter\Model;
class CheckModel extends Model
{
    // 获取角色列表
    public function authCheck($controller,$action,$auth_id)
    {
    	// 用户id
		$id = session('id');
		$name = session('adminname');
		// area_id
		$area_id = session('area_id');

		$sql = "SELECT a.role_id,r.rules_id,r.areas_id FROM ".$this->db->prefixTable('admin')." a left join ".$this->db->prefixTable('role')." r on a.role_id=r.id where a.id=".$id;
		$res = $this->db->query($sql)->getRowArray();

		if(!in_array($area_id,json_decode($res['areas_id']))){
			$err['msg'] = "您没有开通该区域权限";
			$err['code'] = 0;
			return $err;
		}
		if(!in_array($auth_id,json_decode($res['rules_id']))){
			$err['msg'] = "您没有该功能权限";
			$err['code'] = 0;
			return $err;
		}
		return true;
		// print_r($res);die;
    }
    public function isAuthRight($controller,$action){
    	$sql = "select * from ".$this->db->prefixTable('auth_rule')." where controller='".$controller."' and action='".$action."' and status=1 and deleted=0";
    	$res = $this->db->query($sql)->getRowArray();
    	if(empty($res) || !is_array($res)){
    		return false;
    	}else{
    		return $res['id'];
    	}
    }

   
     
}

