<?php
namespace App\Models;
use CodeIgniter\Model;

class StatisticsModel extends Model
{
	public function todayVisit(){
        $now = date("Y-m-d H:00:00",strtotime("+1 hour"));
        $pass = date("Y-m-d H:00:00",strtotime("-23 hour"));
        $sql = "SELECT DATE_FORMAT( start_time, '%Y-%m-%d %H:00:00' ) AS time,DATE_FORMAT( start_time, '%H:00' ) AS hour, COUNT(*) AS count FROM ".$this->db->prefixTable('statistics')." where start_time between '".$pass."' and '".$now."' GROUP BY time ORDER BY time";
        $res = $this->db->query($sql)->getResultArray();
        // 处理数据
        $time_list = array_column($res, 'time');
        $list = array();
        for($i=0; $i<24; $i++){
        	$one_hour = date("Y-m-d H:00:00",strtotime("-".$i." hour"));
        	if(!in_array($one_hour, $time_list)){
        		$list[] = ['time'=>$one_hour,'count'=>0,'hour'=>date("H:00",strtotime($one_hour))];
        	}
        }
        $list = array_merge($res,$list);
        // 排序
        $time = array_column($list, 'time');
        array_multisort($time,SORT_ASC,$list);
        // 取出排序后的数据
        $count = array_column($list, 'count');
        $hour = array_column($list, 'hour');
        $data = ['count'=>$count,'hour'=>$hour];
        return $data;
    }
    public function allBrowser(){
        $sql = "select browser as name,count(browser) as value from ".$this->db->prefixTable('statistics')." where browser!='' group by browser order by value desc limit 6";
        $res = $this->db->query($sql)->getResultArray();
        $count = array_sum(array_column($res, 'value'));
        $total = $this->db->table($this->db->prefixTable('statistics'))->countAll();
        $else_browser = $total-$count;
        $res[] = ['name'=>'其他浏览器','value'=>$else_browser];
        return $res;
    }
}