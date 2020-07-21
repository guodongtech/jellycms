<?php
namespace App\Controllers;
use \App\Models\MessageModel;

class Message extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new MessageModel();
    }

    // 列表
    public function index()
    {
		echo view('message.html');
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