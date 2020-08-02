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
		$builder = $this->db->table('auth_rule');
		$result   = $builder->select('id,name as title,pid')
							->where(['deleted'=>0, 'status'=>1])
							->orderBy('sorting DESC, id ASC')
							->get()
							->getResultArray();
		$tree_list = getTree($result);
        return json_encode($tree_list);
    }
    public function getSelect()
    {
		$builder = $this->db->table('auth_rule');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->orderBy('sorting DESC, id ASC')
							->get()
							->getResultArray();
		$result = getTree($result);					
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
	public function getChild($pid){
		$builder = $this->db->table('auth_rule');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$pid])
							->get()
							->getResultArray();
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