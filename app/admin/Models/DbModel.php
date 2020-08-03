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

    //锁表
    public function lock($tablename, $op = "WRITE")
    {
		$sql = "lock tables " . $tablename . " " . $op;
		$result = $this->db->query($sql);
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    //解锁表
    public function unlock()
    {
		$sql = "unlock tables";
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
}