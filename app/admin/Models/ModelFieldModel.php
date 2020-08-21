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
	public function checkEdit($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('modelfield')." where name='".$data['name']."' and model_id=".$data['model_id']." and deleted=0";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	public function inputRules($data){
		// 是否为英文名称
		if(!preg_match("/^[a-zA-Z_]+$/", $data['name'])){
			$rdata = [
				"code" => 0,
				"msg" => "必须为英文名",
			];
			return json_encode($rdata);
		}
		//单选  复选  下拉  需要必填value
		// if(in_array($data['type'], [3,4,9]) && !$data['value']){
		// 	$rdata = [
		// 		"code" => 0,
		// 		"msg" => "请填写字段值",
		// 	];
		// 	return json_encode($rdata);
		// }
		// 是否逗号隔开 先将回车替换为逗号
		// $data['value'] = preg_replace("/(\r\n)/" ,',' ,$data['value']);
		// if(!preg_match('/^[\x{4e00}-\x{9fa5}\w]+(,[\x{4e00}-\x{9fa5}\w]+)*$/u',$data['value'])){
		// 	$rdata = [
		// 		"code" => 0,
		// 		"msg" => "字段值格式错误",
		// 	];
		// 	return json_encode($rdata);
		// }
		return true;
	}
	public function checkClash($data){
		$sql = "SHOW COLUMNS FROM ".$this->db->prefixTable('content');
		$result = $this->db->query($sql)->getResultArray();
		if(in_array($data['name'],array_column($result, 'Field'))){
			return false;
		}
		return true;
	}
  
}