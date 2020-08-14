<?php
namespace App\Models;
use CodeIgniter\Model;

class StatisticsModel extends Model
{
	public function todayVisit(){
        $today = date("Y-m-d");
        $tomorrow = date("Y-m-d",strtotime("+1 day"));
        $sql = "select t.*,IFNULL(s.count,0) as count from ".$this->db->prefixTable('statistics_hour')." t left join (SELECT HOUR(start_time)as h,FLOOR(MINUTE(start_time)/30) as m, COUNT(*) as count  FROM ".$this->db->prefixTable('statistics')." WHERE start_time between '".$today."' and '".$tomorrow."' GROUP BY FLOOR(MINUTE(start_time)/30),HOUR(start_time) ORDER BY h,m) as s on t.hour=s.h and t.minute=s.m order by t.hour,t.minute";
        $res = $this->db->query($sql)->getResultArray();
        $count = array_column($res, 'count');
        return $count;
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