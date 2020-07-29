<?php
namespace App\Models;
use CodeIgniter\Model;

class SingleModel extends Model
{
	protected $table      = 'sorts';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getList($model_id)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.*,model.urlname as m_urlname, model.id as model_id')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.model_id'=>$model_id])
							->get($num)
							->getResultArray();
							
		
		foreach($result as $key=>$value){
			$result[$key]['link'] = $value['urlname']!=''?url(array($value['urlname'])):url(array($value['m_urlname'].'_'.$value['id']));
		}
        return $result;
    }

    public function getSortInfo($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['id'=>$id])
							->get()
							->getRowArray();
		return $result;
	}
    public function getModelInfo($model_id){
		$builder = $this->db->table('model');
		$result   = $builder->select('*')
							->where(['id'=>$model_id])
							->get()
							->getRowArray();
		return $result;
	}
    public function edit($data){
		
		$res = $this->save($data);
		//print_r($res);exit;
		return $this->save($data);
	}
}