<?php
namespace App\Controllers;
use CodeIgniter\Controller;

class Base extends Controller
{
	protected $helpers = [];
	public function initController(\CodeIgniter\HTTP\RequestInterface $request, \CodeIgniter\HTTP\ResponseInterface $response, \Psr\Log\LoggerInterface $logger)
	{
		parent::initController($request, $response, $logger);
		//设置SESSION
		$this->session = \Config\Services::session();
		$this->db = \Config\Database::connect();
		
	}

}
