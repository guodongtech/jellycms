<?php 
/**
 * @file Myad.php
 * @brief 模型字段管理
 * @author 无双
 * @date 2020-02-08
 * @version 3.8.1
 */
namespace App\Controllers;
use \App\Models\MyadModel;
class Myad extends BaseController
{
	private $model;

    public function __construct()
    {
        $this->model = new MyadModel();
    }
	public function index()
	{
		return view('myad.html');
	}
	public function edit(){
		$post = post();
		if(!$post['name'] || !$post['label'] || !$post['type']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		//同名检测
		$check = $this->model->checkEdit($post);
		if(!$post['id']){
			if(count($check)>0){
				$rdata = [
					"code" => 0,
					"msg" => "该名称或标识已存在",
				];
				return json_encode($rdata);	
			}
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			if(count($check)>0 && $check[0]['id']!=$post['id']){
				$rdata = [
					"code" => 0,
					"msg" => "该名称或标识已存在",
				];
				return json_encode($rdata);	
			}
			$data['id'] = $post['id'];
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}
		$data['name'] = $post['name'];
		$data['label'] = $post['label'];
		$data['type'] = $post['type'];
		$data['timeset'] = $post['timeset'];
		$data['expbody'] = $post['expbody'];
		$data['start_time'] = $post['start_time'];
		$data['end_time'] = $post['end_time'];
		if($post['timeset'] == 1 && (strtotime($post['end_time']) < strtotime($post['start_time']))){
			$rdata = [
				"code" => 0,
				"msg" => "请检查起始时间",
			];
			return json_encode($rdata);	
		}
		switch($data['type']){
			case 'text':
				$data['link'] = $post['text_link'];
				$data['text_size'] = $post['text_size'];
				$data['text_color'] = $post['text_color'];
				$data['text_content'] = $post['text_content'];
				$data['normbody'] = "<a href='".$post['text_link']."' target='_blank' style='font-size:". $post['text_size'].";color:".$post['text_color']."'>".$post['text_content']."</a>";
				break;  
			case 'single_img':
				$data['path'] = $post['single_img'];
				$data['link'] = $post['single_link'];
				$data['desc'] = $post['single_desc'];
				$data['width'] = $post['single_width'];
				$data['height'] = $post['single_height'];
				$data['normbody'] = "<a href='".$post['single_link']."' target='_blank'><img src='".$post['single_img']."' width='".$post['single_width']."' height='".$post['single_height']." title=".$post['single_desc']."' border='0' /></a>";
				break;  
			case 'more_img':
				if(!isset($post['more_path'])){
					return json_encode(['code'=>0,'msg'=>'请先上传轮播图']);
				}
				$data['path'] = implode(',',$post['more_path']);
				$data['link'] = implode(',',$post['more_link']);
				$data['desc'] = implode(',',$post['more_desc']);
				$data['width'] = $post['more_width'];
				$data['height'] = $post['more_height'];
				$str = '<link rel="stylesheet" href="{theme:css/swiper.min.css}"><div class="swiper-container" style="width: '.$post['more_width'].';height: '.$post['more_height'].';"><div class="swiper-wrapper">';
				foreach($post['more_path'] as $k=>$v){
					$str .= '<div class="swiper-slide"><a href="'.$post['more_link'][$k].'" target="_blank"><img src="'.$v.'" title="'.$post['more_desc'][$k].'" width="'.$post['more_width'].'" height="'.$post['more_height'].'" /></a></div>';	
				}
				$str .= '</div></div><script src="{theme:js/swiper.min.js}"></script><script type="text/javascript">var mySwiper = new Swiper(".swiper-container", {loop : true,})</script>';
				$data['normbody'] = $str;
				break; 
			// case 'flash':
			// 	$data['path'] = $post['flash_link'];
			// 	$data['normbody'] = "<embed src='".$post['flash_link']."' quality='high' width='".$post['flash_width']."' height='".$post['flash_height']."' align='middle' allowScriptAccess='always' allowFullScreen='true' mode='transparent' type='application/x-shockwave-flash'></embed>";
			// 	break;  
			default:
		}
		if($this->model->edit($data)){
			$this->log("myad", '[广告管理]编辑/添加:'."[ID:".$post['id']."]");
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
			return json_encode($rdata);			
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
			return json_encode($rdata);
		}
	}
	public function getList()
	{
		$get = $this->request->getGet();
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$list = $this->model->getList($page, $limit);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $list['total'],
			"data" => $list['list'],
		];
		return json_encode($data);
	}
	public function del()
    {
		$id = post('id');
		if(!$id){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $id,
			'deleted' => 1,
		];
		if($this->model->edit($data)){
			$this->log("myad", '[广告管理]删除:'."[ID:".$id."]");
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}

		return json_encode($rdata);		
    }
    public function switch()
    {
		$post = post();
		$allowSwitch = ['status'];
		if(!$post['id'] || is_null($post['switchValue']) || !in_array($post['switchName'], $allowSwitch)){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['switchName'] => (int)$post['switchValue'],
		];
		if($this->model->edit($data)){
			$this->log("myad", '[广告管理]修改状态:'."[ID:".$post['id']."]");
			$rdata = [
				"code" => 1,
				"msg" => "操作成功",
			];
		}else{
			$rdata = [
				"code" => 0,
				"msg" => "操作失败",
			];
		}
		return json_encode($rdata);
    }
}
