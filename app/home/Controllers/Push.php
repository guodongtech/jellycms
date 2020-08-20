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
			['name'=>'zhaojiabin', 'email'=>'745320293@qq.com', 'description'=>'加入时间：2016年6月15日'],
		];
		$rdata = [
			'code'=>0,
			'msg'=>0,
			"data" => $list,
		
		];
		echo json_encode($rdata);
	}
	public function exchange()
	{
		header('Content-Type: text/html;charset=utf-8');
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']); // *代表允许任何网址请求
		header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
		header('Access-Control-Allow-Credentials: true'); // 设置是否允许发送 cookies
		header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept-Encoding,X-Requested-with, Origin'); // 设置允许自定义请求头的字段
		$list = [
			['field1'=>'title1', 'field2'=>'content1'],
			['field1'=>'title2', 'field2'=>'content2'],
			['field1'=>'title3', 'field2'=>'content3'],
		];
		$rdata = [
			'code'=>0,
			'msg'=>0,
			"data" => $list,
		
		];
		echo json_encode($rdata);
	}
	public function question()
	{
		header('Content-Type: text/html;charset=utf-8');
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']); // *代表允许任何网址请求
		header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
		header('Access-Control-Allow-Credentials: true'); // 设置是否允许发送 cookies
		header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept-Encoding,X-Requested-with, Origin'); // 设置允许自定义请求头的字段
		if(!post('name') || !post('email') || !post('content')){
			$rdata = [
				'code'=>0,
				'msg'=>'请认真填写哦',
			];
			echo json_encode($rdata);die;
		}
		// print_r(post());die;
		$data['name'] = post('name');
		$data['email'] = post('email');
		$data['content'] = post('content');
		$data['assess'] = post('assess');
		// 将data入库

		// //
		$rdata = [
			'code'=>1,
			'msg'=>'感谢您的反馈',
		];
		echo json_encode($rdata);
	}
	public function question_html()
	{
		// return view('default/html/question.html');
		header('Content-Type: text/html;charset=utf-8');
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']); // *代表允许任何网址请求
		header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
		header('Access-Control-Allow-Credentials: true'); // 设置是否允许发送 cookies
		header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept-Encoding,X-Requested-with, Origin'); // 设置允许自定义请求头的字段
		return '
			<link rel="stylesheet" href="/static/layui/css/layui.css">
			<link rel="stylesheet" href="/static/layui/css/admin.css">
			<link rel="stylesheet" media="screen" href="/static/css/main.css">
			<script src="/static/layui/layui.all.js"></script>
			<script src="/static/js/jquery-3.4.1.min.js"></script>
			<div class="layui-fluid">
			<div  id="question-form">
				<div style="padding-right:30px;">
					 <form action="" method="post" class="layui-form" id="form" lay-filter="form">
						<div class="layui-form-item">
							 <label class="layui-form-label">姓名</label>
							 <div class="layui-input-block">
								<input type="text" name="name" lay-verify="required" placeholder="请输入您的姓名" class="layui-input">
							 </div>
						</div>
						<div class="layui-form-item">
							 <label class="layui-form-label">邮箱</label>
							 <div class="layui-input-block">
								<input type="text" name="email" lay-verify="required|email" placeholder="请输入您的邮箱" class="layui-input">
							 </div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">内容</label>
							<div class="layui-input-block">
								<textarea name="content" placeholder="请输入您要反馈的内容" class="layui-textarea"></textarea>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">紧急</label>
							<input type="hidden" id="assess" name="assess">
							<input type="hidden" id="domain" name="domain">
							<div class="layui-input-block">
								<div><div class="star"></div></div>
							</div>
						</div>
						<div class="layui-form-item">
						    <div class="layui-input-block">
						      <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">提交</button>
						      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
						    </div>
						  </div>
					 </form>
				</div>
			</div>
			</div>
			<script>
				var layer = layui.layer
				var form = layui.form;
				var $ = layui.$;
				layui.use(["rate"], function(){
				  	var rate = layui.rate;
				  	//基础效果
				  	rate.render({
				    	elem: ".star",
				    	value:1,
				    	text:true,
				    	setText: function(value){
				    		$("#assess").val(value);
						}
				  	})
				})	
				var domain = window.parent.location.hostname;
				$("#domain").val(domain);	
				form.on("submit(form)", function(data){
					$.post("//www.jellycms.cn/index.php/push/question",$("#form").serialize(),function(data){
						if(data.code == 1){
							var index = parent.layer.getFrameIndex(window.name);
							window.parent.layer.msg(data.msg);
							window.parent.layer.close(index);
						}
						else{
							window.parent.layer.msg(data.msg)
						}
					}, "json");
				});	
			</script>
		';
	}
	public function rollImg(){
		return '<link rel="stylesheet" href="/template/default/css/swiper.min.css">
				<script src="/template/default/js/swiper.min.js"></script>
				<style type="text/css">
				  .swiper-container{
				    --swiper-pagination-color: #a8deee;
				  }
				</style>
				<div class="swiper-container" style="width: 100%;height: 100%;">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank">
								<img src="/static/upload/20200818/1597735358_196e50f4b22bccc30e8b.jpg" title="http://www.jellycms.cn/" width="565px" height="400px" />
							</a>
						</div>
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735358_e1d128c5ecf66559d84d.jpg" title="http://www.jellycms.cn/" width="565px" height="400px" /></a>
						</div>
						<div class="swiper-slide">
							<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735359_8a1045190ef18bf9d5c9.jpg" title="http://www.jellycms.cn/" width="565px" height="400px" />
							</a>
						</div>
						<div class="swiper-slide">
						<a href="http://www.jellycms.cn/" target="_blank"><img src="/static/upload/20200818/1597735359_5fc7817dd6e54e251a1b.jpg" title="http://www.jellycms.cn/" width="565px" height="400px" />
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
