<?php 
namespace App\Controllers;
use \App\Models\MyadModel;
class Myad extends BaseController
{
	private $model;

    public function __construct()
    {
        $this->model = new MyadModel();
    }
	public function index()
	{
		return view('myad.html');
	}
	public function edit(){
		$post = post();
		$data['name'] = $post['name'];
		$data['label'] = $post['label'];
		$data['type'] = $post['type'];
		$data['timeset'] = $post['timeset'];
		$data['expbody'] = $post['expbody'];
		$data['start_time'] = $post['start_time'];
		$data['end_time'] = $post['end_time'];

		switch($data['type']){
			case 'text':
				$data['link'] = $post['text_link'];
				$data['normbody'] = "<a href='".$post['text_link']."' font-size='".$post['text_size']."' color='".$post['text_color']."'>".$post['text_content']."</a>";
				break;  
			case 'single_img':
				$data['path'] = $post['single_img'];
				$data['link'] = $post['single_link'];
				$data['desc'] = $post['single_desc'];
				$data['normbody'] = "<a href='".$post['single_link']."'><img src='".$post['single_img']."' width='".$post['single_width']."' height='".$post['single_height']." title=".$post['single_desc']."' border='0' /></a>";
				break;  
			case 'more_img':
				$data['path'] = implode(',',$post['more_path']);
				$data['link'] = implode(',',$post['more_link']);
				$data['desc'] = implode(',',$post['more_desc']);
				$str = '<link rel="stylesheet" href="{theme:css/swiper.min.css}"><div class="swiper-container" style="width: '.$post['more_width'].';height: '.$post['more_height'].';"><div class="swiper-wrapper">';
				foreach($post['more_path'] as $k=>$v){
					$str .= '<div class="swiper-slide"><a href="'.$post['more_link'][$k].'"><img src="'.$v.'" title="'.$post['more_desc'][$k].'" width="'.$post['more_width'].'" height="'.$post['more_height'].'" /></a></div>';	
				}
				$str .= '</div></div><script src="{theme:js/swiper.min.js}"></script><script type="text/javascript">var mySwiper = new Swiper(".swiper-container", {loop : true,})</script>';
				$data['normbody'] = $str;
				break;  
			case 'flash':
				$data['normbody'] = "<embed src='".$post['flash_link']."' quality='high' width='".$post['flash_width']."' height='".$post['flash_height']."' align='middle' allowScriptAccess='always' allowFullScreen='true' mode='transparent' type='application/x-shockwave-flash'></embed>";
				break;  
			default:
		}
		$this->model->edit($data);
	}
	public function getList()
	{
		$list = $this->model->getList();
		$data = [
			"code" => 0,
			"msg" => "",
			// "count" => count($list),
			"data" => $list,
		];
		return json_encode($data);
	}
}
