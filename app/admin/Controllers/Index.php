<?php 
namespace App\Controllers;
class Index extends Base
{    
	public function index()
	{	
		echo view('index.html');
	}
}
