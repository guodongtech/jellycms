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
        return view('server.html');
    }

  
	
	
	
 
	
	
}

