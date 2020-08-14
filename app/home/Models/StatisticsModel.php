<?php
namespace App\Models;
use CodeIgniter\Model;

class StatisticsModel extends Model
{
	//检查最新可用版本信息
    public function addData($data)
    {
		$builder = $this->db->table('statistics');
		$builder->insert($data);
        return $this->db->insertID();
    }
	//检查最新可用版本信息
    public function updateData($data, $id)
    {
		$builder = $this->db->table('statistics');
		$builder->where('id', $id);
		$builder->update($data);
        return 1;
    }

}

