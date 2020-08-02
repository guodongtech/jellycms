<?php
namespace App\Models;
use CodeIgniter\Model;

class MenuModel extends Model
{
	protected $table      = 'menu';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    public function getList()
    {
		$builder = $this->db->table('menu');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
		//转换为数组，便于前端表单填充
		foreach($result as $key=>$value){
			$result[$key]['roles_id'] = json_decode($result[$key]['roles_id'], true);
		}
        return $result;
    }
    public function getMenuListByRoleId($role_id)
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('menu')." where JSON_CONTAINS(roles_id->'$[*]', '{$role_id}', '$') and status=1 and deleted=0 order by sorting desc";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
    // 获取菜单选择列表
    public function getSelect()
    {
		$builder = $this->db->table('menu');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>0, 'status'=>1])
							->get()
							->getResultArray();
        return $result;
    }

	public function edit($data){
		
		return $this->save($data);
	}
	public function getChildMenu($pid){
		$builder = $this->db->table('menu');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$pid])
							->get()
							->getResultArray();
        return $result;
	}









}



