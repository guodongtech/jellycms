<?php
namespace App\Models;
use CodeIgniter\Model;

class AreaModel extends Model
{
	protected $table      = 'area';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getList()
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
        return $result;
    }
	public function edit($data)
	{
		return $this->save($data);
	}
	//设置所有区域默认值为0
	public function setDefault()
	{
		$data = array(
			'default' => 0,
		);
		$builder = $this->db->table('area');
		$builder->update($data);
	}
	public function getThisArea($id)
	{
		return $this->where(['deleted'=> 0, 'default'=>1, 'id'=>$id])
                  ->first();
	}
	public function getDefalutArea()
	{
		return $this->where(['deleted'=> 0, 'default'=>1])
                  ->first();
	}
 
}