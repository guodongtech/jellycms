<?php
namespace App\Models;
use CodeIgniter\Model;

class IndexModel extends Model
{
	protected $sameModelSortIds = array();
    public function getDefaultArea()
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['default'=>1])
							->get()
							->getRowArray();
        return $result['id'];
    }
    public function getCompany($area_id)
    {
		$builder = $this->db->table('company');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }
    public function getSite($area_id)
    {
		$builder = $this->db->table('site');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }
    public function getSorts($area_id)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'status'=>1, 'area_id'=>$area_id])
							->get()
							->getResultArray();
        return $result;
    }
    public function getSortByPid($pid)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$pid])
							->get()
							->getResultArray();
        return $result;
    }
    public function getSortByUrlname($urlname)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.urlname'=>$urlname])
							->get()
							->getRowArray();
        return $result;
    }
	
	public function getContent($id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.id as sort_id')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'content.id'=>$id])
							->get()
							->getRowArray();
		return $result;
	}
	public function getPageContent($sort_id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'sorts_id'=>$sort_id])
							->get()
							->getRowArray();
        return $result;
	}

	public function getSortById($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.status'=>1, 'sorts.id'=>$id])
							->get()
							->getRowArray();
        return $result;
	}
	
	public function getList($sort_id){
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.id as sort_id, sorts.name as sort_name')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'sorts.id'=>$sort_id])
							->get()
							->getResultArray();
		return $result;
	}
	//递归获取父类集
	public function getParentsorts($sortId){
		
		static $result = array();
		$builder = $this->db->table('sorts');
		
		$res   = $builder->select('sorts.*, model.urlname as m_urlname')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.id'=>$sortId])
							->get()
							->getRowArray();
		$urlname = $res['urlname']==''?$res['m_urlname']:$res['urlname'];
		if(is_array($res)){
			if($res['outlink']==''){
				$res['link']= url(array($urlname.'_'.$res['id']));
			}else{
				$res['link']= $res['outlink'];
			}
			$result[] = $res;
			$this->getParentsorts($res['pid']); 
		}else{
			$result = array_reverse($result);
			//print_r($result);
		}
		return $result;
	}
	public function getModelId($sort_id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'status'=>1, 'id'=>$sort_id])
							->get()
							->getRowArray();	
		return $result['model_id'];					
	}

	//内容页获取上一页下一页
	public function getPreNext($id){
		$content = $this->getContent($id);
		$model_id = $this->getModelId($content['sorts_id']);
		$builder = $this->db->table('sorts');
		$sortsIds   = $builder->select('id')
							->where(['deleted'=>0,'status'=>1, 'model_id'=>$model_id])
							->get()
							->getResultArray();
		$ids = array_column($sortsIds, 'id');
		$builder = $this->db->table('content');
		$pre = $builder->select('content.*,model.urlname as m_urlname, sorts.urlname as urlname')
						->join('sorts', 'sorts.id = content.sorts_id', 'left')
						->join('model', 'model.id = sorts.model_id', 'left')
						->where(['content.deleted'=>0,'content.status'=>1, 'content.id<'=>$id])
						->whereIn('content.sorts_id', $ids)
						->orderBy('content.id desc')
						->get()
						->getRowArray();
		if(is_array($pre)){
			$urlname = $pre['urlname']==''?$pre['m_urlname']:$pre['urlname'];
			if($pre['outlink']==''){
				$pre['link']= url(array($urlname,$pre['id']));
			}else{
				$pre['link']= $pre['outlink'];
			}			
		}else{
			$pre['title'] = '没有了';
			$pre['link'] = 'javascript:void(0)';
			$pre['no'] = 1;
		}
		$next = $builder->select('content.*,model.urlname as m_urlname, sorts.urlname as urlname')
						->join('sorts', 'sorts.id = content.sorts_id', 'left')
						->join('model', 'model.id = sorts.model_id', 'left')
						->where(['content.deleted'=>0,'content.status'=>1, 'content.id>'=>$id])
						->whereIn('content.sorts_id', $ids)
						->orderBy('content.id desc')
						->get()
						->getRowArray();
		if(is_array($next)){
			$urlname = $next['urlname']==''?$next['m_urlname']:$next['urlname'];
			if($next['outlink']==''){
				$next['link']= url(array($urlname,$next['id']));
			}else{
				$next['link']= $next['outlink'];
			}			
		}else{
			$next['title'] = '没有了';
			$next['link'] = 'javascript:void(0)';
		}
		
		return $result = array('pre'=>$pre, 'next'=>$next) ;
	}
	
	
	
	
	
	
}

