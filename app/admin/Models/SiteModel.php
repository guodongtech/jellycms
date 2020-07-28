<?php
namespace App\Models;
use CodeIgniter\Model;

class SiteModel extends Model
{
	protected $table      = 'site';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getSite($area_id)
    {
		$builder = $this->db->table('site');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }

	public function edit($data){
		return $this->save($data);
	}
}