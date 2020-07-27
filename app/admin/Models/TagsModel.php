<?php
namespace App\Models;
use CodeIgniter\Model;

class TagsModel extends Model
{
	protected $table      = 'tags';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    // 获取内链列表
    public function getList($page, $limit)
    {
		$offset = ($page-1)*$limit;
		$builder = $this->db->table('tags');
		$res   = $builder->select('*')
							->where(['deleted'=>0])
							->get($limit, $offset)
							->getResultArray();
		$total = $builder->select('*')->where(['deleted'=>0])
							->countAllResults(false);	
		$result['list'] = $res;
        $result['total'] = $total;
		return $result;
    }
	public function check($name){
		$builder = $this->db->table('tags');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'name'=>$name])
							->get()
							->getRowArray();
		return $result;
	}
	public function edit($data, $area_id){
		return $this->where('area_id', $area_id)->save($data);
	}
}