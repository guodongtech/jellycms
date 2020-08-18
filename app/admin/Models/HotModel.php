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
    public function getRobots()
    {
		$builder = $this->db->table('statistics');
		$result   = $builder->select('spider,start_time,end_time,ip,province')
							->where(['spider !='=>''])
							->orderBy('start_time', 'desc')
							->get(10)
							->getResultArray();
        return $result;
    }
}