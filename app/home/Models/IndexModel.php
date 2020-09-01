<?php
namespace App\Models;
use CodeIgniter\Model;

class IndexModel extends Model
{
	protected $sameModelSortIds = array();
	//获取默认区域
    public function getDefaultArea()
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['default'=>1])
							->get()
							->getRowArray();
        return $result;
    }
	//获取当前区域信息 
    public function getCurrentArea($host)
    {
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
		//判断当前域名是否是已绑定过的域名，如果匹配到，则按域名返回当前区域信息
		foreach($result as $key=>$value){
			if($this->getHttpType().$host == trim($value['domain'])){
				$value['domain'] = trim($value['domain']);//处理掉空格 /等
				return $result = $value;
			}
		}
		//域名如果没有匹配到，则返回默认区域
		$result = $this->getDefaultArea();
        return $result;
    }
	function getHttpType()
	{
		$httpType = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
		return $httpType;
	}
	//获取当前区域下company表
    public function getCompany($area_id)
    {
		$builder = $this->db->table('company');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
        return $result;
    }
	//获取当前区域下site表信息
    public function getSite($area_id)
    {
		$builder = $this->db->table('site');
		$result   = $builder->select('*')
							->where(['area_id'=>$area_id])
							->get()
							->getRowArray();
		$result['logo'] = fileUrl($result['logo']);
		$result['qrcode'] = fileUrl($result['qrcode']);
		$result['service_code'] = fileUrl($result['service_code']);
		$result['subscribe_code'] = fileUrl($result['subscribe_code']);
        return $result;
    }
	//获取当前区域下所有栏目
    public function getSorts($area_id)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'status'=>1, 'area_id'=>$area_id])
							->get()
							->getResultArray();
        return $result;
    }
	//获取当前父栏目下所有子栏目
    public function getSortByPid($pid)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'pid'=>$pid])
							->get()
							->getResultArray();
        return $result;
    }
	//通过urlname获取栏目信息
    public function getSortByUrlname($urlname)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.urlname'=>$urlname])
							->get()
							->getRowArray();
		$result['ico'] = fileUrl($result['ico']);
		$result['pic'] = fileUrl($result['pic']);
		$result['pics'] = $result['pics']==""?"":implode(',',array_map(function ($item){
            return fileUrl($item);
        },explode(',',$result['pics'])));
        return $result;
    }
	//获取内容详情
	public function getContent($id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.id as sort_id')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->where(['content.deleted'=>0, 'content.id'=>$id])
							->get()
							->getRowArray();
		$result['content'] = $this->addTags($result['content']);
		$result['filename'] = fileUrl($result['filename']);
		$result['pic'] = fileUrl($result['pic']);
		$result['otherfile'] = fileUrl($result['otherfile']);
		$result['pics'] = $result['pics']==''?'':implode(',',array_map(function ($item){
	            return fileUrl($item);
	        },explode(',',$result['pics'])));
		// 扩展数据
		$builder = $this->db->table('content_ext');
		$res   = $builder->select('content_ext.value, content_ext.modelfield_id, modelfield.name,modelfield.type')
							->join('modelfield', 'content_ext.modelfield_id = modelfield.id', 'left')
							->where(['content_ext.content_id'=>$result['id'],'modelfield.deleted'=>0,'modelfield.status'=>1])
							->get()
							->getResultArray();
		foreach($res as $k=>$v){
			if($v['type'] == 'pic' || $v['type'] == 'file'){
				$result[$v['name']] = fileUrl($v['value']);
			}
			$result[$v['name']] = $v['value'];
		}
		return $result;
	}
	//获取当前区域下所有标签
	public function getTags(){
		$build = $this->db->table('tags');
		$result   = $build->select('*')
							->where(['area_id'=>session('area_id')])
							->orderBy('sorting','desc')
							->get()
							->getResultArray();
		return $result;
	}
	//内容详情页添加标签
	public function addTags($content)
	{
		//先匹配到先替换
		$tagsList = $this->getTags();
		if($tagsList){
			foreach ($tagsList as $key => $val) {
				$title = $val['name'];
				$len = strlen($title);
				$str = '<a href="'.$val['link'].'" title="'.$title.'" target="_blank">'.$title.'</a>';
				$str_index = mb_strpos($content, $title);
				$content = preg_replace('/(?!<[^>]*)'.$title.'(?![^<]*>)/', $str, $content, $GLOBALS['tag_times']);
			}
		}
		return $content;
	}
	//获取指定分类下content字段
	public function getPageContent($sort_id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'sorts_id'=>$sort_id])
							->get()
							->getRowArray();
        return $result;
	}
	//通过id获取分类信息
	public function getSortById($id){
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.* , model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0, 'sorts.status'=>1, 'sorts.id'=>$id])
							->get()
							->getRowArray();
		$result['ico'] = fileUrl($result['ico']);
		$result['pic'] = fileUrl($result['pic']);
		$result['pics'] = $result['pics']==""?"":implode(',',array_map(function ($item){
            return fileUrl($item);
        },explode(',',$result['pics'])));
        return $result;
	}
	//获取指定分类下信息列表
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
	//获取指定栏目的model_id
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
			if($pre['link']==''){
				$pre['link']= url(array($urlname,$pre['id']));
			}else{
				$pre['link']= $pre['link'];
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
			if($next['link']==''){
				$next['link']= url(array($urlname,$next['id']));
			}else{
				$next['link']= $next['link'];
			}			
		}else{
			$next['title'] = '没有了';
			$next['link'] = 'javascript:void(0)';
		}
		// pre扩展数据
		$builder = $this->db->table('content_ext');
		$pre_res   = $builder->select('content_ext.value, content_ext.modelfield_id, modelfield.name')
							->join('modelfield', 'content_ext.modelfield_id = modelfield.id', 'left')
							->where(['content_ext.content_id'=>$pre['id'],'modelfield.deleted'=>0,'modelfield.status'=>1])
							->get()
							->getResultArray();
		foreach($pre_res as $k=>$v){
			$pre[$v['name']] = $v['value'];
		}
		// next扩展数据
		$builder = $this->db->table('content_ext');
		$next_res   = $builder->select('content_ext.value, content_ext.modelfield_id, modelfield.name')
							->join('modelfield', 'content_ext.modelfield_id = modelfield.id', 'left')
							->where(['content_ext.content_id'=>$next['id'],'modelfield.deleted'=>0,'modelfield.status'=>1])
							->get()
							->getResultArray();
		foreach($next_res as $k=>$v){
			$next[$v['name']] = $v['value'];
		}
		return $result = array('pre'=>$pre, 'next'=>$next) ;
	}
	
	
	
	
	
	
}

