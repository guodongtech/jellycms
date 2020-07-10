<?php
namespace App\Models;
use CodeIgniter\Model;

class DbModel extends Model
{

    // 数据库表状态列表
    public function getList()
    {
		$sql = "SHOW TABLE STATUS";
		return $result = $this->db->query($sql)->getResultArray();
    }

    // 获取全部表
    public function getTables()
    {
        $result = parent::all('SHOW TABLES', 2);
        foreach ($result as $value) {
            $tables[] = $value[0];
        }
        return $tables;
    }

    // 获取表字段数量
    public function getFieldNum($table)
    {
		$sql = "SHOW TABLE STATUS";
		return $result = $this->db->query($sql)->getResultArray();
    }

    // 获取表字段名
    public function getFields($table)
    {
        $one_data = parent::one("SELECT * FROM " . $table); // 读取数据
        $fields = array();
        if ($one_data) {
            foreach ($one_data as $key => $value) {
                $fields[] = "`$key`";
            }
        }
        return $fields;
    }

    // 获取一条数据
    public function getOne($table)
    {
        return parent::one("SELECT * FROM " . $table);
    }

    // 获取全部数据
    public function getAll($table)
    {
        return parent::all("SELECT * FROM " . $table, MYSQLI_NUM);
    }

    // 数据库表结构
    public function tableStru($table)
    {
        $sql = "DROP TABLE IF EXISTS `" . $table . '`;' . PHP_EOL;
        $result = parent::one('SHOW CREATE TABLE `' . $table . '`', MYSQLI_ASSOC);
        return $sql . $result['Create Table'] . ';' . PHP_EOL . PHP_EOL;
    }

    // 数据库表优化
    public function optimize($tables)
    {
		$sql = "OPTIMIZE TABLE $tables";
		return $result = $this->db->query($sql);
    }

    // 数据库表修复
    public function repair($tables)
    {
		$sql = "REPAIR TABLE $tables";
		return $result = $this->db->query($sql);
    }

    // 锁定数据库表
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

    // 解锁数据库标
    public function unlock()
    {
		$sql = "unlock tables";
		$result = $this->db->query($sql);
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
}