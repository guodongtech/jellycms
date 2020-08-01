<?php
namespace App\Controllers;
use \App\Models\MessageModel;
use \App\Models\FormModel;
class Message extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new MessageModel();
        $this->formModel = new FormModel();
    }

    // 列表
    public function index($table_name='message')
    {
        $forms = $this->formModel->getAllForm();
        // 获取表单信息
        $form_massage = $this->model->getMessage($table_name);
        $form_id = $form_massage['id'];
        // 固定字段
        $fields = [
                    'id'=>'ID',
                    'create_time'=>'创建时间',
                    'ip'=>'IP',
                    'status'=>'前台是否显示',
                    // 'update_time'=>'更新时间',
                    // 'deleted'=>'是否删除',
                    'create_user_name'=>'创建人',
                ];
        // 获取自定义字段
        $field_all = $this->model->getExtFields($form_id);
        if(count($field_all)>0){
            foreach($field_all as $k=>$v){
                $fields[$v['name']] = $v['description'];
            }
        }
        $data['forms'] = $forms;
        $data['fields'] = $fields;
        $data['table_name'] = $form_massage['table_name'];
        $data['issystem'] = $form_massage['issystem'];
		return view('message.html',$data);
    }
    // 列表
    public function getList($table_name)
    {
        $get = $this->request->getGet();
        isset($get['page'])?$page = $get['page']:$page = 1;
        isset($get['limit'])?$limit = $get['limit']:$limit = 10; //默认单页数
        $res = $this->model->getList($table_name, $page, $limit);
        $data = [
            "code" => 0,
            "msg" => "",
            "count" => $res['total'],
            "data" => $res['list'],
        ];
        return json_encode($data);
    }
    // 删除
    public function del()
    {
        $id = post('id');
        $table_name = post('table_name');
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
        if($this->model->edit($data,$table_name)){
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
        $table_name = $post['table_name'];
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
        if($this->model->edit($data,$table_name)){
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
    // 消息回复
    public function reply()
    {
        $post = post();
        $table_name = $post['table_name'];

        if(!$post['pid'] || is_null($post['content'])){
            $rdata = [
                "code" => 0,
                "msg" => "参数不足",
            ];
            return json_encode($rdata);
        }
        $data = [
            'pid' => $post['pid'],
            'content' => $post['content'],
            'area_id' => session('area_id'),
            'create_user' => session('id'),
            'create_time' => date("Y-m-d H:i:s"),
            'status' => 1,
            'deleted' => 0,
        ];
        $add_res = $this->model->edit($data,$table_name);
        if($add_res>0){
            $data['id'] = $add_res;
            $rdata = [
                "code" => 1,
                "msg" => "操作成功",
                "data" => $data,
            ];
        }else{
            $rdata = [
                "code" => 0,
                "msg" => "操作失败",
            ];
        }
        return json_encode($rdata);
    }
    // 审核
    public function check()
    {
        $post = post();
        $table_name = $post['table_name'];
        if(!$post['id'] || !$post['table_name'] || !$post['checked']){
            $rdata = [
                "code" => 0,
                "msg" => "参数不足",
            ];
            return json_encode($rdata);
        }
        $data = [
            'id' => $post['id'],
            'checked' => $post['checked'],
            'status' => $post['status'],
        ];
        $res = $this->model->edit($data,$table_name);
        if($res>0){
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