<?php
namespace App\Controllers;
use \App\Models\ServerModel;

class Server extends BaseController
{

    public function __construct()
    {
        $this->model = new ServerModel();
    }

    public function index()
    {
		$list = $this->model->getList();
        echo view('server.html');
    }

    // 修改站点信息
    public function mod()
    {
        if (! $_POST) {
            return;
        }
        
        $data = array(
            'title' => post('title'),
            'subtitle' => post('subtitle'),
            'domain' => post('domain'),
            'logo' => post('logo'),
            'keywords' => post('keywords'),
            'description' => post('description'),
            'icp' => post('icp'),
            'theme' => basename(post('theme')) ?: 'default',
            'statistical' => post('statistical'),
            'copyright' => post('copyright')
        );
        
        path_delete(RUN_PATH . '/config'); // 清理缓存的配置文件
        if ($this->model->checkSite()) {
            if ($this->model->modSite($data)) {
                $this->log('修改站点信息成功！');
                success('修改成功！', - 1);
            } else {
                location(- 1);
            }
        } else {
            $data['acode'] = session('acode');
            if ($this->model->addSite($data)) {
                $this->log('修改站点信息成功！');
                success('修改成功！', - 1);
            } else {
                location(- 1);
            }
        }
    }

    // 服务器基础信息
    public function server()
    {
        $this->assign('server', get_server_info());
        $this->display('system/server.html');
    }
	
	
 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

