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
								<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
									<h4 class="lighter">维修通知扫描</h4>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="machineCode" class="col-sm-2 control-label"><h4 >扫描机器号:</h4></label>
										<div class="col-sm-4 control-label">
											<input type="text" name="machineCode" id="machineCode" value="" maxlength="50" placeholder="请扫描机器号"  class="form-control" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label class="col-sm-2 control-label"><h4 >机器信息:</h4></label>
									</div>
								</div>
								<div class="row" style="margin-left: 15px;">
									<label for="NAME" class="col-sm-2 control-label">机器名称:</label>
									<div class="col-sm-2">
										<input type="text" name="NAME" id="NAME"  maxlength="50"  class="form-control" style="border: 0px"/>
									</div>
									<label for="type" class="col-sm-1 control-label">机器类型:</label>
									<div class="col-sm-2">
										<input type="text" name="type" id="type"  maxlength="50"  class="form-control" style="border: 0px"/>
									</div>
									<label for="code" class="col-sm-1 control-label">机器编号:</label>
									<div class="col-sm-2">
										<input type="text" name="code" id="code"  maxlength="50" class="form-control" style="border: 0px"/>
									</div>
									<input type="hidden" id="USERNAME" name="USERNAME" />
									<input type="hidden" id="CONTENT" name="CONTENT" />
								</div>
								<div class="row" style="margin-left:50px;text-align: center;">
									<div class="form-group" style="margin-top: 100px">
										<a class="btn btn-mini btn-primary" onclick="sendSms();">发送维修通知</a>
									</div>
								</div>
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
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
		$(function() {
			$.fn.serializeObject = function() {
				var o = {};
				var a = this.serializeArray();
				$.each(a, function() {
					if (o[this.name]) {
						if (!o[this.name].push) {
							o[this.name] = [ o[this.name] ];
						}
						o[this.name].push(this.value || '');
					} else {
						o[this.name] = this.value || '';
					}
				});
				return o;
			};

			$("#machineCode").focus();
			$("#machineCode")[0].oninput =function(){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>scan/findByBarcode.do',
					data: $("#Form").serializeObject(),
					dataType:'json',
					cache: false,
					success: function(data){
						if(data.result == "success"){
							var machine = data.data;
							if(null!=machine && ""!=machine){
								$("#NAME").val(machine.name);
								$("#type").val(machine.typeName);
								$("#code").val(machine.barcode);
								$("#USERNAME").val(machine.chargeName+';'+machine.Day_Repairman+';'+machine.Night_Repairman)
							}
						}
					}
				});
			};
		});

		function sendSms(){
			if($("#machineCode").val()==""){
				$("#machineCode").tips({side:3,msg:'请扫描机器号',bg:'#AE81FF',time:2});
				$("#machineCode").focus();
				return false;
				}
			var USERNAME=$("#USERNAME").val();
			var CONTENT="请维修机器："+$("#NAME").val();;
			$.ajax({
				type: "POST",
				url:'<%=basePath%>fhsms/sendSMS.do?tm='+new Date().getTime(),
				data: {USERNAME:USERNAME,CONTENT:CONTENT,SMS_TYPE:2},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					$.each(data.list, function(i, list){
						if(list.msg == 'ok'){
							var count = list.count;
							var ecount = list.ecount;
							alert('成功发出'+count+'条,失败'+ecount+'条');
						}else{
							alert('发送失败');
						}
					});
				}
			});

		}
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>