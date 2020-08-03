<?php
namespace App\Models;
use CodeIgniter\Model;

class DbModel extends Model
{
    //表信息
    public function getList()
    {
		$sql = "SHOW TABLE STATUS";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
    }
 
    //所有字段
    public function getFields($table)
    {
         
    }
    //表优化
    public function optimize($tables)
    {
		$sql = "OPTIMIZE TABLE $tables";
		$result = $this->db->query($sql);
		return $result;
    }

    //修复
    public function repair($tables)
    {
		$sql = "REPAIR TABLE $tables";
		$result = $this->db->query($sql);
		return $result;
    }
}