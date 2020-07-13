<?php
namespace App\Models;
use CodeIgniter\Model;

class SysUserModel extends Model
{
	protected $table      = 'admin';
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
		$sql = "SELECT a.*,r.name as role_name FROM ".$this->db->prefixTable('admin')." as a left join ".$this->db->prefixTable('role')." as r on a.role_id=r.id where a.status<9";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
    public function getSelect()
    {
		$sql = "SELECT id,name FROM ".$this->db->prefixTable('admin')." where status=1";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
 	public function checkUser($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('admin')." where name='".$data['name']."'";
		$result = $this->db->query($sql)->getRowArray();
        if(isset($result)){
        	return true;
        }else{
        	return false;
        }
	}
}