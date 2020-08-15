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
        	$one_hour = date("Y-m-d H:00:00",strtotime("-".$i." hour"));
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
        // 处理数据
        $spider_list = array_column($res, 'spider');
        $list_tmp = array();
        $time_list = array();
        $data = array();
        $list = array();
        foreach($res as $k=>$v){
        	$list_tmp[$v['spider']][] = $v;
        	$time_list[$v['spider']][$v['time']] = $v['count'];
        	$time_list[$v['spider']][] = $v['time'];
        }
        foreach($list_tmp as $k=>$v){
        	for($i=0; $i<24; $i++){
	        	$one_hour = date("Y-m-d H:00:00",strtotime("-".$i." hour"));
	        	if(!in_array($one_hour, $time_list[$k])){
	        		$list[$k][] = ['name'=>$k,'count'=>0,'hour'=>date("H:00",strtotime($one_hour)),'time'=>$one_hour];
	        	}else{
	        		$list[$k][] = ['name'=>$k,'count'=>$time_list[$k][$one_hour],'hour'=>date("H:00",strtotime($one_hour)),'time'=>$one_hour];
	        	}
	        }
	        $time = array_column(end($list), 'time');
	        array_multisort($time,SORT_ASC,$list[$k]);
        }
        $hour_list = array_column(end($list), 'hour');
        foreach($list as $k=>$v){
        	$count_list = array_column($v, 'count');
        	$data[] = ['name'=>$k,'type'=>'line','stack'=>'总量','data'=>$count_list];
        }
        $result['hour_list'] = $hour_list;
        $result['list'] = $data;
        $result['spider_list'] = $spider_list;
        return $result;
    }
    public function allIp(){
		$now = date("Y-m-d H:i:s");
        $pass = date("Y-m-d H:i:s",strtotime("-1 day"));
        $sql = "SELECT ip,count(ip) as count FROM ".$this->db->prefixTable('statistics')." where start_time between '".$pass."' and '".$now."' GROUP BY ip ORDER BY start_time";
        $res = $this->db->query($sql)->getResultArray();
        // 处理数据
        $list = array();
        $ip_server = new \CodeIgniter\IpLocation\IpLocation();
        // echo $ip_server->getlocation('203.100.32.155');die;
        foreach($res as $k=>$v){
        	$country = $ip_server->getlocation($v['ip']);
        	$list[$country]['ip'] = $v['ip'];
        	$list[$country]['name'] = $country;
        	$list[$country]['value'] += $v['count'];
        }
        $isset_country = array_column($list, 'name');
        $max_count = max(array_column($list, 'value'));
        $country_list = ['北京','上海','河北','云南','黑龙江','安徽','新疆','浙江','湖北','甘肃','内蒙古','吉林','贵州','青海','四川','海南','香港','南海诸岛','重庆','河南','辽宁','湖南','山东','江苏','江西','广西','山西','陕西','福建','广东','西藏','宁夏','台湾','澳门','天津'];
        foreach($country_list as $k=>$v){
        	if(!in_array($v,$isset_country)){
        		$list[] = ['name'=>$v,'value'=>0];
        	}
        }
        $data['list'] = array_values($list);
        $data['max_count'] = $max_count;
		return $data;
	}

}