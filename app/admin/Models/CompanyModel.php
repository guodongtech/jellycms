<?php
namespace App\Models;
use CodeIgniter\Model;

class CompanyModel extends Model
{
	protected $table      = 'company';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getCompany($area_id)
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('company')." where area_id= {$area_id}";
		$result = $this->db->query($sql)->getRowArray();
        return $result;
    }

	public function edit($data){
		return $this->save($data);
	}
}