<?php
namespace App\Models;
use CodeIgniter\Model;
class CheckModel extends Model
{
    // 获取角色列表
    public function authCheck($controller,$action,$param='',$white)
    {
    	// 用户id
		$id = session('id');
		$name = session('adminname');
		// area_id
		$area_id = session('area_id');
		// 给白名单放行
		if(in_array($name,$white['user'])){
			return true;
		}
		$str = "'".$controller."','".$action."','".$param."'";
		if(in_array($str, $white['auth'])){
			return true;
		}
		$sql = "SELECT a.role_id,r.rules_id,r.areas_id FROM ".$this->db->prefixTable('admin')." a left join ".$this->db->prefixTable('role')." r on a.role_id=r.id where a.id=".$id;
		$res = $this->db->query($sql)->getRowArray();
		// 用户当前角色id
		$role_id = $res['role_id'];
		// areas_id
		$areas_id = $res['areas_id'];
		// rules_id
		$rules_id = $res['rules_id'];
		if(!in_array($area_id,json_decode($areas_id))){
			$err['msg'] = "您没有开通该区域权限";
			$err['code'] = "2";
			return $err;
		}
		// 查询该节点是否需要带参数验证
		$sql1 = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where controller='".$controller."' and action='".$action."' and param is not null";
		$res1 = $this->db->query($sql1)->getRowArray();
		if(empty($res1)){
			// 获取当前访问的权限节点
			$auth_sql = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where controller='".$controller."' and action='".$action."'";
			$auth_res = $this->db->query($auth_sql)->getRowArray();
			if(empty($auth_res)){
				$err['msg'] = "请先录入该功能的权限节点($controller/$action)";
				$err['code'] = 2;
			}elseif($auth_res['status'] == 0){
				$err['msg'] = "该功能已关闭";
				$err['code'] = 2;
			}elseif(!in_array($auth_res['id'],json_decode($rules_id))){
				$err['msg'] = "您没有开通该功能权限";
				$err['code'] = 2;
			}
		}else{
			// 获取当前访问的权限节点
			$auth_sql = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where controller='".$controller."' and action='".$action."' and param='".$param."'";
			$auth_res = $this->db->query($auth_sql)->getRowArray();
			if(empty($auth_res)){
				$err['msg'] = "请先录入该功能的权限节点($controller/$action)";
				$err['code'] = 2;
			}elseif($auth_res['status'] == 0){
				$err['msg'] = "该功能已关闭";
				$err['code'] = 2;
			}elseif(!in_array($auth_res['id'],json_decode($rules_id)) || $param!=$auth_res['param']){
				$err['msg'] = "您没有开通该功能权限";
				$err['code'] = 2;
			}
		}
		
		return $err;
		// print_r($res);die;
    }

   
     
}

