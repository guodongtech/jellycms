<?php
namespace App\Models;
use CodeIgniter\Model;

class ModelModel extends Model
{
	protected $table      = 'model';
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
    public function getList()
    {
		$builder = $this->db->table('model');
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