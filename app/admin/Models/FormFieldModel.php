<?php
namespace App\Models;
use CodeIgniter\Model;

class FormFieldModel extends Model
{
	protected $table      = 'form_field';
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
		$builder = $this->db->table('form_field');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}

}