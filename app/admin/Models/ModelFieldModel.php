<?php
namespace App\Models;
use CodeIgniter\Model;

class MOdelFieldModel extends Model
{
	protected $table      = 'modelfield';
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
		$builder = $this->db->table('modelfield');
		$result   = $builder->select('modelfield.*, model.name as model_name')
							->join('model', 'model.id = modelfield.model_id', 'left')
							->where(['modelfield.deleted'=>0])
							->get()
							->getResultArray();
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
  
}