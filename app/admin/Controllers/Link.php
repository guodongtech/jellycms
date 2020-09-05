<?php
/**
 * @file Label.php
 * @brief 标签管理
 * @author 无双
 * @date 2018-02-06
 * @version 3.8.1
 */
namespace App\Controllers;
use \App\Models\LinkModel;
use \App\Models\LinkGroupModel;

class Link extends BaseController
{
    private $model;
    public function __construct()
    {
        $this->model = new LinkModel();
        $this->groupModel = new LinkGroupModel();
    }
    public function index()
    {
		$groupList = $this->groupModel->getAllGroupList();
		$data = [
			"groupList" => $groupList,
		];
         return view('link.html', $data);
    }
	//获取列表
    public function getList()
    {
		$get = $this->request->getGet();
		isset($get['page'])?$page = $get['page']:$page = 1;
		isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
		$res = $this->model->getList($page, $limit, $this->session->area_id);
		$data = [
			"code" => 0,
			"msg" => "",
			"count" => $res['total'],
			"data" => $res['list'],
		];
		return json_encode($data);
    }
    public function edit()
    {
		$post = post();
		if(!$post['name'] || !$post['link']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = $post;
		if(!$post['id']){
			$data['create_user'] = $this->session->id;
			$data['create_time'] = date('Y-m-d H:i:s',time());
			$data['status'] = 1;
		}else{
			$data['update_user'] = $this->session->id;
			$data['update_time'] = date('Y-m-d H:i:s',time());
		}

		if($this->model->edit($data)){
			$this->log('link', '[友情链接]添加/编辑:'.$data['name']."[ID:".$post['id']."]");
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
	//编辑字段值
    public function changeValue()
    {
		$post = post();
		if(!$post['id'] || !$post['field'] || !$post['value']){
			$rdata = [
				"code" => 0,
				"msg" => "参数不足",
			];
			return json_encode($rdata);
		}
		$data = [
			'id' => $post['id'],
			$post['field'] => $post['value'],
		];
		if($this->model->edit($data)){
			$this->log('link', "[友情链接]编辑字段值为:".$post['value']."[ID:".$post['id']."]");
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
			$this->log('link', "[友情链接]删除:[ID:".$id."]");
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
			$this->log('link', "[友情链接]修改状态:[ID:".$post['id']."]");
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