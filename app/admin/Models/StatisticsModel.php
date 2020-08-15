<?php
namespace App\Models;
use CodeIgniter\Model;

class StatisticsModel extends Model
{
	// pv uv
	public function todayVisit(){
        $now = date("Y-m-d H:00:00",strtotime("+1 hour"));
        $pass = date("Y-m-d H:00:00",strtotime("-23 hour"));
        $sql = "SELECT DATE_FORMAT( start_time, '%Y-%m-%d %H:00:00' ) AS time,DATE_FORMAT( start_time, '%H:00' ) AS hour, COUNT(*) AS count,COUNT(distinct ip) AS uv FROM ".$this->db->prefixTable('statistics')." where start_time between '".$pass."' and '".$now."' GROUP BY time ORDER BY time";
        $res = $this->db->query($sql)->getResultArray();
        // 处理数据
        $time_list = array_column($res, 'time');
        $list = array();
        for($i=0; $i<24; $i++){
        	$one_hour = date("Y-m-d H:00:00",strtotime("-".($i-1)." hour"));
        	if(!in_array($one_hour, $time_list)){
        		$list[] = ['time'=>$one_hour,'count'=>0,'uv'=>0,'hour'=>date("H:00",strtotime($one_hour))];
        	}
        }
        $list = array_merge($res,$list);
        // 排序
        $time = array_column($list, 'time');
        array_multisort($time,SORT_ASC,$list);
        // 取出排序后的数据
        $count = array_column($list, 'count');
        $hour = array_column($list, 'hour');
        $uv = array_column($list, 'uv');
        $data = ['count'=>$count,'hour'=>$hour,'uv'=>$uv];
        return $data;
    }
    // 浏览器
    public function allBrowser(){
        $sql = "select browser as name,count(browser) as value from ".$this->db->prefixTable('statistics')." where browser!='' group by browser order by value desc";
        $res = $this->db->query($sql)->getResultArray();
        $count = array_sum(array_column($res, 'value'));
        $total = $this->db->table($this->db->prefixTable('statistics'))->countAll();
        $else_browser = $total-$count;
        $res[] = ['name'=>'其他浏览器','value'=>$else_browser];
        $browser_name = array_column($res, 'name');
        $data['list'] = $res;
        $data['browser_name'] = $browser_name;
        return $data;
    }
    // 搜索引擎
    public function allSpider(){
    	$now = date("Y-m-d H:00:00",strtotime("+1 hour"));
        $pass = date("Y-m-d H:00:00",strtotime("-23 hour"));
        $sql = "SELECT spider,DATE_FORMAT( start_time, '%Y-%m-%d %H:00:00' ) AS time,DATE_FORMAT( start_time, '%H:00' ) AS hour, COUNT(*) AS count FROM ".$this->db->prefixTable('statistics')." where start_time between '".$pass."' and '".$now."' and spider!='' GROUP BY time,spider ORDER BY time";
        $res = $this->db->query($sql)->getResultArray();
        $spider_list = array_column($res, 'spider');
        $list_tmp = array();
        $time_list = array();
        $data = array();
        foreach($res as $k=>$v){
        	$list_tmp[$v['spider']][] = $v;
        	$time_list[$v['spider']][$v['time']] = $v['count'];
        	$time_list[$v['spider']][] = $v['time'];
        }
        // print_r($time_list);die;
        // 处理数据
        // $time_list = array_column($res, 'time');
        // $spider_list = array_unique(array_column($res, 'spider'));
        $list = array();
        foreach($list_tmp as $k=>$v){
        	for($i=0; $i<24; $i++){
	        	$one_hour = date("Y-m-d H:00:00",strtotime("-".($i-1)." hour"));
	        	if(!in_array($one_hour, $time_list[$k])){
	        		$list[$k][] = ['name'=>$k,'count'=>0,'hour'=>date("H:00",strtotime($one_hour))];
	        	}else{
	        		$list[$k][] = ['name'=>$k,'count'=>$time_list[$k][$one_hour],'hour'=>date("H:00",strtotime($one_hour))];
	        	}
	        }
        }
        $hour_list = array_reverse(array_column(end($list), 'hour'));
        foreach($list as $k=>$v){
        	$count_list = array_column($v, 'count');
        	$data[] = ['name'=>$k,'type'=>'line','stack'=>'总量','data'=>$count_list];
        }
        $result['hour_list'] = $hour_list;
        $result['list'] = $data;
        $result['spider_list'] = $spider_list;
        return $result;
    }

}