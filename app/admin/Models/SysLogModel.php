<?php
namespace App\Models;
use CodeIgniter\Model;
class SysLogModel extends Model
{
    public function getList($page, $limit)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('logs');
		$result   = $builder->select('logs.*, admin.name as create_user')
							->join('admin', 'admin.id = logs.create_user', 'left')
							->where(['logs.deleted'=>0])
							->orderBy('id', 'DESC')
							->get($limit, $offset)
							->getResultArray();
        return $result;
    }
    public function getCount()
    {
		$builder = $this->db->table('logs');
		$total = $builder->select('id')
							->where(['deleted'=>0])
							->countAllResults(false);
        return $total;
    }
	public function log($data){
		$builder = $this->db->table('logs');
		return $builder->insert($data);
	}

    public function clear()
    {
		$builder = $this->db->table('logs');
		$builder->set('deleted', '1');
		return $builder->update();
    }
}
