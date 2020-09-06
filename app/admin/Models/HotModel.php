<?php
namespace App\Models;
use CodeIgniter\Model;

class HotModel extends Model
{
    public function getList()
    {
		$builder = $this->db->table('content');
		$result   = $builder->select('content.id,content.title,content.visit,content.author, sorts.name as sorts_name')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0])
							->orderBy('content.visit', 'desc')
							->get(10)
							->getResultArray();
        return $result;
    }
    public function getRobots($page, $limit, $area_id)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('statistics');
		$res   = $builder->select('id,spider,start_time,end_time,ip,province,query_string')
							->where(['spider !='=>''])
							->orderBy('start_time', 'desc')
							->get($limit, $offset)
							->getResultArray();
		$total = $builder->select('1')
							->where(['spider !='=>''])
							->countAllResults(false);
        $result['list'] = $res;
        $result['total'] = $total;
		return $result;
    }
}