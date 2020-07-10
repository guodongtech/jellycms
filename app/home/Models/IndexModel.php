<?php
namespace App\Models;
use CodeIgniter\Model;

class IndexModel extends Model
{
    public function getDefaultArea()
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['is_default'=>1])
							->get()
							->getRowArray();
        return $result['id'];
    }
    public function getCompany($area_id)
    {
		$builder = $this->db->table('company');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }
    public function getSite($area_id)
    {
		$builder = $this->db->table('site');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }
    public function getSorts($area_id)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'status'=>1, 'area_id'=>$area_id])
							->get()
							->getResultArray();
        return $result;
    }
    public function getSortByPid($pid)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$pid])
							->get()
							->getResultArray();
        return $result;
    }
	
	public function getContent($id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.id as sort_id')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'content.id'=>$id])
							->get()
							->getRowArray();
		return $result;
	}
	public function getPageContent($sort_id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'sorts_id'=>$sort_id])
							->get()
							->getRowArray();
        return $result;
	}

	public function getSortById($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.status'=>1, 'sorts.id'=>$id])
							->get()
							->getRowArray();
        return $result;
	}
	
	public function getList($sort_id){
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.id as sort_id, sorts.name as sort_name')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'sorts.id'=>$sort_id])
							->get()
							->getResultArray();
		return $result;
	}
	
	
	
	
	
	
	
	
	
	
}

