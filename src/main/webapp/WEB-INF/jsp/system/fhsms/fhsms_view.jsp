<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<link rel="stylesheet" href="static/css/pagePublic.css" />
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
					
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="padding-top: 13px;">
									<label class="col-sm-1 control-label">通知名称:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.TITLE}
									</div>
									<br/>
									<label class="col-sm-1 control-label">机器名称:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.machine_name}
									</div>
									<br/>
									<label class="col-sm-1 control-label">通知人群:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.to_staff}
									</div>
									<br/>
									<label class="col-sm-1 control-label">通知类型:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.SMS_TYPE}
									</div>
									<br/>
									<c:if test="${pd.SMS_TYPE == '更改规格通知' }">
									<label class="col-sm-1 control-label">目标规格:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
											${pd.rule}
									</div>
									<br/>
									<label class="col-sm-1 control-label">更改部位:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
											${pd.parts}
									</div>
									<br/>
									</c:if>

									<label class="col-sm-1 control-label">发&nbsp;&nbsp;送&nbsp;&nbsp;人:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.TO_USERNAME}
									</div>
									<br/>
									<label class="col-sm-1 control-label">发送时间:</label>
									<div class="col-sm-2 control-label" style="display: inline;">
										${pd.SEND_TIME}
									</div>
									<br/>
									<a class="btn btn-mini btn-qg" onclick="top.Dialog.close();" style="margin-left: 200px;margin-top: 10px;">关闭</a>
							</tr>
						</table>
						</div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
//		$("#_DialogButtons_0").css("text-align","center");
		$(top.hangge());
		//保存
		function save(){
			if($("#CONTENT").val()==""){
				$("#CONTENT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENT").focus();
			return false;
			}
			if($("#TO_USERNAME").val()==""){
				$("#TO_USERNAME").tips({
					side:3,
		            msg:'请输入收信人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TO_USERNAME").focus();
			return false;
			}
			if($("#FROM_USERNAME").val()==""){
				$("#FROM_USERNAME").tips({
					side:3,
		            msg:'请输入发信人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FROM_USERNAME").focus();
			return false;
			}
			if($("#SEND_TIME").val()==""){
				$("#SEND_TIME").tips({
					side:3,
		            msg:'请输入发信时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SEND_TIME").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>