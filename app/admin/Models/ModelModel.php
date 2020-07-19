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
	public function checkEdit($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('model')." where name='".$data['name']."' and deleted=0";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	// 获取当前model的数据
	public function getValues($model_id){
    	$sql = "SELECT * FROM ".$this->db->prefixTable('model')." where id=".$model_id;
    	$result = $this->db->query($sql)->getRowArray();
    	return $result;
    }
}
