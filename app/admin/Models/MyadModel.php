<?php
namespace App\Models;
use CodeIgniter\Model;

class MyadModel extends Model
{
	protected $table      = 'myad';
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
		$builder = $this->db->table('myad');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
        return $result;
    }

 	public function edit($data){
		return $this->save($data);
	}
	// public function checkEdit($data){
	// 	$sql = "SELECT id FROM ".$this->db->prefixTable('myad')." where name='".$data['name']."' and deleted=0";
	// 	$result = $this->db->query($sql)->getResultArray();
	// 	return $result;
	// }
	// 获取ad标签的输出内容
	public function getNormbody($label){
		$builder = $this->db->table('myad');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'label'=>$label])
							->get()
							->getRowArray();
    	if(empty($result) || !isset($result)){
    		return array();
    	}
    	return $result['normbody'];
    }
}
