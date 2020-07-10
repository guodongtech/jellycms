<?php
namespace App\Models;
use CodeIgniter\Model;

class LinkGroupModel extends Model
{
	protected $table      = 'link_group';
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
		$builder = $this->db->table('link_group');
		$result   = $builder->select('link_group.*, area.name as area_name')
							->join('area', 'area.id = link_group.area_id', 'left')
							->where(['link_group.deleted'=>0])
							->get()
							->getResultArray();

        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
}