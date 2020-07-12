<?php
namespace App\Models;
use CodeIgniter\Model;

class ParseModel extends Model
{
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
		$result   = $builder->select('sorts.*,model.urlname as m_urlname')
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
	
	public function getList($id,$params,$page){
		$children = array_column($this->getSortByPid($id), 'id');
		$children[] = $id;
		$ids = implode(',', $children);
		$params = json_decode($params,true);
		//拼接SQL
		$page = $page>0?$page:1;
		$num = isset($params['num'])?$params['num']:5;
		$limit = " limit  ".($page-1)*$num.",".$num;
		$order = isset($params['order'])?'order by '.$params['order']:'';
		$where = isset($params['where'])?' where '.str_replace(',',' and ',$params['where'])." and content.deleted=0 and sorts.id in ($ids)":" where content.deleted=0 and sorts.id in ($ids)";
		$sql = "select content.*,sorts.urlname, model.urlname as m_urlname,sorts.id as sorts_id,sorts.name as  sortname  from ".$this->db->prefixTable('content')." as content left join ".$this->db->prefixTable('sorts')." as sorts on content.sorts_id=sorts.id left join ".$this->db->prefixTable('model')." as model on model.id=sorts.model_id $where $order $limit";
		$result = $this->db->query($sql)->getResultArray();
		foreach($result as $key=>$value){
			$urlName = $value['urlname']==''?$value['m_urlname']:$value['urlname'];
			$result[$key]['link'] = url(array($urlName, $value['id']));
		}
		return $result;
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
		//if(!$sortId)
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'id'=>$sortId])
							->get()
							->getRowArray();
		if(!$result['pid']) return $result;
		$builder = $this->db->table('sorts');
		$resultP   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$result['pid']])
							->get()
							->getRowArray();
		
		
		$result = array_merge($resultP, $result);
        return $result;
	}
	
	
	
	
	
	
	
}

