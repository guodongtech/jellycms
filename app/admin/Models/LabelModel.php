<?php
namespace App\Models;
use CodeIgniter\Model;
class LabelModel extends Model
{
	protected $table      = 'label';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
	//标签列表
    public function getList()
    {
		$builder = $this->db->table('label');
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
		$sql = "SELECT id FROM ".$this->db->prefixTable('label')." where name='".$data['name']."' and deleted=0";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	public function inputRules($data){
		// 是否为英文名称
		if(!preg_match("/^[a-zA-Z1-9_]+$/", $data['name'])){
			$rdata = [
				"code" => 0,
				"msg" => "必须为英文名",
			];
			return json_encode($rdata);
		}
		return true;
	}
}

