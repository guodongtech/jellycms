<?php
namespace App\Models;
use CodeIgniter\Model;

class LinkModel extends Model
{
	protected $table      = 'link';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    public function getList($page, $limit)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('link');
		$res   = $builder->select('link.*, link_group.name as group_name')
							->join('link_group', 'link_group.id = link.group_id', 'left')
							->where(['link.deleted'=>0,'link.status'=>1])
							->get($limit, $offset)
							->getResultArray();
							
		$total = $builder->select('link.*, link_group.name as group_name')
							->join('link_group', 'link_group.id = link.group_id', 'left')
							->where(['link.deleted'=>0,'link.status'=>1])
							->countAllResults(false);					
        $result['list'] = $res;
        $result['total'] = $total;
		return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
}