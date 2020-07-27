<?php
namespace App\Models;
use CodeIgniter\Model;

class SlideModel extends Model
{
	protected $table      = 'slide';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    // 获取列表
    public function getList($page, $limit)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('slide');
		$res   = $builder->select('slide.*, slide_group.name as group_name')
							->join('slide_group', 'slide_group.id = slide.group_id', 'left')
							->where(['slide.deleted'=>0,'slide.status'=>1])
							->get($limit, $offset)
							->getResultArray();
							
		$total = $builder->select('slide.*, slide_group.name as group_name')
							->join('slide_group', 'slide_group.id = slide.group_id', 'left')
							->where(['slide.deleted'=>0,'slide.status'=>1])
							->countAllResults(false);					
        $result['list'] = $res;
        $result['total'] = $total;
		return $result;
    }

	public function edit($data){
		return $this->save($data);
	}

}