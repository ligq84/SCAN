<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 百度echarts -->
	<script src="plugins/echarts/echarts.min.js"></script>
	<script type="text/javascript">
		setTimeout("top.hangge()",500);
	</script>
	<style type="text/css">
	</style>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row" style="margin: 0px;">
					<div class="col-xs-12" >
						<form name="Form" id="Form" method="post" class="form-horizontal">
							<div id="zhongxin" style="padding-top: 10px;">
								<c:if test="${pd.scanType == 'xs'}">
								<div id="xs">
									<div class="form-group" style="margin-top: 10px">
										<input type="button" class="btn btn-primary" value="确认操作" name="1" onclick="xsbtn()">
										<input type="button" class="btn btn-primary" value="放弃操作" name="2" onclick="xsbtn()">
									</div>
								</div>
								</c:if>
								<c:if test="${pd.scanType == 'wx'}">
								<div id="wx">

								</div>
								</c:if>
								<c:if test="${pd.scanType == 'wx'}">
								<div id="by">

								</div>
								</c:if>
								<c:if test="${pd.scanType == 'ggg'}">
									<div id="ggg">
										<div class="row">
											<div class="form-group" style="margin-top: 10px">
												<label  class="col-sm-2 control-label">更改类型：(单选)</label>
											</div>
										</div>
										<div class="row">
											<div class="form-group" style="margin-top: 10px">
												<input type="button" class="btn btn-default btn-lg" value="开始更改" name="1">
												<input type="button" class="btn btn-default btn-lg" value="结束更改" name="2">
											</div>
										</div>
										<div class="row" style="margin-left: 15px;">
											<label class="col-sm-2 control-label">目标规格:(单选)</label>
										</div>
										<div class="row">
											<div class="form-group" style="margin-top: 10px">
												<button type="button" class="btn btn-default btn-lg" >20V</button>
												<button type="button" class="btn btn-default btn-lg" >30V</button>
												<button type="button" class="btn btn-default btn-lg" >40V</button>
												<button type="button" class="btn btn-default btn-lg" >50V</button>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 control-label">更改部位:(单选)</label>
										</div>
										<div class="row">
											<div class="form-group" style="margin-top: 10px">
												<button type="button" class="btn btn-default btn-lg" >部位1</button>
												<button type="button" class="btn btn-default btn-lg" >部位2</button>
												<button type="button" class="btn btn-default btn-lg" >部位3</button>
												<button type="button" class="btn btn-default btn-lg" >部位4</button>
											</div>
										</div>
									</div>
								</c:if>
							</div>
							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
		<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<script src="static/js/myjs/scan.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
	$(top.hangge());

	<%--function sendSms(){--%>
		<%--if($("#machineCode").val()==""){--%>
			<%--$("#machineCode").tips({side:3,msg:'请扫描机器号',bg:'#AE81FF',time:2});--%>
			<%--$("#machineCode").focus();--%>
			<%--return false;--%>
		<%--}--%>
		<%--var USERNAME=$("#USERNAME").val();--%>
		<%--var CONTENT="请维修机器："+$("#NAME").val();;--%>
		<%--$.ajax({--%>
			<%--type: "POST",--%>
			<%--url:'<%=basePath%>fhsms/sendSMS.do?tm='+new Date().getTime(),--%>
			<%--data: {USERNAME:USERNAME,CONTENT:CONTENT,SMS_TYPE:2},--%>
			<%--dataType:'json',--%>
			<%--//beforeSend: validateData,--%>
			<%--cache: false,--%>
			<%--success: function(data){--%>
				<%--$.each(data.list, function(i, list){--%>
					<%--if(list.msg == 'ok'){--%>
						<%--var count = list.count;--%>
						<%--var ecount = list.ecount;--%>
						<%--alert('成功发出'+count+'条,失败'+ecount+'条');--%>
					<%--}else{--%>
						<%--alert('发送失败');--%>
					<%--}--%>
				<%--});--%>
			<%--}--%>
		<%--});--%>

	<%--}--%>
</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>