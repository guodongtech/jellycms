<?php 
namespace App\Controllers;

class Admin extends BaseController
{
	public function index()
	{
		return view('index.html');
	}
	public function home()
	{
		return view('home.html');
	}
}
