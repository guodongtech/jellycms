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
		//角色 管理员状态都需正常才显示 删除角色 或者角色不可用 都不显示
		$builder = $this->db->table('admin');
		$result   = $builder->select('admin.id,admin.realname,admin.count, admin.last_login_ip, admin.status, admin.create_time, admin.name,admin.is_user_num,admin.is_wx_qr,admin.openid,role.name as role_name, create_admin.name as c_user')
							->join('role', 'role.id = admin.role_id', 'left')
							->join('admin as create_admin', 'create_admin.id = admin.create_user', 'left')
							->where(['admin.deleted'=>0,'role.deleted'=>0,'role.status'=>1])
							->get()
							->getResultArray();
        return $result;
    }
    public function getSelect()
    {
		$builder = $this->db->table('admin');
		$result   = $builder->select('id,name')
							->where(['deleted'=>0, 'status'=>1])
							->get()
							->getResultArray();
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
 	public function checkUser($name){
		$builder = $this->db->table('admin');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'name'=>$name])
							->get()
							->getRowArray();
        return $result;
	}
 	public function checkUserById($id){
		$builder = $this->db->table('admin');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'id'=>$id])
							->get()
							->getRowArray();
        return $result;
	}
}