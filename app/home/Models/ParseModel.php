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
							->where(['deleted'=>0, 'area_id'=>$area_id])
							->get()
							->getResultArray();		
        return $result;
    }
    public function getSortByPid($pid, $num)
    {
		$builder = $this->db->table('sorts');
		$result   = $builder->select('sorts.*,model.urlname as m_urlname, model.id as model_id')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.deleted'=>0,'sorts.status'=>1])
							->whereIn('sorts.pid', $pid)
							->get($num)
							->getResultArray();
		foreach($result as $key=>$value){
			$result[$key]['link'] = $value['urlname']!=''?url(array($value['urlname'])):url(array($value['m_urlname'].'_'.$value['id']));
		}
        return $result;
    }
	
	public function getContent($id)
	{
		$builder = $this->db->table('content');
		$result   = $builder->select('content.*, sorts.urlname as urlname, sorts.name as sortname, model.urlname as m_urlname')
							->join('sorts', 'sorts.id = content.sorts_id', 'left')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where('content.id', $id)
							->get()
							->getRowArray();
		$result['content'] = $this->addTags($result['content']);
		$urlname = $result['urlname']?$result['urlname']:$result['m_urlname'];
		$result['link'] = $result['link']==''?url(array($urlname, $result['id'])):$result['link'];
		// 扩展字段
		$builder = $this->db->table('content_ext');
		$res   = $builder->select('content_ext.value, content_ext.modelfield_id, modelfield.name')
							->join('modelfield', 'content_ext.modelfield_id = modelfield.id', 'left')
							->where(['content_ext.content_id'=>$result['id'],'modelfield.deleted'=>0,'modelfield.status'=>1])
							->get()
							->getResultArray();
		foreach($res as $k=>$v){
			$result[$v['name']] = $v['value'];
		}
		return $result;
	}
	
	public function getTags(){
		$build = $this->db->table('tags');
		$result   = $build->select('*')
							->where(['area_id'=>session('area_id')])
							->get()
							->getResultArray();
		return $result;
	}

	public function addTags($content)
	{
		/* 这里可以改为读取数据表，然后缓存起来 */
		$keywords_list = $this->getTags();
		if($keywords_list){
			$readnum = 3;
			foreach ($keywords_list as $key => $val) {
				$title = $val['name'];
				$len = strlen($title);
				$str = '<a href="'.$val['link'].'" target="_blank">'.$title.'</a>';
				$str_index = mb_strpos($content, $title);
				$content = preg_replace('/(?!<[^>]*)'.$title.'(?![^<]*>)/', $str, $content, 1);
				if(is_numeric($str_index)){
					$readnum += 1;
					//$content = substr_replace($content,$str,$str_index,$len);
					//$content = $this->str_replace_limit($title,$str,$content,$this->limit);
				}
				//if($readnum == 8) return $content; //匹配到8个关键词就退出
			}
		}
		return $content;
	}
	
	
	
	
	
	
	public function getSort($id)
	{
		//urlname
		$build = $this->db->table('sorts');
		$result   = $build->select('sorts.*, model.urlname as m_urlname, model.type as m_type')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.id'=>$id])
							->get()
							->getRowArray();
/* 		//单页内容处理
		if($result['m_type'] == 1){
			$builder = $this->db->table('content');
			$res   = $builder->select('*')
								->where(['deleted'=>0, 'sorts_id'=>$result['id']])
								->get()
								->getRowArray();
			$result['content'] = $res['content'];
		}	 */		
		$urlname = $result['urlname']?$result['urlname']:$result['m_urlname'];
		$result['link'] = $result['link']==''?url(array($urlname)):$result['link'];
		
		
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
		foreach($id as $k=>$v){
			$this->getChildrenSorts($v);  //列表标签会递归查询当前ID及其子类的数据，如果只想查指列表ID下的数据，请注释掉此行即可。
		}
		$children = $this->childrenSortIds; //当前类及其模型一致的子类
		$children = array_unique($children);//去重
		$where = isset($params['where'])?str_replace(',',' and ',$params['where']):'1=1';
		$page = $page>0?$page:1;
		$num = isset($params['num'])?$params['num']:5;
		$order = isset($params['order'])?$params['order']:'id desc';
		$builder = $this->db->table('content');
		$result   = $builder->select('id')
							->where($where)
							->where(['deleted'=>0,'status'=>1])
							->whereIn('sorts_id', $children)
							->orderBy($order)
							->get($num,($page-1)*$num)
							->getResultArray();
		$countAllResults   = $builder->select('count(1) as count')
							->where($where)
							->where(['deleted'=>0,'status'=>1])
							->whereIn('sorts_id', $children)
							->orderBy($order)
							->get()
							->getRowArray();				
		$total = $countAllResults['count'];//总条数
		$page = $page; //当前页数
		$totalPage = ceil($total/$num); //当前页数
		
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
		$result = array_reverse($result);
 		foreach($result as $key=>$value){
			$urlName = $value['urlname']==''?$value['m_urlname']:$value['urlname'];
			$result[$key]['link'] = $value['link']==''?url(array($urlName, $value['id'])):$value['link'];
			// content 扩展字段
			$builder = $this->db->table('content_ext');
			$ext_res = $builder->select('content_ext.value, content_ext.modelfield_id, modelfield.name')
								->join('modelfield', 'content_ext.modelfield_id = modelfield.id', 'left')
								->where(['content_ext.content_id'=>$value['id'],'modelfield.deleted'=>0,'modelfield.status'=>1])
								->get()
								->getResultArray();
			foreach($ext_res as $k=>$v){
				$result[$key][$v['name']] = $v['value'];
			}
		}
		//urlname
		$build = $this->db->table('sorts');
		$res   = $build->select('sorts.*, model.urlname as m_urlname')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.id'=>$id])
							->get()
							->getRowArray();
		
		$urlname = $res['urlname']?$res['urlname']:$res['m_urlname'];
		$result['data'] = $result;
		$result['pagebar'] = $this->getPageBar($total,$totalPage, $page, $urlname);
		
		return $result; 
			
	}
	//分页条
	public function getPageBar($total, $totalPage, $page, $urlname){
		$pagebar['current'] = $page;
		$pagebar['total'] = $total;
		$pagebar['pre'] = ($page-1)?url(array($urlname.'_'.($page-1))):url(array($urlname));
		$pagebar['next'] = ($page+1)>=$totalPage?url(array($urlname.'_'.$totalPage)):url(array($urlname.'_'.($page+1)));
		$pagebar['first'] = url(array($urlname));
		$pagebar['last'] = url(array($urlname.'_'.$totalPage));
		$pagebar['statistics'] = "共" . $total . "条 当前" . $page . "/" . $totalPage . "页";
		$pagebar['numlist'] = $numlist;
		$pagebar['select'] = 1;
		//中间循环分页
		$pageNum = $GLOBALS['pagenum'];
		//设置起点 起点位置要保证当前页在中间位置
		if(($page-intval($pageNum/2))<1 || $totalPage<=$pageNum){
			$start = 1;
		}else if(($totalPage-$page + intval($pageNum/2)) < $pageNum){
			 $start = $totalPage-$pageNum+1;
		}else{
			 $start = $page-intval($pageNum/2);
		}
		//设置终点
		if(($page + intval($pageNum/2))<$pageNum){
			 $end = $pageNum;
		}else{
			$end = $start + $pageNum-1;
		}
		if($totalPage == 0){
			$end = 1;
		}else if($end > $totalPage){
			$end = $totalPage;
		}
		for($i = $start; $i <= $end; $i++)
		{
            $active = $i==$page ? "active" : "";
			$href = url(array($urlname.'_'.$i));
            $numlist.= "<li class='{$active}'><a href='{$href}'>{$i}</a></li>";
		}
		if($page == 1){
			$pagebar['first'] = "javascript:void(0)";
			$pagebar['pre'] = "javascript:void(0)";
			$first = 'first';
		}
		if($page == $totalPage){
			$pagebar['next'] = "javascript:void(0)";
			$pagebar['last'] = "javascript:void(0)";
			$last = 'last';
		}
		
		$string.= "<div class='pagination'><ul class='pager'>";
        $string .= "<li class='pager-statistics'>".$pagebar['statistics']."</li>";
        $string .= "<li class='pager-index ".$first."'><a href='" . $pagebar['first'] . "'>首页</a></li>";
        $string .= "<li class='pager-pre ".$first."'><a href='" . $pagebar['pre'] . "'>前一页</a></li>";
        $string .= "<li class='pager-list'>".$numlist."</span>";
        $string .= "<li class='pager-next ".$last."'><a href='" . $pagebar['next'] . "'>后一页</a></li>";
        $string .= "<li class='pager-last ".$last."'><a href='" . $pagebar['last'] . "'>尾页</a></li>";
		$string .= "</ul></div>";
		$pagebar['bar'] = $string;
		if($totalPage == 0){
			$pagebar['bar'] = '';
		}
		return $pagebar;
	}
	
    public function getSlide($gid, $num)
    {
		if(!$gid){
			$builder = $this->db->table('slide_group');
			$result   = $builder->select('*')
								->where(['deleted'=>0,'status'=>1,'area_id'=>session('area_id')])
								->get()
								->getRowArray();
			$gid = $result['id'];
			if(!$gid){
				return array();//不存在返回空数组
			}
		}
		$builder = $this->db->table('slide');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'group_id'=>$gid])
							->get($num)
							->getResultArray();					
        return $result;
    }
    public function getLink($gid, $num)
    {
		
		if(!$gid){
			$builder = $this->db->table('link_group');
			$result   = $builder->select('*')
								->where(['deleted'=>0,'status'=>1,'area_id'=>session('area_id')])
								->get()
								->getRowArray();
			$gid = $result['id'];
			if(!$gid){
				return array();//不存在返回空数组
			}
		}
		$builder = $this->db->table('link');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'group_id'=>$gid])
							->get($num)
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
	
	//获取可用表单列表
	public function getFormList(){
		$builder = $this->db->table('form');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'status'=>1])
							->get()
							->getResultArray();	
		return $result;	
	}
	//获取可用表单列表
	public function getLabel($name, $value){
		$builder = $this->db->table('label');
		$result   = $builder->select('*')
							->where(['deleted'=>0, 'status'=>1, 'name'=>$name])
							->get()
							->getRowArray();
						
		return $result[$value];	
	}
	
	//解析表单列表
	public function getFormlistByFromName($id, $name, $content_id, $pid, $num,$page){
		$page = $page>0?$page:1;
		$num = isset($num)?$num:5;
		$formList = $this->getFormList();
		$formNames = array_column($formList, 'table_name');
		if(!in_array($name,$formNames)){
			return array();//防止前台报错，非法访问返回空数组
		}else{
			$name = 'form_'.$name;
		}

		$where = $content_id?"content_id=".$content_id:"1=1";
		$builder = $this->db->table($name);
		if($pid>0){
			$result  = $builder->select('*')
					->where($where)
					->where(['deleted'=>0, 'status'=>1, 'pid'=>$pid])
					->orderBy('id desc')
					->get()
					->getResultArray();
		}else{
			$result  = $builder->select('*')
					->where($where)
					->where(['deleted'=>0, 'status'=>1, 'pid'=>$pid])
					->orderBy('id desc')
					->get($num,($page-1)*$num)
					->getResultArray();
			
		}
		$total = $builder->select('*')
					->where($where)
					->where(['deleted'=>0, 'status'=>1, 'pid'=>0])
					->orderBy('id desc')
					->countAllResults(false);
		$page = $page; //当前页数
		$totalPage = ceil($total/$num); //当前页数
		
		//urlname
		$build = $this->db->table('sorts');
		$res   = $build->select('sorts.*, model.urlname as m_urlname')
							->join('model', 'model.id = sorts.model_id', 'left')
							->where(['sorts.id'=>$id])
							->get()
							->getRowArray();
		$urlname = $res['urlname']?$res['urlname']:$res['m_urlname'];
		$data['data'] = $result;
		$data['pagebar'] = $this->getPageBar($total,$totalPage, $page, $urlname);
		return $data;
	}
	

	//获取图片集 只允许访问 content sorts表，其它访问非法
	public function getPics($id, $num, $from){
		if($from == 'content' || $from == 'sorts'){
			$builder = $this->db->table($from);
			$res   = $builder->select('*')
								->where(['id'=>$id,'area_id'=>session('area_id')])
								->get()
								->getRowArray();
			$srcs = explode(',', $res['pics']);
			$pictitles = explode(',', $res['pictitles']);
			$result = array();
			foreach($srcs as $key=>$value){
				$result[]['src'] = $value;
			}
			foreach($pictitles as $key=>$value){
				$result[]['title'] = $value;
			}
			$result = array_slice($result,0,$num);
			return $result;
		}
		return array();//防止前台报错，返回空数组	
	}	
	
	// 获取ad标签的输出内容
	public function getNormbody($label,$value){
		$builder = $this->db->table('myad');
		$result   = $builder->select('*')
							->where(['deleted'=>0,'status'=>1,'label'=>$label])
							->get()
							->getRowArray();
    	if(empty($result) || !isset($result)){
    		return array();
    	}
    	if(strtotime($result['start_time']) > time() && $result['timeset'] == 1){
    		return array();
    	}
    	if(strtotime($result['end_time']) < time() && $result['timeset'] == 1){
    		return $result['expbody'];
    	}
    	return $result[$value];
    }
	// 获取区域内容
	public function getArea($isall,$num){
		$where = ['deleted'=>0];
		if($isall === false){
			$where['id'] = session('area_id');
		}
		$builder = $this->db->table('area');
		$result   = $builder->select('*')
							->where($where)
							->get()
							->getResultArray();
    	if(empty($result) || !isset($result)){
    		return array();
    	}

    	return $result;
    }
	
}

