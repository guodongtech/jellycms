<?php
namespace App\Models;
use CodeIgniter\Model;

class MessageModel extends Model
{

    // 获取列表
    public function getList($table_name, $page, $limit)
    {
        $offset = ($page-1)*$limit;
        $table_name = "form_".$table_name;
        $builder = $this->db->table($table_name." f");
        $res   = $builder->select('f.*,a.name as create_user_name')
                            ->join('admin a', 'f.create_user = a.id', 'left')
                            ->where(['f.deleted'=>0])
                            ->orderby('f.id asc')
                            ->get($limit, $offset)
                            ->getResultArray();
        $total = $builder->select('*')
                            ->where(['deleted'=>0])
                            ->countAllResults(false);
        $result['list'] = $res;
        $result['total'] = $total;
        return $result;
    }

    // 获取详情
    public function getMessage($table_name)
    {
        $builder = $this->db->table('form');
        $result   = $builder->select('*')
                            ->where(['deleted'=>0, 'table_name'=>$table_name])
                            ->get()
                            ->getRowArray();
        return $result;
    }
    public function edit($data,$table_name){
        if(isset($data['id']) && $data['id']>0){
            $id = $data['id'];
            unset($data['id']);
            $table_name = 'form_'.$table_name;
            $builder = $this->db->table($table_name);
            $builder->where(['id'=>$id])->update($data);
            return $this->db->affectedRows();
        }else{
            $table_name = 'form_'.$table_name;
            $builder = $this->db->table($table_name);
            $builder->insert($data);
            return $this->db->insertID();
        }
        
        
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
     // 获取表单所有自定义字段
    public function getExtFields($form_id)
    {
        $builder = $this->db->table('form_field');
        $result   = $builder->select('*')
                            ->where(['deleted'=>0,'display'=>1,'form_id'=>$form_id])
                            ->get()
                            ->getResultArray();
        return $result;
    }
     // 获取待审核留言
    public function getMessageCount()
    {
        $builder = $this->db->table('form_message');
        $result   = $builder->select('*')
                            ->where(['checked'=>0,'deleted'=>0])
                            ->countAllResults(false);
        return $result;
    }
     // 获取待审核评论
    public function getCommentCount()
    {
        $builder = $this->db->table('form_comment');
        $result   = $builder->select('*')
                            ->where(['checked'=>0,'deleted'=>0])
                            ->countAllResults(false);
        return $result;
    }
}