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
	public function config()
	{
		return view('config.html');
	}
	public function label()
	{
		$sql = "SELECT * FROM ".$this->db->prefixTable('label');
		$res = $this->db->query($sql)->getResultArray();
		display('admin/html/label.html', $res);
	}
	public function model()
	{
		return view('model.html');
	}
	public function modelfield()
	{
		return view('modelfield.html');
	}
	public function site()
	{
		$sql = "SELECT * FROM ".$this->db->prefixTable('site');
		$res = $this->db->query($sql)->getRowArray();
		display('admin/html/site.html', $res);
	}
	public function company()
	{
		return view('company.html');
	}
	public function sort()
	{
		return view('sort.html');
	}
	public function single()
	{
		return view('single.html');
	}
	public function content()
	{
		return view('content.html');
	}
	public function message()
	{
		return view('message.html');
	}
	public function area()
	{
		return view('area.html');
	}
	public function role()
	{
		return view('role.html');
	}
	public function user()
	{
		return view('user.html');
	}
	public function logs()
	{
		return view('logs.html');
	}
	public function db()
	{
		return view('db.html');
	}
	public function upgrade()
	{
		return view('upgrade.html');
	}
	public function slide()
	{
		return view('slide.html');
	}
	public function links()
	{
		return view('links.html');
	}
	public function form()
	{
		return view('form.html');
	}
	public function tags()
	{
		return view('tags.html');
	}

	//--------------------------------------------------------------------

}
