<?php
namespace App\Models;
use CodeIgniter\Model;

class SingleModel extends Model
{
	protected $table      = 'sorts';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getList($model_id)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['model_id'=>$model_id])
							->get()
							->getResultArray();
        return $result;
    }

    public function getSortInfo($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['id'=>$id])
							->get()
							->getRowArray();
		return $result;
	}
    public function getModelInfo($model_id){
		$builder = $this->db->table('model');
		$result   = $builder->select('*')
							->where(['id'=>$model_id])
							->get()
							->getRowArray();
		return $result;
	}
    public function edit($data){
		
		$res = $this->save($data);
		//print_r($res);exit;
		return $this->save($data);
	}
}