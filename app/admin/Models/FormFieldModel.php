<?php
namespace App\Models;
use CodeIgniter\Model;

class FormFieldModel extends Model
{
	protected $table      = 'form_field';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    public function getList($page, $limit)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('form_field');
		$res   = $builder->select('form_field.*, form.name as form_name')
							->join('form', 'form.id = form_field.form_id', 'left')
							->where(['form_field.deleted'=>0])
							->get($limit, $offset)
							->getResultArray();				
							
		$total = $builder->select('*')
							->where(['deleted'=>0])
							->countAllResults(false);					
        $result['list'] = $res;
        $result['total'] = $total;
        return $result;
    }
	public function edit($data){
		return $this->save($data);
	}
	
    public function getFormById($id)
    {
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'id'=>$id])
							->get()
							->getRowArray();
        return $result;
    }
	
	public function addField($fields, $form_id){
		$form = $this->getFormById($form_id);
		if(!$form['table_name']){
			return false;
		}
		//数据库工厂类
		$forge = \Config\Database::forge();
		return $forge->addColumn('form_'.$form['table_name'], $fields);//添加字段
	}
	public function editField($fields, $form_id){
		$form = $this->getFormById($form_id);
		if(!$form['table_name']){
			return false;
		}
		//数据库工厂类
		$forge = \Config\Database::forge();
		return $forge->modifyColumn('form_'.$form['table_name'], $fields);//添加字段
	}

	public function checkFields($form_id, $name){
		$builder = $this->db->table('form_field');
		$result   = $builder->select('*')
							->where(['form_id'=>$form_id, 'name'=>$name])
							->get()
							->getRowArray();
		return $result;
	}





















}