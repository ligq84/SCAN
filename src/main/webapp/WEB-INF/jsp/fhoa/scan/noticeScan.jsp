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
<%--<script src="plugins/echarts/echarts.min.js"></script>--%>
<link rel="stylesheet" href="static/css/pagePublic.css" />
	<style type="text/css">
		.fontSize{
			font-size: 20px;
			font-family: Microsoft YaHei;
		}
		textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
			border-radius: 0 !important;
			color: #858585;
			background-color: #ffffff;
			border: 1px solid #d5d5d5;
			padding: 4px 4px 5px;
			font-size: 20px;
			font-family: inherit;
			-webkit-box-shadow: none !important;
			box-shadow: none !important;
			-webkit-transition-duration: 0.1s;
			transition-duration: 0.1s;
			margin-top: 5px;
		}
	</style>
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
								<div class="row">
									<h2 class="lighter">维修通知扫描</h2>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="machineCode" class="control-label" style="text-align: left;padding-left:50px;"><h2 >扫描机器号:</h2></label>
									</div>
								</div>
								<div class="row">
									<div class="form-group" >
										<div class="col-sm-5 control-label" style="padding-left: 50px;">
											<input type="text" name="machineCode" id="machineCode" value="" maxlength="50" placeholder="请扫描机器号"  class="form-control"
											style="height: 50px;"/>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label class="control-label" style="padding-left: 50px;"><h2 >机器信息:</h2></label>
									</div>
								</div>
								<div class="row" style="margin-left: 15px;">
									<label for="machine_name" class="col-sm-1 control-label fontSize"  style="width: 130px;">机器名称:</label>
									<div class="col-sm-2">
										<input type="text" name="machine_name" id="machine_name"  maxlength="50"  class="form-control" style="border: 0px" readonly/>
									</div>
									<label for="type" class="col-sm-1 control-label fontSize"  style="width: 130px;">机器类型:</label>
									<div class="col-sm-1" style="width: 100px;">
										<input type="text" name="type" id="type"  maxlength="50"  class="form-control" style="border: 0px" readonly/>
									</div>
									<label for="code" class="col-sm-1 control-label fontSize"  style="width: 130px;">机器编号:</label>
									<div class="col-sm-3">
										<input type="text" name="code" id="code"  maxlength="50" class="form-control" style="border: 0px" readonly/>
									</div>
									<input type="hidden" id="to_staff" name="to_staff" />
									<input type="hidden" id="CONTENT" name="CONTENT" />
									<input type="hidden" id="USERNAME" name="USERNAME" />
									<input type="hidden" id="mhid" name="mhid" />
								</div>
								<div class="row" style="margin-left: 15px;">
									<label for="chargeName" class="col-sm-1 control-label fontSize"  style="width: 130px;">机器负责人:</label>
									<div class="col-sm-2">
										<input type="text" name="chargeName" id="chargeName"  maxlength="50"  class="form-control" style="border: 0px" readonly/>
									</div>
									<label for="Day_Repairman" class="col-sm-1 control-label fontSize"  style="width: 130px;">白班维修人:</label>
									<div class="col-sm-1" style="width: 100px;">
										<input type="text" name="Day_Repairman" id="Day_Repairman"  maxlength="50"  class="form-control" style="border: 0px" readonly/>
									</div>
									<label for="Night_Repairman" class="col-sm-1 control-label fontSize"  style="width: 130px;">晚班维修人:</label>
									<div class="col-sm-3">
										<input type="text" name="Night_Repairman" id="Night_Repairman"  maxlength="50" class="form-control" style="border: 0px" readonly/>
									</div>
								</div>
								<div class="row" style="margin-left: 15px;margin-top: 20px;">
									<label style="color: red;font-size: 18px;">确认操作后，通知将发送给机器的负责人及白晚班维修员！</label>
								</div>
								<div class="row" >
									<div class="form-group" style="margin-top: 38px;margin-left: 300px;">
										<a class="btn btn-mini btn-primary" onclick="sendSms();">确认操作通知</a>
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
								$("#machine_name").val(machine.name);
								$("#type").val(machine.typeName);
								$("#code").val(machine.barcode);
								$("#to_staff").val('机器负责人：'+machine.chargeN+'、白班维修员：'+machine.Day_R+'、晚班维修员'+machine.Night_R);
								$("#USERNAME").val(machine.chargeName+';'+machine.Day_Repairman+';'+machine.Night_Repairman);
								$("#mhid").val(machine.mhid);
								$("#chargeName").val(machine.chargeName);
								$("#Day_Repairman").val(machine.Day_Repairman);
								$("#Night_Repairman").val(machine.Night_Repairman);

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
			var CONTENT="请维修机器："+$("#machine_name").val();;
			$.ajax({
				type: "POST",
				url:'<%=basePath%>fhsms/sendSMS.do?tm='+new Date().getTime(),
				data: {USERNAME:USERNAME,CONTENT:CONTENT,SMS_TYPE:2,"to_staff":$("#to_staff").val(),"TITLE":"关于"+$("#machine_name").val()+"维修通知"
					,machine_name:$("#machine_name").val(),mhid:$("#mhid").val()},
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