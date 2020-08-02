<?php
namespace App\Models;
use CodeIgniter\Model;

class AuthModel extends Model
{
	protected $table      = 'auth_rule';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
	// 获取权限列表
    public function getList()
    {
		$builder = $this->db->table('auth_rule');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->orderBy('sorting DESC, id ASC')
							->get()
							->getResultArray();
        return $result;
    }
    // 获取权限列表
    public function getTreeList()
    {
		$sql = "SELECT id,name as title,pid FROM ".$this->db->prefixTable('auth_rule')." where status = 1";
		$result = $this->db->query($sql)->getResultArray();
		$tree_list = $this->LayuilevelTree($result);
        return json_encode($tree_list);
    }
    public function getSelect()
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where status=1";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
	public function getChild($pid){
		$sql = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where status=1 and pid={$pid}";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
	}
	public function checkAdd($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('auth_rule')." where controller='".$data['controller']."' and action = '".$data['action']."'";
		$result = $this->db->query($sql)->getRowArray();
		if(isset($result)){
			return true;
		}else{
			return false;
		}
	}
	// 处理权限列表 为多级树结构
	public function LayuilevelTree($nodes){
	    $items = [];
	    foreach($nodes as $k=>$v){
	        $v['children']=array();
	        $items[$v['id']] = $v;
	    }
	    $tree = [];
	    foreach($items as $kk=>$vv){
	        if(isset($items[$vv['pid']])){
	            $items[$vv['pid']]['children'][] = &$items[$kk];
	        }else{
	            $tree[] = &$items[$kk];
	        }
	    }
	    return $tree;
	}
	public function rulesDeal($rules_id){
		$rules = "(".implode(",",$rules_id).")";
		$sql = "SELECT pid FROM ".$this->db->prefixTable('auth_rule')." where  pid in ".$rules;
		$result = $this->db->query($sql)->getResultArray();
		$res = array_unique(array_column($result, 'pid'));
		$diff1 = array_values(array_diff($rules_id,$res)); //只取没有下级的节点id  将被默认选中
		$diff2 = array_values(array_diff($rules_id,$diff1));//拥有儿子的节点id  将被默认展开
		return ['diff1'=>$diff1,'diff2'=>$diff2];
	}
}