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
		$sql = "SELECT * FROM ".$this->db->prefixTable('auth_rule')." where status = 1";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
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
}