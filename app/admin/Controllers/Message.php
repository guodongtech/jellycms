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
    public function index($form_id=1)
    {
        $forms = $this->formModel->getAllForm();
        $issystem = ['message','comment']; // 系统内置表单
        // 获取表单信息
        $form_massage = $this->model->getMessage($form_id);
        if(in_array($form_massage['table_name'],$issystem)){
            // 内置表 
            if($form_massage['table_name'] == 'message'){
                $fields = [
                            'id'=>'id',
                            'username'=>'用户名',
                            'mobile'=>'电话',
                            'content'=>'内容',
                            'user_ip'=>'ip地址',
                            'pid'=>'父消息ID',
                            'area_id'=>'区域',
                        ];
            }else{
                $fields = [
                            'id'=>'id',
                            'content'=>'内容',
                            'ip'=>'ip地址',
                            'icon'=>'用户头像',
                            'user_id'=>'用户ID',
                            'nickname'=>'昵称',
                            'area_id'=>'区域',
                        ];
            }

        }else{
            // 获取自定义字段
            $field_all = $this->model->getExtFields($form_id);
            foreach($field_all as $k=>$v){
                $fields[$v['name']] = $v['description'];
            }
        }
        $data['forms'] = $forms;
        $data['fields'] = $fields;
        $data['form_id'] = $form_id;
        $data['table_name'] = $form_massage['table_name'];
		echo view('message_test.html',$data);
    }
    // 列表
    public function getList($table_name)
    {
        $list = $this->model->getList($table_name);
        $data = [
            "code" => 0,
            "msg" => "",
            // "count" => $res['total'],
            "data" => $list,
        ];
        return json_encode($data);
    }
    // 删除
    public function del()
    {
        if (! $id = get('id', 'int')) {
            error('传递的参数值错误！', - 1);
        }
        
        if ($this->model->delMessage($id)) {
            $this->log('删除留言' . $id . '成功！');
            success('删除成功！', - 1);
        } else {
            $this->log('删除留言' . $id . '失败！');
            error('删除失败！', - 1);
        }
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