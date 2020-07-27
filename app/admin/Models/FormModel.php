<?php
namespace App\Models;
use CodeIgniter\Model;

class FormModel extends Model
{
	protected $table      = 'form';
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
		$builder = $this->db->table('form');
		$res   = $builder->select('*')
							->where(['deleted'=>0])
							->get($limit, $offset)
							->getResultArray();
		$total = $builder->select('*')
							->where(['deleted'=>0])
							->countAllResults(false);					
        $result['list'] = $res;
        $result['total'] = $total;
        return $result;
    }
    public function getAllForm()
    {
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
        return $result;
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
	public function edit($data){
		return $this->save($data);
	}
	public function check($name){
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'name'=>$name])
							->get()
							->getRowArray();
		return $result;
	}
	//检测表名是否已存在，不管表是否处于删除状态，事实上表是已经存在的。保护已存在表单数据，需注意查询条件
	public function checkTablename($table_name){
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['table_name'=>$table_name])
							->get()
							->getRowArray();
		return $result;
	}
	
	//添加表及字段
	public function addFormTable($table_name){
		$fields = array(
			'create_time' => array(
				'type' => 'datetime',
				'null' => TRUE,
			),
			'update_time' => array(
				'type' => 'datetime',
				'null' => TRUE,
			),
			'ip' => array(
				'type' =>'VARCHAR',
				'constraint' => '20',
				'null' => TRUE,
			),
			'create_user' => array(
				'type' => 'INT',
				'constraint' => 10,
				'null' => TRUE,
			),
			'deleted' => array(
				'type' => 'INT',
				'constraint' => 1,
				'null' => TRUE,
			),
			'status' => array(
				'type' => 'INT',
				'constraint' => 1,
				'null' => TRUE,
			),
		);

		$forge = \Config\Database::forge();
		$forge->addField('id');
		$forge->addField($fields);
		return $forge->createTable('form_'.$table_name, TRUE);//创建表 自动执行此子句IF NOT EXISTS

	}
	//修改表名
	public function editFormTable($id,$table_name){
		$form = $this->getFormById($id);
		if($form['id']){
			$forge = \Config\Database::forge();
			return $forge->renameTable('form_'.$form['table_name'], 'form_'.$table_name);
		}
		return false;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}