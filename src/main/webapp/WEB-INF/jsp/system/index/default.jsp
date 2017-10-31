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
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<script type="text/javascript">
setTimeout("top.hangge()",500);
</script>
</head>
<body class="no-skin" >

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content" >
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row" style="margin-top: 10px;">
						<img src="/static/images/home_1.jpg" style="width: 100%;">
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
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
//		$(top.hangge());
//		timeWindow();
		function timeWindow(){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="通知提醒";
			diag.URL = '<%=basePath%>fhsms/timeWindow.do';
			diag.Width = 380;
			diag.Height = 320;
			diag.CancelEvent = function(){ //关闭事件
				if('none' == diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display){
					parent.location.href="<%=basePath%>fhsms/listscan.do";
				}
				diag.close();
			};
			diag.show();
		}
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>