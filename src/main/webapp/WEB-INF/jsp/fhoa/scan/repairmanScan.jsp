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
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
	<!-- 树形下拉框end -->
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
									<h4 class="lighter">维修员扫描</h4>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="machineCode" class="col-sm-2 control-label"><h4 >第一步：扫描机器号:</h4></label>
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
										<input type="text" name="name" id="name"  maxlength="50"  class="form-control" style="border: 0px"/>
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
									<input type="hidden" id="mhid" name="mhid" />

								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="machineCode" class="col-sm-2 control-label"><h4 >第二步：选择扫描类型:</h4></label>
									</div>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label class="col-sm-2 control-label"></label>
										<%--<button type="button" class="btn btn-primary btn-lg"  onclick="ScanRecord('xs')">巡视扫描</button>--%>
										<button type="button" class="btn btn-primary btn-lg" data-toggle="modal"  id="xsModal" onclick="machineCodeCheck('xsModal')">
											巡视扫描
										</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="ScanRecord('wx')" style="margin-left: 5em;">维修扫描</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="ScanRecord('by')" style="margin-left: 5em;">保养扫描</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="ScanRecord('ggg')" style="margin-left: 5em;">改规格扫描</button>
									</div>
								</div>
								<%--<div class="row" style="margin-left:50px;text-align: center;">--%>
									<%--<div class="form-group" style="margin-top: 100px">--%>
										<%--<a class="btn btn-mini btn-primary" onclick="sendSms();">发送维修通知</a>--%>
									<%--</div>--%>
								<%--</div>--%>
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
<div class="modal fade" id="xsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-footer" style="text-align: center">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
				<button type="button" class="btn btn-primary" onclick="xsbtn()">确定操作</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary">确定操作</button>
			</div>
		</div>
	</div>
</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>

<script type="text/javascript">
	var scanUrl = "<%=basePath%>";
</script>
<!-- inline scripts related to this page -->
<script src="static/js/myjs/scan.js"></script>
</body>
</html>