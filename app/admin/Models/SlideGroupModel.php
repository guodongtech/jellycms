<?php
namespace App\Models;
use CodeIgniter\Model;

class SlideGroupModel extends Model
{
	protected $table      = 'slide_group';
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
    public function getList($area_id)
    {
		$builder = $this->db->table('slide_group');
		$result   = $builder->select('slide_group.*, area.name as area_name')
							->join('area', 'area.id = slide_group.area_id', 'left')
							->where(['slide_group.deleted'=>0, 'slide_group.area_id'=>$area_id])
							->get()
							->getResultArray();

        return $result;
    }

	public function edit($data){
		return $this->save($data);
	}

}