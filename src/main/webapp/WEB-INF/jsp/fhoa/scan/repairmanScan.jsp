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
									<div class="row" style="margin-top: 15px;">
									<label for="machineCode" class="control-label" style="margin-left: 66px;"><h4 >扫描机器号:</h4></label>
								</div>
								<div class="row" style="margin-top: 15px;">
									<div class="col-sm-4 control-label">
										<input type="text" name="machineCode" id="machineCode" value="" maxlength="50" placeholder="请扫描机器号"  class="form-control" style="height: 44px;margin-left: 86px;"/>
									</div>
								</div>
								<div class="row" style="margin-top: 24px;">
									<label class="control-label" style="margin-left: 66px;"><h4 >机器信息:</h4></label>
								</div>
								<div class="row" style="margin-top: 20px;">
									<table style="font-size: 16px;">
										<tr>
											<td style="width: 66px;"></td>
											<td>机器名称:</td>
											<td><input type="text" name="name" id="name"  maxlength="50"  class="form-control" style="border: 0px"/></td>
											<td>机器类型:</td>
											<td><input type="text" name="type" id="type"  maxlength="50"  class="form-control" style="border: 0px"/></td>
											<td>机器编号:</td>
											<td><input type="text" name="code" id="code"  maxlength="50" class="form-control" style="border: 0px"/></td>
										</tr>
									</table>
									<%--<label for="NAME" class="col-sm-1 control-label" style="width: 120px;">机器名称:</label>--%>
									<%--<div class="col-sm-2">--%>
										<%--<input type="text" name="name" id="name"  maxlength="50"  class="form-control" style="border: 0px"/>--%>
									<%--</div>--%>
									<%--<label for="type" class="col-sm-1 control-label" style="width: 120px;">机器类型:</label>--%>
									<%--<div class="col-sm-2">--%>
										<%--<input type="text" name="type" id="type"  maxlength="50"  class="form-control" style="border: 0px"/>--%>
									<%--</div>--%>
									<%--<label for="code" class="col-sm-1 control-label" style="width: 120px;">机器编号:</label>--%>
									<%--<div class="col-sm-2">--%>
										<%--<input type="text" name="code" id="code"  maxlength="50" class="form-control" style="border: 0px"/>--%>
									<%--</div>--%>
									<input type="hidden" id="USERNAME" name="USERNAME" />
									<input type="hidden" id="CONTENT" name="CONTENT" />
									<input type="hidden" id="mhid" name="mhid" />
									<input type="hidden" id="rule" name="rule" />
									<%--扫描类型--%>
									<input type="hidden" id="scan_type" name="scan_type" />
									<%--保养类型--%>
									<input type="hidden" id="cycle_type" name="cycle_type" />
									<input type="hidden" id="cycle_type_scan" name="cycle_type_scan" />
									<%--操作类型--%>
									<input type="hidden" id="operation_type" name="operation_type" />
									<%--维修部位--%>
									<input type="hidden" id="repair_position_scan" name="repair_position_scan" />
									<input type="hidden" id="repair_position" name="repair_position" />
									<%--目标规格--%>
									<input type="hidden" id="target_rule" name="target_rule" />
									<input type="hidden" id="target_rule_scan" name="target_rule_scan" />
									<%--更改部位--%>
									<input type="hidden" id="change_position" name="change_position" />
									<input type="hidden" id="change_position_scan" name="change_position_scan" />
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="machineCode" class="control-label" style="margin-left: 66px;"><h4 选择扫描类型:</h4></label>
									</div>
								</div>
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<%--<label class="col-sm-2 control-label"></label>--%>
										<button type="button" class="btn btn-primary btn-lg"  onclick="xsScan()" style="margin-left: 66px">巡视扫描</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="machineCodeCheck('wxModal')" style="margin-left: 5em;">维修扫描</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="machineCodeCheck('byModal')" style="margin-left: 5em;">保养扫描</button>
										<button type="button" class="btn btn-primary btn-lg"  onclick="machineCodeCheck('gggModal')" style="margin-left: 5em;">改规格扫描</button>
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
<div class="modal fade" id="xsModal" tabindex="-1" role="dialog" aria-labelledby="xsModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-footer" style="text-align: center">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
				<button type="button" class="btn btn-primary" onclick="xsbtn(this)">确定操作</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="wxModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<h4 class="modal-title">维修类型:</h4>
				<div class="row">
					<input type="button" class="btn btn-default" value="开始维修" name="repairType" style="margin-left: 2em;" dvalue="0">
					<input type="button" class="btn btn-default" value="结束维修" name="repairType" style="margin-left: 2em;" dvalue="1">
				</div>
				<h4 class="modal-title" >请选择维修项目:</h4>
				<div class="row" id="repairProject">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
				<button type="button" class="btn btn-primary" onclick="xsbtn(this)">确定操作</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="byModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<h4 class="modal-title">保养类型:(单选)</h4>
				<div class="row" id="cycleType">

				</div>
				<h4 class="modal-title" style="margin-top: 10px;">保养说明:</h4>
				<div class="row">
					<textarea id="cycleDesc" style="margin-left: 2em;margin-top: 10px;" rows="8" cols="45">
					</textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
				<button type="button" class="btn btn-primary" onclick="xsbtn(this)">确定操作</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="gggModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<h4 class="modal-title">更改类型:(单选)</h4>
				<div class="row">
					<input type="button" class="btn btn-default" value="开始更改" name="partsType" style="margin-left: 2em;" dvalue="0">
					<input type="button" class="btn btn-default" value="结束更改" name="partsType" style="margin-left: 2em;" dvalue="1">
				</div>
				<h4 class="modal-title" style="margin-top: 10px;">目标规格:(单选)</h4>
				<div class="row" id="partsRule">

				</div>
				<h4 class="modal-title" style="margin-top: 10px;">更改部位:(多选)</h4>
				<div class="row" id="partsId">

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
				<button type="button" class="btn btn-primary" onclick="xsbtn(this)">确定操作</button>
			</div>
		</div>
	</div>
</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script src="static/login/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var scanUrl = "<%=basePath%>";
</script>
<!-- inline scripts related to this page -->
<script src="static/js/myjs/scan.js"></script>
</body>
</html>