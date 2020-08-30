<?php
namespace App\Models;
use CodeIgniter\Model;

class StatisticsModel extends Model
{
	//添加统计
    public function addData($data)
    {
		$builder = $this->db->table('statistics');
		$builder->insert($data);
        return $this->db->insertID();
    }
	//更新退出时间
    public function updateData($data, $id)
    {
		$builder = $this->db->table('statistics');
		$builder->where('id', $id);
		$builder->update($data);
        return 1;
    }
	//更新内容页访问量
    public function updateVisit($content_id)
    {

		$builder = $this->db->table('content');
		$builder->set('visit', 'visit+1', FALSE);
		$builder->where('id', $content_id);
		return $builder->update();
    }
	//初始化统计表
    public function initialStatistics()
    {
		$builder = $this->db->table('statistics');
		return $builder->truncate();
    }
}

