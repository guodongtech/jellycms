<?php
namespace App\Models;
use CodeIgniter\Model;
class SysLogModel extends Model
{
/* 	protected $table      = 'logs';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = true;
	protected $deletedField  = 'deleted';
	protected $allowedFields = [ '*'];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false; */
    public function getList($page, $limit)
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('logs')." where deleted =0 limit ".($page-1)*$limit.",{$limit} ";
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
    public function getCount()
    {
		$sql = "SELECT count(1) as num FROM ".$this->db->prefixTable('logs')."  ";
		$result = $this->db->query($sql)->getFirstRow();
        return $result->num;
    }
 

    public function clear()
    {
		$sql = "update ".$this->db->prefixTable('logs')." set deleted=1";
		return $this->db->query($sql);
    }
}
