!function(){
	var layer = layui.layer,form = layui.form;
	var table = layui.table;
	var $ = layui.jquery;
	table.render({
		elem: '#test',url:'/index.php/logs/getList?page=1',
		toolbar: '#toolbarDemo',
		title: '提示',
		layEvent: 'LAYTABLE_TIPS',
		icon: 'layui-icon-tips',
		cols: [[
			{type: 'checkbox', fixed: 'left'},
			{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true},
			{field:'name', title:'名称', width:120, edit: 'text'},
			{field:'description', title:'描述', edit: 'text', templet: function(res){
				return '<em>'+ res.description +'</em>'
			}},
			{field:'typetext', title:'类型', width:100, sort: true,templet: function(res){
				var typetext;
				switch(res.type) {
					case '1':
						typetext = "单行文本";
					break;
					case '2':
						typetext = "时间";
					break;
					case '3':
						typetext = "图片";
					break;
					case '4':
						typetext = "附件";
					break;
					case '5':
						typetext = "编辑器";
					break;
					case '6':
						typetext = "开关";
					break;
					case '7':
						typetext = "多行文本";
					break;
					default:
						typetext = "错误类型";
				}
				return typetext;
			}},
			{field:'type', title:'类型', width:80, sort: true, hide:true},
			{field:'create_user', title:'添加用户', width:100},
			{field:'create_time', title:'添加时间', width:180},
			{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
		]],
		page: true
	});

	//头工具栏事件
	table.on('toolbar(test)', function(obj){
		var checkStatus = table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'getCheckData':
			var data = checkStatus.data;
				layer.alert(JSON.stringify(data));
			break;
			case 'getCheckLength':
				var data = checkStatus.data;
				layer.msg('选中了：'+ data.length + ' 个');
			break;
			case 'isAll':
				layer.msg(checkStatus.isAll ? '全选': '未全选');
			break;

			//自定义头工具栏右侧图标 - 提示
			case 'LAYTABLE_TIPS':
				layer.alert('这是工具栏右侧自定义的一个图标按钮');
			break;
		};
	});

	//监听行工具事件
	table.on('tool(test)', function(obj){
	var data = obj.data;
	//console.log(obj)
	if(obj.event === 'del'){
		layer.confirm('真的删除行么', function(index){
			$.ajax({
				url:'/index.php/label/del',
				type:'post',
				data:{
					id:obj.data.id,
				},
				dataType:"json",
				success:function(data){
					console.log(data);
					if(data.code == 1){
						layer.alert(data.msg)
						layer.close(index);
						obj.del();
					}
					else{
						layer.alert(data.msg)
					}
				},
				error:function(e){
					layer.alert("删除失败！")
				},
			});
			layer.close(index);
		});
	} else if(obj.event === 'edit'){
		layer.open({
			type: 1,
			skin: 'layui-layer-rim',
			area: ['530px', '356px'],
			title :'添加标签',
			btn: ['提交', '取消'],
			btn1: function(index, layero){
				$.ajax({
					url:'/index.php/label/edit',
					type:'post',
					data:{
						id:$('#form input[name="id"]').val(),
						name:$('#form input[name="name"]').val(),
						description:$('#form input[name="description"]').val(),
						type:$('#form select[name="type"]').val(),
					},
					dataType:"json",
					success:function(data){
						if(data.code == 1){
							layer.alert(data.msg)
							layer.close(index);
						}
						else{
							layer.alert(data.msg)
						}
					},
					error:function(e){
						layer.alert("操作失败！")
					},
				});
		},
		btn2: function(index, layero){
			layer.close(index);
		},
			content: $('#add').html()
		});
		$('#form input[name="name"]').val(obj.data.name);
		$('#form input[name="description"]').val(obj.data.description);
		$('#form input[name="id"]').val(obj.data.id);
		$('#form option[value='+obj.data.type+']').attr({'selected':'selected'});
		form.render();
	}
});

$('#btn-add').click(function(){
	layer.open({
		type: 1,
		skin: 'layui-layer-rim',
		area: ['530px', '356px'],
		title :'添加标签',
		btn: ['添加', '取消'],
		btn1: function(index, layero){
			$.ajax({
				url:'/index.php/label/add',
				type:'post',
				data:{
				name:$('#form input[name="name"]').val(),
				description:$('#form input[name="description"]').val(),
				type:$('#form select[name="type"]').val(),
				},
				dataType:"json",
				success:function(data){
					if(data.code == 1){
						layer.alert(data.msg)
						layer.close(index);
					}
					else{
						layer.alert(data.msg)
					}
				},
				error:function(e){
					layer.alert("添加失败！")
				},
			});
	},
	btn2: function(index, layero){
		layer.close(index);
	},
		content: $('#add').html()
	});
	form.render();
})







}();

