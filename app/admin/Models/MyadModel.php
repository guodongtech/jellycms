<?php
namespace App\Models;
use CodeIgniter\Model;

class MyadModel extends Model
{
	protected $table      = 'myad';
	protected $primaryKey = 'id';
	protected $returnType = 'array';
	protected $useSoftDeletes = false;
	protected $allowedFields = [];
	protected $useTimestamps = false;
	protected $validationRules    = [];
	protected $validationMessages = [];
	protected $skipValidation     = true;
	protected $protectFields = false;
    // 获取列表
    public function getList($page, $limit)
    {
    	$offset = ($page-1)*$limit;
		$builder = $this->db->table('myad');
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

 	public function edit($data){
		return $this->save($data);
	}
	public function checkEdit($data){
		$sql = "SELECT id FROM ".$this->db->prefixTable('myad')." where (name='".$data['name']."' or label='".$data['label']."') and deleted=0";
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
}
