<?php
namespace App\Models;
use CodeIgniter\Model;

class ServerModel extends Model
{

    public function getList()
    {
		$sql = "SELECT * FROM ".$this->db->prefixTable('site');
		$result = $this->db->query($sql)->getResultArray();
        return $result;
    }
}