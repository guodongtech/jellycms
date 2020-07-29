<?php
namespace App\Models;
use CodeIgniter\Model;

class ContentModel extends Model
{
	protected $table      = 'content';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = true;
	protected $allowedFields = [ 'title'];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = false;
	protected $protectFields = false;
    public function getList($model_id)
    {
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, model.urlname as m_urlname, model.id as model_id, sorts.urlname as urlname, sorts.name as sort_name, admin.name as create_user')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->join('model', 'model.id = sorts.model_id', 'left')
							->join('admin', 'admin.id = content.create_user', 'left')
							->where(['content.deleted'=>0, 'sorts.model_id'=>$model_id])
							->get()
							->getResultArray();
		foreach($result as $key=>$value){
			$result[$key]['link'] = $value['urlname']!=''?url(array($value['urlname'], $value['id'])):url(array($value['m_urlname'],$value['id']));
		}
        return $result;
    }
    public function getContent($id)
    {
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.model_id as model_id ')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'content.id'=>$id])
							->get()
							->getRowArray();
        return $result;
    }
    public function getModelId($id)
    {
		$builder = $this->db->table('content');
		$result   = $builder->select('sorts.model_id as model_id')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'content.id'=>$id])
							->get()
							->getRowArray();
        return $result;
    }
	public function getModelName($id){
		$builder = $this->db->table('model');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'id'=>$id])
							->get()
							->getRowArray();
		return $result;
	}
	public function edit($data){
		return $this->save($data);
	}
 

}