<?php 
namespace App\Controllers;

class Admin extends BaseController
{
	public function index()
	{
		return view('html/index.html');
	}
	public function home()
	{
		return view('html/home.html');
	}
	public function config()
	{
		return view('html/config.html');
	}
	public function label()
	{
		$sql = "SELECT * FROM ".$this->db->prefixTable('label');
		$res = $this->db->query($sql)->getResultArray();
		display('admin/html/label.html', $res);
	}
	public function model()
	{
		return view('html/model.html');
	}
	public function modelfield()
	{
		return view('html/modelfield.html');
	}
	public function site()
	{
		$sql = "SELECT * FROM ".$this->db->prefixTable('site');
		$res = $this->db->query($sql)->getRowArray();
		display('admin/html/site.html', $res);
	}
	public function company()
	{
		return view('html/company.html');
	}
	public function sort()
	{
		return view('html/sort.html');
	}
	public function single()
	{
		return view('html/single.html');
	}
	public function content()
	{
		return view('html/content.html');
	}
	public function message()
	{
		return view('html/message.html');
	}
	public function area()
	{
		return view('html/area.html');
	}
	public function role()
	{
		return view('html/role.html');
	}
	public function user()
	{
		return view('html/user.html');
	}
	public function logs()
	{
		return view('html/logs.html');
	}
	public function db()
	{
		return view('html/db.html');
	}
	public function upgrade()
	{
		return view('html/upgrade.html');
	}
	public function slide()
	{
		return view('html/slide.html');
	}
	public function links()
	{
		return view('html/links.html');
	}
	public function form()
	{
		return view('html/form.html');
	}
	public function tags()
	{
		return view('html/tags.html');
	}

	//--------------------------------------------------------------------

}
