!function(){
	var layer = layui.layer,
	form = layui.form;
	var table = layui.table;
	var element = layui.element;
	var $ = layui.jquery;
	//侧边菜单栏
	$('.site-h1 i').click(function(){
		$('.manual .left').toggle();
		//$('.manual .left').toggleClass('bounceOutLeft');
		$('.manual .right').toggleClass('active');
		$('.site-h1 i').toggleClass('fa-bars');
		$('.site-h1 i').toggleClass('fa-outdent');
	})
	$('header i.fa').click(function(){
		$('.header-container ul').toggle();
	})
	var w;
	var h;
	$('img').click(function(){
		var img = new Image();
		img.src = $(this).attr('src');
		w = img.width > $(window).width()?$(window).width():img.width;
		h = img.height+45 > $(window).height()?$(window).height():img.height+45;
		layer.open({
			type: 1, 
			title: '预览', 
			area:[w + 'px', h + 'px'],
			content: '<img src="'+$(this).attr('src')+'" />'
		});
		$('.layui-layer-page').click(function(){
			layer.closeAll(); 
		})		
	})
	//转换静态表格
	table.init('jellytable', {
		width:888,
		limit:88,
		//page:true,
	//支持所有基础参数
	}); 
	layui.code({
		elem: 'pre', //默认值为.layui-code
		about:false,
		encode: true,
	});
	var clipboard = new ClipboardJS('.label i');
    clipboard.on('success', function(e) {
        layer.msg(e.text + '已复制到剪贴板');
    });
    clipboard.on('error', function(e) {
        layer.msg(e.text + '复制到剪贴板失败');
    });
	//目录
	var siteDir = $('.site-dir');
	$.each($(".right a"),function(i,val){
		 if($(this).attr('name')!=undefined){
			 siteDir.append('<li><a href="#'+$(this).attr('name')+'">'+$(this).html()+'</a></li>')
		 }
	})
	if(siteDir[0] && $(window).width() > 750){
		layer.ready(function(){
			layer.open({
			type: 1
			,content: siteDir
			,skin: 'layui-layer-dir'
			,area: 'auto'
			,maxHeight: $(window).height() - 300
			,title: '目录'
			//,closeBtn: false
			,offset: 'r'
			,shade: false
			,success: function(layero, index){
			  layer.style(index, {
				marginLeft: -15
			  });
			}
			});
		});
		siteDir.find('li').on('click', function(){
			var othis = $(this);
			othis.find('a').addClass('layui-this');
			othis.siblings().find('a').removeClass('layui-this');
		});
	}
}();