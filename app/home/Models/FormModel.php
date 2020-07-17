<?php
namespace App\Models;
use CodeIgniter\Model;

class FormModel extends Model
{
	//通过表单名获取必填字段
    public function getRequiredField($formName)
    {
		$builder = $this->db->table('form_field');
		$result   = $builder->select('form_field.name')
							->join('form', 'form.id = form_field.form_id', 'left')
							->where(['form_field.deleted'=>0, 'form_field.required'=>1, 'form.table_name'=>$formName])
							->get()
							->getResultArray();
		return $result;
    }
	
	//获取表单信息
    public function getForm($formName)
    {
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'status'=>1, 'table_name'=>$formName])
							->get()
							->getRowArray();
		return $result;
    }
    public function insertData($name, $data)
    {
		$builder = $this->db->table($name);
		$result = $builder->insert($data);
        return $result;
    }
}

