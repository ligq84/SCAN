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
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
					<form action="machine/${msg}.do" name="Form" id="Form" method="post" class="form-horizontal">
						<input type="hidden" name="MHID" id="MACHINE_ID" value="${pd.MHID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
							<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
								<h4 class="lighter">机器基础信息</h4>
							</div>
							<div class="col-sm-12">
								<div class="form-group" style="margin-top: 10px">
									<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>机器名称:</label>
									<div class="col-sm-2">
										<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入机器名称" title="机器名称" class="form-control"/>
									</div>
									<label for="BARCODE" class="col-sm-1 control-label"><span style="color: red">*</span>机器编号:</label>
									<div class="col-sm-2">
										<input type="text" name="BARCODE" id="BARCODE" value="${pd.BARCODE}" maxlength="50"  class="form-control" readonly/>
									</div>
									<label for="TYPE" class="col-sm-1 control-label"><span style="color: red">*</span>机器类型:</label>
									<div class="col-sm-2">
										<select class="chosen-select form-control" name="TYPE" id="TYPE" data-placeholder="请选择机器类型" style="vertical-align:top;"  title="现岗位" style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${machineTypeList}" var="machineType">
											<option value="${machineType.OCBID }" <c:if test="${machineType.OCBID == pd.TYPE}">selected</c:if> >${machineType.NAME}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group" style="margin-top: 10px">
									<label for="MODEL" class="col-sm-1 control-label"><span style="color: red">*</span>机器型号:</label>
									<div class="col-sm-2">
										<input type="text" name="MODEL" id="MODEL" value="${pd.MODEL}" maxlength="50" placeholder="这里输入机器型号" title="机器型号" class="form-control"/>
									</div>
									<label for="POWER" class="col-sm-1 control-label"><span style="color: red">*</span>机器功率:</label>
									<div class="col-sm-2">
										<input type="text" name="POWER" id="POWER" value="${pd.POWER}" maxlength="50"  class="form-control" placeholder="这里输入机器功率" />
									</div>
									<label for="TYPE" class="col-sm-1 control-label"><span style="color: red">*</span>机器负责人:</label>
									<div class="col-sm-2">
										<select id="CHARGE" name="CHARGE" class="chosen-select form-control" data-placeholder="这里输入机器负责人" style="vertical-align:top;">
											<option value=""></option>
											<c:forEach items="${staffList}" var="staff">
												<option value="${staff.STAFF_ID }" <c:if test="${staff.STAFF_ID == pd.CHARGE}">selected</c:if>>${staff.NAME}+${staff.TEL}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px">
									<label for="MODEL" class="col-sm-1 control-label"><span style="color: red">*</span>白班维修人员:</label>
									<div class="col-sm-2">
										<select id="DAY_REPAIRMAN" name="DAY_REPAIRMAN" class="chosen-select form-control" data-placeholder="这里输入白班维修员" style="vertical-align:top;">
											<option value=""></option>
											<c:forEach items="${staffList}" var="staff">
												<option value="${staff.STAFF_ID }" <c:if test="${staff.STAFF_ID == pd.DAY_REPAIRMAN}">selected</c:if>>${staff.NAME}+${staff.TEL}</option>
											</c:forEach>
										</select>
									</div>
									<label for="POWER" class="col-sm-2 control-label"><span style="color: red">*</span>晚班维修人员:</label>
									<div class="col-sm-2">
										<select id="NIGHT_REPAIRMAN" name="NIGHT_REPAIRMAN" class="chosen-select form-control" data-placeholder="这里输入晚班维修人员" style="vertical-align:top;">
											<option value=""></option>
											<c:forEach items="${staffList}" var="staff">
												<option value="${staff.STAFF_ID }" <c:if test="${staff.STAFF_ID == pd.NIGHT_REPAIRMAN}">selected</c:if>>${staff.NAME}+${staff.TEL}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-12 widget-header widget-header-blue widget-header-flat wi1dget-header-large" style="padding: 0px;margin: 0px;">
								<h4 class="lighter">机器保养信息</h4>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px">
									<label class="col-sm-1 control-label no-padding-right">保养方式：</label>
									<div class="col-sm-10">
										<c:forEach items="${machineCycleList}" var="var" varStatus="vs">
											<label style="float:left;padding-left: 8px;padding-top:7px;">
												<input name="checkbox1" type="checkbox" class="ace" value="${var.OCBID}"><span class="lbl" onclick="">${var.NAME}</span>
											</label>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px">
									<label class="col-sm-1 control-label no-padding-right">保养方式：</label>
									<div class="col-sm-2">
										<textarea rows="5" cols="30"></textarea>
									</div>
									<label class="col-sm-1 control-label no-padding-right">保养方式：</label>
									<div class="col-sm-2">
										<textarea rows="5" cols="30"></textarea>
									</div>
									<label class="col-sm-1 control-label no-padding-right">保养方式：</label>
									<div class="col-sm-2">
										<textarea rows="5" cols="30"></textarea>
									</div>

								</div>
							</div>
							<div class="col-sm-12 widget-header widget-header-blue widget-header-flat wi1dget-header-large" style="padding: 0px;margin: 0px;">
								<h4 class="lighter">机器维修信息 <a class="btn btn-mini btn-primary" onclick="addMP()" style="margin-left: 20px;" >添加</a></h4>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px" id="mplist">
									<div id="mpvalue1">
									<label class="col-sm-1 control-label no-padding-right">维修项目1：</label>
									<div class="col-sm-2">
										<select class="chosen-select form-control" name="mp1" id="mp1" data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${mpList}" var="mp">
												<%--<option value="${mp.OCBID }" <c:if test="${machineType.OCBID == pd.TYPE}">selected</c:if> >${mp.NAME}</option>--%>
												<option value="${mp.OCBID }">${mp.NAME}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-sm-1">
										<a class="btn btn-mini btn-danger" style="margin-top: 2px">删除</a>
									</div>
									</div>
								</div>

							</div>
							<div class="col-sm-12 widget-header widget-header-blue widget-header-flat wi1dget-header-large" style="padding: 0px;margin: 0px;">
								<h4 class="lighter">机器更改规格  <a class="btn btn-mini btn-primary" onclick="" style="margin-left: 20px;">添加</a></h4>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px">
									<label class="col-sm-1 control-label no-padding-right">更改规格:</label>
									<div class="col-sm-2">
										<label style="float:left;padding-left: 20px;padding-top:7px;">
											<input name="CHANGE_RULE" type="radio" class="ace" <c:if test="${pd.CHANGE_RULE == 0}">checked</c:if> ><span class="lbl">支持</span>
										</label>
										<label style="float:left;padding-left:35px;padding-top:7px;">
											<input name="CHANGE_RULE" type="radio" class="ace"  <c:if test="${pd.CHANGE_RULE == 1}">checked</c:if>  ><span class="lbl">不支持</span>
										</label>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" >
									<label class="col-sm-1 control-label no-padding-right">支持规格:</label>
									<div class="col-sm-2">
										<c:forEach items="${ruleList}" var="var" varStatus="vs">
											<label style="float:left;padding-left: 8px;padding-top:7px;">
												<input name="checkbox1" type="checkbox" class="ace" value="${var.OCBID}"><span class="lbl" onclick="">${var.NAME}</span>
											</label>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" >
									<label class="col-sm-1 control-label no-padding-right">更改规格1:</label>
									<div class="col-sm-2">
										<select class="chosen-select form-control" name="rp" id="rp" data-placeholder="请选择更改规格" style="vertical-align:top;"  style="width:70%;" >
											<option value=""></option>
											<c:forEach items="${rulePosttionList}" var="rp">
												<%--<option value="${mp.OCBID }" <c:if test="${machineType.OCBID == pd.TYPE}">selected</c:if> >${mp.NAME}</option>--%>
												<option value="${rp.OCBID }">${rp.NAME}</option>
											</c:forEach>
										</select>

									</div>
									<div class="col-sm-1">
										<a class="btn btn-mini btn-danger" style="margin-top: 2px">删除</a>
									</div>
								</div>
							</div>
						<%--<table id="table_report" class="table table-striped table-bordered table-hover">--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">更改规格:</td>--%>
								<%--<td><input type="number" name="CHANGE_RULE" id="CHANGE_RULE" value="" maxlength="32" placeholder="这里输入更改规格" title="更改规格" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="text-align: center;" colspan="10">--%>
									<%--<a class="btn btn-mini btn-primary" onclick="save();">保存</a>--%>
									<%--<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>--%>
								<%--</td>--%>
							<%--</tr>--%>
						<%--</table>--%>
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
		$(top.hangge());
		function addMP(){
			var mplist = $("#mplist");
			mplist.append('<div id="mpvalue${mp.OCBID }">'+
							'<label class="col-sm-1 control-label no-padding-right">维修项目1：</label>'+
							'<div class="col-sm-2">'+
							'		<select class="chosen-select form-control" name="mpv1"  data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >'+
							'				<option value=""></option>'+
											<c:forEach items="${mpList}" var="mp">
													'<option value="${mp.OCBID }">${mp.NAME}</option>'+
											</c:forEach>
							'		</select>'+
							'</div>'+
							'<div class="col-sm-1">'+
							'		<a class="btn btn-mini btn-danger" style="margin-top: 2px">删除</a>'+
							'</div>'+
							'<div>');
		}
		//保存
		function save(){
			if($("#MHID").val()==""){
				$("#MHID").tips({
					side:3,
		            msg:'请输入备注1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MHID").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入机器名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPE").focus();
			return false;
			}
			if($("#MODEL").val()==""){
				$("#MODEL").tips({
					side:3,
		            msg:'请输入型号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODEL").focus();
			return false;
			}
			if($("#POWER").val()==""){
				$("#POWER").tips({
					side:3,
		            msg:'请输入功率',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#POWER").focus();
			return false;
			}
			if($("#CHARGE").val()==""){
				$("#CHARGE").tips({
					side:3,
		            msg:'请输入机器负责人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CHARGE").focus();
			return false;
			}
			if($("#DAY_REPAIRMAN").val()==""){
				$("#DAY_REPAIRMAN").tips({
					side:3,
		            msg:'请输入白班维修员',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DAY_REPAIRMAN").focus();
			return false;
			}
			if($("#NIGHT_REPAIRMAN").val()==""){
				$("#NIGHT_REPAIRMAN").tips({
					side:3,
		            msg:'请输入Night_Repairman',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NIGHT_REPAIRMAN").focus();
			return false;
			}
			if($("#BARCODE").val()==""){
				$("#BARCODE").tips({
					side:3,
		            msg:'请输入机器编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BARCODE").focus();
			return false;
			}
			if($("#BARCODEURL").val()==""){
				$("#BARCODEURL").tips({
					side:3,
		            msg:'请输入条码图片路径',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BARCODEURL").focus();
			return false;
			}
			if($("#COMPANY_ID").val()==""){
				$("#COMPANY_ID").tips({
					side:3,
		            msg:'请输入公司id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_ID").focus();
			return false;
			}
			if($("#DELETED").val()==""){
				$("#DELETED").tips({
					side:3,
		            msg:'请输入备注12',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DELETED").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注13',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
			return false;
			}
			if($("#CHANGE_RULE").val()==""){
				$("#CHANGE_RULE").tips({
					side:3,
		            msg:'请输入更改规格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CHANGE_RULE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			//初始化下拉框
			$('.chosen-select').chosen({allow_single_deselect:true,search_contains:true});
		});
		</script>
</body>
</html>