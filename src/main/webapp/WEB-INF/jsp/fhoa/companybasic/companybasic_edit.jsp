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
	<style type="text/css">
		.form-control {
			display: block;
			font-weight: normal;
			border: 1px solid #0e77d9 !important;
			border-radius: 4px;

		}
	</style>
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
					
					<form action="companybasic/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="OCBID" id="OCBID" value="${pd.OCBID}"/>
						<input type="hidden" name="TYPE" id="TYPE" value="${pd.TYPE}">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">
									<c:if test="${pd.TYPE == 'staffPost' }">人员岗位</c:if>
									<c:if test="${pd.TYPE == 'machineType' }">类型名称</c:if>
									<c:if test="${pd.TYPE == 'carType' }">类型名称</c:if>
									<c:if test="${pd.TYPE == 'machineRule' }">机器规格</c:if>
									<c:if test="${pd.TYPE == 'maintenanceProject' }">维修项目</c:if>
									<c:if test="${pd.TYPE == 'machineCycle' }">保养周期</c:if>
									<c:if test="${pd.TYPE == 'rulePosition' }">规格更改部位</c:if><span style="color: red">*</span>:
								</td>
								<td><input type="text" class="form-control"  name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">启用状态<span style="color: red">*</span>:</td>
								<td>
									<select id="STATUS" name="STATUS"  class="chosen-select form-control" style="vertical-align:top;width:98%;">
										<option value="">请选择</option>
										<option value="0" <c:if test="${!empty pd.STATUS &&  pd.STATUS == 0 }"> selected</c:if>  >未启用</option>
										<option value="1"<c:if test="${!empty pd.STATUS &&  pd.STATUS == 1}"> selected</c:if> >已启用</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">排序号<span style="color: red">*</span>:</td>
								<td><input type="number" class="form-control"  name="OCB_ORDER" id="OCB_ORDER" value="${pd.OCB_ORDER}" maxlength="32" placeholder="排序号" title="排序号" style="width:98%;" readonly/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">描述:</td>
								<td>
									<textarea name="OCB_DESC" id="OCB_DESC"  rows="3" cols="40" style="width:98%;border: 1px solid #0e77d9;">${pd.OCB_DESC}</textarea>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-qg" onclick="save();">保存</a>
									<a class="btn btn-mini btn-qg" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
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
		//保存
		function save(){

			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'行业名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#STATUS").val()==""){
				$("#STATUS").tips({
					side:3,
		            msg:'启用状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STATUS").focus();
			return false;
			}
			if($("#OCB_ORDER").val()==""){
				$("#OCB_ORDER").tips({
					side:3,
		            msg:'排序号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OCB_ORDER").focus();
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

//		$('#STATUS').chosen({disable_search:true});
		</script>
</body>
</html>