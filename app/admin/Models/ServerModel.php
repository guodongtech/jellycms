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

    // 检查系统配置信息
    public function checkSite()
    {
        return parent::table('ay_site')->where("acode='" . session('acode') . "'")->find();
    }

    // 增加系统配置信息
    public function addSite($data)
    {
        return parent::table('ay_site')->insert($data);
    }

    // 修改系统配置信息
    public function modSite($data)
    {
        return parent::table('ay_site')->where("acode='" . session('acode') . "'")->update($data);
    }

    // 系统数据库版本
    public function getMysql()
    {
        return parent::one('SELECT VERSION()', MYSQLI_NUM);
    }
}