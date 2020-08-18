<?php namespace App\Controllers;
//use  \App\Models\DevelopersModel;

class Push extends BaseController
{    
    /**
     * @brief 构造函数
     * @param string 
     */
	private $model;
	public function __construct()
	{
		//$this->model = new DevelopersModel();
	}
	public function developers()
	{
		header('Content-Type: text/html;charset=utf-8');
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']); // *代表允许任何网址请求
		header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
		header('Access-Control-Allow-Credentials: true'); // 设置是否允许发送 cookies
		header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept-Encoding,X-Requested-with, Origin'); // 设置允许自定义请求头的字段
		$list = [
			['name'=>'zhangteng', 'email'=>'314246439@qq.com', 'description'=>'加入时间：2015年3月18日'],
			['name'=>'zhaojiabin', 'email'=>'zjb888@qq.com', 'description'=>'加入时间：2016年6月15日'],
		];
		$rdata = [
			'code'=>0,
			'msg'=>0,
			"data" => $list,
		
		];
		echo json_encode($rdata);
	}
	public function rollImg(){
		return '<link rel="stylesheet" href="/template/default/css/swiper.min.css">
				<script src="/template/default/js/swiper.min.js"></script>
				<style type="text/css">
				  .swiper-container{
				    --swiper-pagination-color: #a8deee;
				  }
				</style>
				<div class="swiper-container" style="width: 565px;height: 200px;">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank">
								<img src="/static/upload/20200818/1597735358_196e50f4b22bccc30e8b.jpg" title="http://www.jellycms.cn/" width="565px" height="200px" />
							</a>
						</div>
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735358_e1d128c5ecf66559d84d.jpg" title="http://www.jellycms.cn/" width="565px" height="200px" /></a>
						</div>
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735359_8a1045190ef18bf9d5c9.jpg" title="http://www.jellycms.cn/" width="565px" height="200px" />
							</a>
						</div>
						<div class="swiper-slide">
						<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735359_5fc7817dd6e54e251a1b.jpg" title="http://www.jellycms.cn/" width="565px" height="200px" />
						</a>
						</div>
					</div>
					<div class="swiper-pagination" slot="pagination"></div>
				</div>
				<script type="text/javascript">
					var mySwiper = new Swiper(".swiper-container", {
							loop : true,
							pagination:{
					          	el:".swiper-pagination",
					          	clickable:true,
					        },
						    autoplay: {
							  	disableOnInteraction: false, //手动滑动之后不打断播放
							  	delay: 2888
							},
						})
				</script>';
	}
}
