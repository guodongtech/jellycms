<?php
namespace App\Models;
use CodeIgniter\Model;

class ParseModel extends Model
{
	protected $childrenSortIds = array();
	protected $positions = array();
    public function getDefaultArea()
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['is_default'=>1])
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
							->where(['deleted'=>0, 'area_id'=>$area_id])
							->get()
							->getResultArray();		
        return $result;
    }
    public function getSortByPid($pid)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.*,model.urlname as m_urlname, model.id as model_id')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.pid'=>$pid])
							->get()
							->getResultArray();
							
		
		foreach($result as $key=>$value){
			$urlName = $value['urlname']==''?$value['m_urlname']:$value['urlname'];
			$result[$key]['link'] = url(array($urlName.'_'.$value['id']));
	
		}
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
	

	public function getSortById($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.status'=>1, 'sorts.id'=>$id])
							->get()
							->getRowArray();
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
	
	//递归分类，用于列表页查询所有与当前分类是一类模型的子类ID+当前类ID
	public function getChildrenSorts($id){
		if(!$id) return;
		$this->childrenSortIds[] = $id;
		$model_id = $this->getModelId($id);
		if(!$model_id) return;
		$builder = $this->db->table('sorts');
		$result   = $builder->select('id')
							->where(['deleted'=>0,'status'=>1, 'model_id'=>$model_id, 'pid'=>$id])
							->get()
							->getResultArray();
		foreach($result as $key=>$value){
				$result = $this->getChildrenSorts($value['id']);
				
		}
        return $result;
	}
	
	
	
	
	public function getList($id,$params,$page){
		
		$this->getChildrenSorts($id);
		$children = $this->childrenSortIds; //当前类及其模型一致的子类
		$where = isset($params['where'])?str_replace(',',' and ',$params['where']):1;
		$page = $page>0?$page:1;
		$num = isset($params['num'])?$params['num']:5;
		$order = isset($params['order'])?$params['order']:'id desc';
		$builder = $this->db->table('content');
		$result   = $builder->select('id')
							->where($where)
							->where(['deleted'=>0])
							->whereIn('sorts_id', $children)
							->orderBy($order)
							->get($num,($page-1)*$num)
							->getResultArray();
		$total = $builder->countAllResults();//总条数
		$page = $page; //当前页数
		
		
		//为降低模板标签解析复杂度，重新补充分类及模型信息。
		$ids = array();
		foreach($result as $key=>$value){
			$ids[]=$value['id'];
		}
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.urlname as urlname, sorts.name as sortname, model.urlname as m_urlname')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->join('model', 'model.id = sorts.model_id', 'left')
							->whereIn('content.id', $ids)
							->get()
							->getResultArray();
 		foreach($result as $key=>$value){
			$urlName = $value['urlname']==''?$value['m_urlname']:$value['urlname'];
			$result[$key]['link'] = $value['link']==''?url(array($urlName, $value['id'])):$value['link'];
		}
		return $result; 
			
	}
	//分页条
	public function getPageBar($current_page,$total
	){
		//数据总条数
		
	}
	
	
	
	
    public function getSlide($gid)
    {
		
		if(!$gid){
			$builder = $this->db->table('slide_group');
			$result   = $builder->select('*')
								->where(['deleted'=>0,'status'=>1,'area_id'=>session('area_id')])
								->get()
								->getRowArray();
			$gid = $result['id'];
			if(!$gid) error('幻灯片分组不存在');
		}
		$builder = $this->db->table('slide');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'group_id'=>$gid])
							->get()
							->getResultArray();					
        return $result;
    }
	public function getPosition($sortId){
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
			$this->getPosition($res['pid']); 
		}else{
			$result = array_reverse($result);
			//print_r($result);
		}
		return $result;
	}
 
	
	
	
	
	
	
}

