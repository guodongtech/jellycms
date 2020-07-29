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
                    'create_user'=>'创建人',
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
		echo view('message.html',$data);
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
    // 修改
    public function mod()
    {
        if (! $id = get('id', 'int')) {
            error('传递的参数值错误！', - 1);
        }
        
        // 单独修改状态
        if (($field = get('field', 'var')) && ! is_null($value = get('value', 'var'))) {
            if ($this->model->modMessage($id, "$field='$value',update_user='" . session('username') . "'")) {
                location(- 1);
            } else {
                alert_back('修改失败！');
            }
        }
        
        // 修改操作
        if ($_POST) {
            // 获取数据
            $recontent = post('recontent');
            $status = post('status');
            
            // 构建数据
            $data = array(
                'recontent' => $recontent,
                'status' => $status,
                'update_user' => session('username')
            );
            
            // 执行修改
            if ($this->model->modMessage($id, $data)) {
                $this->log('修改留言' . $id . '成功！');
                if (! ! $backurl = get('backurl')) {
                    success('修改成功！', base64_decode($backurl));
                } else {
                    success('修改成功！', url('/admin/Message/index'));
                }
            } else {
                location(- 1);
            }
        } else {
            // 调取修改内容
            $this->assign('mod', true);
            if (! $result = $this->model->getMessage($id)) {
                error('编辑的内容已经不存在！', - 1);
            }
            $this->assign('message', $result);
            
            $this->display('content/message.html');
        }
    }

    // 清空
    public function clear()
    {
        if ($this->model->clearMessage()) {
            alert_location('清空成功！', url('/admin/Message/index'));
        } else {
            alert_location('清空失败！', url('/admin/Message/index'));
        }
    }
}