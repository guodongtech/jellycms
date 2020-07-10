<?php
namespace App\Models;
use CodeIgniter\Model;

class TagsModel extends Model
{
	protected $table      = 'tags';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    // 获取内链列表
    public function getList()
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('tags')." where deleted=0";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }

	public function edit($data){
		return $this->save($data);
	}
}