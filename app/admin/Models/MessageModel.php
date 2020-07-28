<?php
namespace App\Models;
use CodeIgniter\Model;

class MessageModel extends Model
{

    // 获取列表
    public function getList($table_name)
    {
        $builder = $this->db->table($table_name);
        $result   = $builder->select('*')
                            ->where(['deleted'=>0])
                            ->get()
                            ->getResultArray();
        return $result;
    }

    // 获取详情
    public function getMessage($id)
    {
        $builder = $this->db->table('form');
        $result   = $builder->select('*')
                            ->where(['deleted'=>0, 'id'=>$id])
                            ->get()
                            ->getRowArray();
        return $result;
    }

    // 删除留言
    public function delMessage($id)
    {
        return parent::table('ay_message')->where("id=$id")
            ->where("acode='" . session('acode') . "'")
            ->delete();
    }

    // 修改留言
    public function modMessage($id, $data)
    {
        return parent::table('ay_message')->autoTime()
            ->where("id=$id")
            ->where("acode='" . session('acode') . "'")
            ->update($data);
    }

    // 获取表单字段
    public function getFormFieldByCode($fcode)
    {
        return parent::table('ay_form_field')->where("fcode='$fcode'")
            ->order('sorting ASC,id ASC')
            ->select();
    }

    // 获取留言数量
    public function getCount()
    {
        $rs = parent::table('ay_message')->field('count(*) as count')
            ->where("acode='" . session('acode') . "'")
            ->find();
        return $rs->count ?: 0;
    }

    // 删除全部
    public function clearMessage()
    {
        return parent::table('ay_message')->delete();
    }
     // 获取表单字段内容 test
    public function getExtFields($form_id)
    {
        $builder = $this->db->table('form_field');
        $result   = $builder->select('*')
                            ->where(['deleted'=>0,'form_id'=>$form_id])
                            ->get()
                            ->getResultArray();
        return $result;
    }
}