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
		$sql = "SELECT * FROM ".$this->db->prefixTable('menu')." where deleted=0";
		$result = $this->db->query($sql)->getResultArray();
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
		$sql = "SELECT * FROM ".$this->db->prefixTable('menu')." where pid=0 and status=1";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }

	public function edit($data){
		
		return $this->save($data);
	}
	public function getChildMenu($pid){
		$sql = "SELECT * FROM ".$this->db->prefixTable('menu')." where status<9 and pid={$pid}";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
	}









}



