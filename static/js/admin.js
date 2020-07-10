function loadData(jsonStr, form){
	var obj = jsonStr;
	var key,value,tagName,type,arr;
	$(form + "[name='"+key+"'],[name='"+key+"[]']").attr('checked',false);
	for(x in obj){
		key = x;
		value = obj[x];
		$("[name='"+key+"'],[name='"+key+"[]']").each(function(){
			tagName = $(this)[0].tagName;
			type = $(this).attr('type');
			if(tagName=='INPUT'){
				if(type=='radio'){
					$(this).attr('checked',$(this).val()==value);
				}else if(type=='checkbox'){
					arr = JSON.parse(value);
					if(typeof(arr) == 'string' || typeof(arr) == 'number'){//单个值处理
						if($(this).val()== parseInt(arr)){
							$(this).attr('checked',true);
						}
					}else{ //多个值
						for(var i =0;i<arr.length;i++){
							if($(this).val()==arr[i]){
								$(this).attr('checked',true);
								break;
							}
						}						
					}

				}else{
					$(this).val(value);
				}
			}else if(tagName=='SELECT' || tagName=='TEXTAREA'){
				$(this).val(value);
			}
			
		});
	}
}	