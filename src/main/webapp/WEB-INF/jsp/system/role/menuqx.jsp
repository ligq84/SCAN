<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../index/top.jsp"%>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
	<link rel="stylesheet" href="static/css/pagePublic.css" />
	<style type="text/css">
	footer{height:50px;position:fixed;bottom:0px;left:0px;width:100%;text-align: center;}
	</style>
<body>

</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div id="zhongxin">
								<div style="height:35px;width: 309px;margin-top: 10px;">
									<input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}"/>
									<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
									<label>角色名称:</label>
									<input type="text" name="ROLE_NAME" id="ROLE_NAME" placeholder="这里输入名称" value="${pd.ROLE_NAME}"  title="名称" style="width:120px;border-radius: 5px;border: 1px solid #0e77d9;"/>
								</div>
								<div style="height:35px;width: 309px;margin-top: 10px;">
									<label>角色描述:</label>
									<textarea name="BZ" id="BZ" style="border: 1px solid #0e77d9;">${pd.BZ}</textarea>
								</div>
								<div style="overflow: scroll; scrolling: yes !important;height: 335px;width: 290px;margin-top: 35px;border: 1px solid #0e77d9;">
								<ul id="tree" class="tree" style="overflow:auto;"></ul>
								</div>
							</div>

							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">正在保存...</h4></div>
							</div>
						<!-- /.col -->
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	
		<div style="width: 100%;padding-top: 5px;" class="center">
			<a class="btn btn-mini btn-qg" onclick="save();">保存</a>
			<a class="btn btn-mini btn-qg" onclick="top.Dialog.close();">返回</a>
		</div>
	
	<script type="text/javascript">
		$(top.hangge());
		var zTree;
		$(document).ready(function(){
			
			var setting = {
			    showLine: true,
			    checkable: true
			};
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	
		//保存
		 function save(){
			var nodes = zTree.getCheckedNodes();
			var tmpNode;
			var ids = "";
			for(var i=0; i<nodes.length; i++){
				tmpNode = nodes[i];
				if(i!=nodes.length-1){
					ids += tmpNode.id+",";
				}else{
					ids += tmpNode.id;
				}
			}
			var ROLE_ID = "${ROLE_ID}";
			var url = "<%=basePath%>role/saveMenuqx.do";
			var postData;
			postData = {"ROLE_ID":ROLE_ID,"menuIds":ids,"ROLE_NAME":$("#ROLE_NAME").val(),"BZ":$("#BZ").val()};
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			$.post(url,postData,function(data){
				top.Dialog.close();
			});
		 }
	
	</script>
</body>
</html>