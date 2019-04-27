<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css">
<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/default/easyui.css">
<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function(){
		$('#tarsel').combobox({    
			url:'getClasses',
			method:'post',
			valueField:'classesid',//<option value='valueField'></option>    
		    textField:'classname'// <option value=''> textField </option>
		})
		
		
		init()
	})
	function init(){
		var classes=$("#tarsel").combobox('getValue');
		if(classes=="--请选择--"){
			classes='';
		}
		
		$("#showStu").datagrid({
			url:'showStu',
			method:'post',
			pagination:true,
			toolbar:'#tb',
			queryParams:{
				id:$("#id").val(),
				name:$("#name").val(),
				age:$("#age").val(),
				birthday:$("#birthday").val(),
				classesid:classes
			}
		});
		
		$("#tabfrm").form("reset");
	}
	function formattercaozuo(value,row,index){
		return "<a href='javascript:void(0)' onclick='updateStu("+index+")'>修改</a>   <a href='javascript:void(0)' onclick='deleteStu("+index+")'>删除</a>"
	}
	function updateStu(index){
		var arr=$("#showStu").datagrid("getData");
		var row=arr.rows[index];
		
		$('#updatesel').combobox({    
			url:'getClasses',
			method:'post',
			valueField:'classesid',//<option value='valueField'></option>    
		    textField:'classname'// <option value=''> textField </option>
		})
		
		$("#updatesel").combobox('setValue',row.classes.classesid)
		
		//填充表单
		$("#updatefrm").form("load",row);
		//打开弹窗
		$("#update-dialog").dialog("open")
		
	}
	function saveUpdate(){
		//获取修改弹窗中的所有的数据
		var classes=$("#updatesel").combobox('getValue');
		$.post("updateStu",{
			id:$("#updateid").val(),
			name:$("#updatename").val(),
			age:$("#updateage").val(),
			birthday:$("#updatebirthday").val(),
			classesid:classes
		},function(res){
			if(res>0){
				//修改成功
				$("#showStu").datagrid("reload");
				$("#update-dialog").dialog("close")
				$.messager.alert("提示","修改成功");
			}else{
				//修改失败
				$.messager.alert("提示","修改失败");
			}
			
		},"json")
		
		
	}
	function formattersex(value,row,index) {
		return value==0? '男':'女';
	}
	
	function formatterclass(value,row,index) {
		return row.classes.classname;
	}
	
	
</script>
</head>
<body>
	<table id="showStu" class="easyui-datagrid">
		<thead>
			<tr>
				<th data-options="field:'id',title:'id'"></th>
				<th data-options="field:'name',title:'name'"></th>
				<th data-options="field:'sex',title:'sex',formatter:formattersex"></th>
				<th data-options="field:'age',title:'age'"></th>
				<th data-options="field:'birthday',title:'birthday'"></th>
				<th data-options="field:'classes',title:'classes',formatter:formatterclass"></th>
				<th data-options="field:'caozuo',title:'操作',formatter:formattercaozuo" ></th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
	<form  id="tabfrm" class="easyui-form">
        <label for="name">id:</label>   
        <input class="easyui-validatebox" type="text"  id="id" data-options="required:true" />   
    	 
		  
        <label for="name">Name:</label>   
        <input class="easyui-validatebox" type="text"  id="name" data-options="required:true" />   
    	
    	 
        <label for="name">age:</label>   
        <input class="easyui-validatebox" type="text"  id="age" data-options="required:true" />   
    	 
       
        <label for="name">Birthday:</label>   
        <input class="easyui-validatebox" type="text"  id="birthday" data-options="required:true" />   
    	
    	<label for="name">班级:</label>  
    	<select id="tarsel" class="easyui-combobox">
    		<option >--请选择--</option>
    	</select>
    	  
    	  
		<a href="javascript:void(0)" onclick="init()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">搜索</a>
	</form>
	</div>
	
	<div id="update-dialog" class="easyui-dialog" data-options="modal:true,closed:true,title:'修改',
	buttons:[{
				text:'保存',
				handler:function(){
				saveUpdate();
				}
			},{
				text:'关闭',
				handler:function(){}
			
	}]">
		<form class="easyui-form" id="updatefrm">
			<label for="name">id:</label>   
	        <input class="easyui-validatebox" disabled="disabled" type="text" name="id"  id="updateid" data-options="required:true" />   
	    	 <br>
			  
	        <label for="name">Name:</label>   
	        <input class="easyui-validatebox" type="text" name="name"  id="updatename" data-options="required:true" />   
	    	 <br>
	    	 
	        <label for="name">age:</label>   
	        <input class="easyui-validatebox" type="text" name="age"  id="updateage" data-options="required:true" />   
	    	 
	        <br>
	        <label for="name">Birthday:</label>   
	        <input class="easyui-validatebox" type="text" name="birthday"  id="updatebirthday" data-options="required:true" />
			<br>
			<label for="name">班级:</label>  
	    	<select style="width: 100px" id="updatesel" class="easyui-combobox">
	    	</select>
		</form>
	</div>
	
	
	
	
	
</body>
</html>