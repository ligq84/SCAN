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
				<div class="row">
					<form action="staff/${msg}.do" name="Form" id="Form" method="post" class="form-horizontal">
						<input type="hidden" name="STAFF_ID" id="STAFF_ID" value="${pd.STAFF_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">基础信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">姓名:</label>
								<div class="col-sm-2">
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入姓名" title="姓名" class="form-control"/>
								</div>
								<label for="SEX" class="col-sm-1 control-label">性别:</label>
								<div class="col-sm-2">
									<select name="SEX" id="SEX" class="form-control">
										<option <c:if test="${pd.SEX == '男'}">selected</c:if>>男</option>
										<option <c:if test="${pd.SEX == '女'}">selected</c:if>>女</option>
									</select>
								</div>
								<label for="BIRTHDAY" class="col-sm-1 control-label">出生日期:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker" name="BIRTHDAY" id="BIRTHDAY" value="${pd.BIRTHDAY}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="出生日期" title="出生日期" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">籍贯:</label>
								<div class="col-sm-2">
									<input type="text" name="FADDRESS" id="FADDRESS" value="${pd.FADDRESS}" maxlength="100" placeholder="这里输入籍贯" title="籍贯" style="width:98%;"/>
								</div>
								<label for="SEX" class="col-sm-1 control-label">电话:</label>
								<div class="col-sm-2">
									<input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="20" placeholder="这里输入电话" title="电话" style="width:98%;"/>
								</div>
								<label for="BIRTHDAY" class="col-sm-1 control-label">身份证号:</label>
								<div class="col-sm-3">
									<input type="text" name="SFID" id="SFID" value="${pd.SFID}" maxlength="20" placeholder="这里输入身份证号" title="身份证号" style="width:98%;"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">现住址:</label>
								<div class="col-sm-2">
									<select id="PROVINCE" name="PROVINCE" class="chosen-select form-control" data-placeholder="请选择省份" style="vertical-align:top;">
										<c:forEach items="${PROVINCEList}" var="province">
											<option value="${province.DICTIONARIES_ID }" <c:if test="${province.DICTIONARIES_ID == pd.PROVINCE}">selected</c:if>>${province.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-2">
									<select id="CITY" name="CITY"   class="chosen-select form-control" data-placeholder="请选择城市" style="vertical-align:top;">
										<c:forEach items="${CITYList}" var="city">
											<option value="${city.DICTIONARIES_ID }" <c:if test="${city.DICTIONARIES_ID == pd.CITY}">selected</c:if>>${city.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-2">
									<select id="AREA" name="AREA"  class="chosen-select form-control" data-placeholder="请选择区域" style="vertical-align:top;">
										<c:forEach items="${AREAList}" var="area">
											<option value="${area.DICTIONARIES_ID }" <c:if test="${area.DICTIONARIES_ID == pd.AREA}">selected</c:if>>${area.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-3">
									<input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="100" placeholder="这里输入详细地址" title="详细地址" style="width: 98%"/>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">学历信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">最高学历:</label>
								<div class="col-sm-2">
									<input type="text" name="EDUCATION" id="EDUCATION" value="${pd.EDUCATION}" maxlength="10" placeholder="这里输入学历" title="学历" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">毕业学校:</label>
								<div class="col-sm-2">
									<input type="text" name="SCHOOL" id="SCHOOL" value="${pd.SCHOOL}" maxlength="30" placeholder="这里输入毕业学校" title="毕业学校" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">毕业时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker" name="BIRTHDAY" id="graduate" value="${pd.GRADUATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="毕业时间" title="毕业时间" style="width:98%;"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">专业:</label>
								<div class="col-sm-2">
									<input type="text" name="MAJOR" id="MAJOR" value="${pd.MAJOR}" maxlength="30" placeholder="这里输入专业" title="专业" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">邮箱:</label>
								<div class="col-sm-2">
									<input type="text" name="EMAIL" id="EMAIL" value="${pd.EMAIL}" maxlength="50" placeholder="这里输入邮箱" title="邮箱" style="width:98%;"/>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">工作信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">工作时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker" name="JOBJOINTIME" id="JOBJOINTIME" value="${pd.JOBJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="首次参加工作时间" title="参加工作时间" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">入职时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker" name="DJOINTIME" id="DJOINTIME" value="${pd.DJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="进本单位时间" title="进本单位时间" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">所在部门:</label>
								<div class="col-sm-2">
									<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
									<div class="selectTree" id="selectTree"></div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">所在岗位:</label>
								<div class="col-sm-2">
									<input type="text" name="POST" id="POST" value="${pd.POST}" maxlength="30" placeholder="这里输入现岗位" title="现岗位" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label">在职状态:</label>
								<div class="col-sm-2">
									<select name="STATUS" id="STATUS" class="form-control">
										<option <c:if test="${pd.STATUS == 0}">selected</c:if>>在职</option>
										<option <c:if test="${pd.STATUS == 1}">selected</c:if>>离职</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label">人员简介:</label>
								<div class="col-sm-4">
									<textarea name="FUNCTIONS" id="FUNCTIONS" rows="6" cols="95">${pd.FUNCTIONS}</textarea>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">系统账号</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="USERNAME" class="col-sm-1 control-label">系统账号:</label>
								<div class="col-sm-2">
									<input type="text" name="USERNAME" id="USERNAME" value="${pd.USERNAME}" maxlength="30" placeholder="这里输入系统账号" title="系统账号" style="width:98%;"/>
								</div>
								<label for="PASSWORD" class="col-sm-1 control-label">登录密码:</label>
								<div class="col-sm-2">
									<input type="text" name="PASSWORD" id="PASSWORD" value="${pd.PASSWORD}" maxlength="30" placeholder="这里输入登录密码" title="登录密码" style="width:98%;"/>
								</div>
								<label for="role_id" class="col-sm-1 control-label">系统角色:</label>
								<div class="col-sm-2">
									<select class="chosen-select form-control" name="ROLE_ID" id="role_id" data-placeholder="这里输入系统角色" style="vertical-align:top;"  title="系统角色" style="width:98%;" >
										<option value=""></option>
										<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left:50px;text-align: center;">
							<div class="form-group" style="margin-top: 10px">
								<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
								<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
							</div>
						</div>
						<%--<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px">--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">英文:</td>--%>
								<%--<td><input type="text" name="NAME_EN" id="NAME_EN" value="${pd.NAME_EN}" maxlength="50" placeholder="这里输入英文" title="英文" style="width:98%;"/></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">婚否:</td>--%>
								<%--<td>--%>
									<%--<select name="MARITAL" id="MARITAL" style="width:98%;">--%>
										<%--<option <c:if test="${pd.MARITAL == '未婚'}">selected</c:if>>未婚</option>--%>
										<%--<option <c:if test="${pd.MARITAL == '已婚'}">selected</c:if>>已婚</option>--%>
									<%--</select>--%>
								<%--</td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">政治面貌:</td>--%>
								<%--<td><input type="text" name="POLITICAL" id="POLITICAL" value="${pd.POLITICAL}" maxlength="30" placeholder="这里输入政治面貌" title="政治面貌" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">员工编号:</td>--%>
								<%--<td><input type="text" name="BIANMA" id="BIANMA" value="${pd.BIANMA}" maxlength="100" placeholder="这里输入编码" title="编码" style="width:98%;"/></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">民族:</td>--%>
								<%--<td><input type="text" name="NATION" id="NATION" value="${pd.NATION}" maxlength="10" placeholder="这里输入民族" title="民族" style="width:98%;"/></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">入团时间:</td>--%>
								<%--<td><input class="span10 date-picker" name="PJOINTIME" id="PJOINTIME" value="${pd.PJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="入团时间" title="入团时间" style="width:100%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">所在部门:</td>--%>
								<%--<td>--%>

								<%--</td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">所在岗位:</td>--%>
								<%--<td></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">岗位类别:</td>--%>
								<%--<td><input type="text" name="JOBTYPE" id="JOBTYPE" value="${pd.JOBTYPE}" maxlength="30" placeholder="这里输入岗位类别" title="岗位类别" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">工作职责:</td>--%>
								<%--<td colspan="10"></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">工作时间:</td>--%>
								<%--<td></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">:</td>--%>
								<%--<td></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">上岗时间:</td>--%>
								<%--<td><input class="span10 date-picker" name="POJOINTIME" id="POJOINTIME" value="${pd.POJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="上岗时间" title="上岗时间" style="width:98%;"/></td>--%>
							<%--</tr>--%>


							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">职业职称:</td>--%>
								<%--<td><input type="text" name="FTITLE" id="FTITLE" value="${pd.FTITLE}" maxlength="30" placeholder="这里输入职称" title="职称" style="width:98%;"/></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">资格证书:</td>--%>
								<%--<td colspan="10"><input type="text" name="CERTIFICATE" id="CERTIFICATE" value="${pd.CERTIFICATE}" maxlength="30" placeholder="这里输入职业资格证" title="职业资格证" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">合同时长:</td>--%>
								<%--<td><input type="number" name="CONTRACTLENGTH" id="CONTRACTLENGTH" value="${pd.CONTRACTLENGTH}" maxlength="32" placeholder="输入劳动合同时长" title="劳动合同时长" style="width:86%;"/>&nbsp;年</td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">签订日期:</td>--%>
								<%--<td><input class="span10 date-picker" name="CSTARTTIME" id="CSTARTTIME" value="${pd.CSTARTTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="签订日期" title="签订日期" style="width:98%;"/></td>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">终止日期:</td>--%>
								<%--<td><input class="span10 date-picker" name="CENDTIME" id="CENDTIME" value="${pd.CENDTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="终止日期" title="终止日期" style="width:98%;"/></td>--%>
							<%--</tr>--%>
						<%--</table>--%>
						<%--<table id="table_report" class="table table-striped table-bordered table-hover" style="border: 0px;">--%>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>--%>
								<%--<td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td style="text-align: center;" colspan="10">--%>
									<%----%>
								<%--</td>--%>
							<%--</tr>--%>
						<%--</table>--%>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
//			if($("#NAME_EN").val()==""){
//				$("#NAME_EN").tips({
//					side:3,
//		            msg:'请输入英文',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#NAME_EN").focus();
//			return false;
//			}
			if($("#BIANMA").val()==""){
				$("#BIANMA").tips({
					side:3,
		            msg:'请输入编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIANMA").focus();
			return false;
			}
			if($("#DEPARTMENT_ID").val()==""){
				$("#DEPARTMENT_ID").tips({
					side:3,
		            msg:'请输入部门',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPARTMENT_ID").focus();
			return false;
			}
			if($("#FUNCTIONS").val()==""){
				$("#FUNCTIONS").tips({
					side:3,
		            msg:'请输入简介',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FUNCTIONS").focus();
			return false;
			}
			if($("#TEL").val()==""){
				$("#TEL").tips({
					side:3,
		            msg:'请输入电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TEL").focus();
			return false;
			}
			if($("#EMAIL").val()==""){
				$("#EMAIL").tips({
					side:3,
		            msg:'请输入邮箱',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMAIL").focus();
			return false;
			}
			if($("#SEX").val()==""){
				$("#SEX").tips({
					side:3,
		            msg:'请输入性别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SEX").focus();
			return false;
			}
			if($("#BIRTHDAY").val()==""){
				$("#BIRTHDAY").tips({
					side:3,
		            msg:'请输入出生日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIRTHDAY").focus();
			return false;
			}
			if($("#NATION").val()==""){
				$("#NATION").tips({
					side:3,
		            msg:'请输入民族',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NATION").focus();
			return false;
			}
//			if($("#JOBTYPE").val()==""){
//				$("#JOBTYPE").tips({
//					side:3,
//		            msg:'请输入岗位类别',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#JOBTYPE").focus();
//			return false;
//			}
			if($("#JOBJOINTIME").val()==""){
				$("#JOBJOINTIME").tips({
					side:3,
		            msg:'请输入参加工作时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JOBJOINTIME").focus();
			return false;
			}
			if($("#FADDRESS").val()==""){
				$("#FADDRESS").tips({
					side:3,
		            msg:'请输入籍贯',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FADDRESS").focus();
			return false;
			}
//			if($("#POLITICAL").val()==""){
//				$("#POLITICAL").tips({
//					side:3,
//		            msg:'请输入政治面貌',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#POLITICAL").focus();
//			return false;
//			}
//			if($("#PJOINTIME").val()==""){
//				$("#PJOINTIME").tips({
//					side:3,
//		            msg:'请输入入团时间',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#PJOINTIME").focus();
//			return false;
//			}
			if($("#SFID").val()==""){
				$("#SFID").tips({
					side:3,
		            msg:'请输入身份证号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SFID").focus();
			return false;
			}
//			if($("#MARITAL").val()==""){
//				$("#MARITAL").tips({
//					side:3,
//		            msg:'请输入婚姻状况',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#MARITAL").focus();
//			return false;
//			}
			if($("#DJOINTIME").val()==""){
				$("#DJOINTIME").tips({
					side:3,
		            msg:'请输入进本单位时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DJOINTIME").focus();
			return false;
			}
			if($("#POST").val()==""){
				$("#POST").tips({
					side:3,
		            msg:'请输入现岗位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#POST").focus();
			return false;
			}
//			if($("#POJOINTIME").val()==""){
//				$("#POJOINTIME").tips({
//					side:3,
//		            msg:'请输入上岗时间',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#POJOINTIME").focus();
//			return false;
//			}
			if($("#EDUCATION").val()==""){
				$("#EDUCATION").tips({
					side:3,
		            msg:'请输入学历',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EDUCATION").focus();
			return false;
			}
			if($("#SCHOOL").val()==""){
				$("#SCHOOL").tips({
					side:3,
		            msg:'请输入毕业学校',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCHOOL").focus();
			return false;
			}
			if($("#MAJOR").val()==""){
				$("#MAJOR").tips({
					side:3,
		            msg:'请输入专业',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MAJOR").focus();
			return false;
			}
//			if($("#FTITLE").val()==""){
//				$("#FTITLE").tips({
//					side:3,
//		            msg:'请输入职称',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#FTITLE").focus();
//			return false;
//			}
//			if($("#CERTIFICATE").val()==""){
//				$("#CERTIFICATE").tips({
//					side:3,
//		            msg:'请输入职业资格证',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CERTIFICATE").focus();
//			return false;
//			}
//			if($("#CONTRACTLENGTH").val()==""){
//				$("#CONTRACTLENGTH").tips({
//					side:3,
//		            msg:'请输入劳动合同时长',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CONTRACTLENGTH").focus();
//			return false;
//			}
//			if($("#CSTARTTIME").val()==""){
//				$("#CSTARTTIME").tips({
//					side:3,
//		            msg:'请输入签订日期',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CSTARTTIME").focus();
//			return false;
//			}
//			if($("#CENDTIME").val()==""){
//				$("#CENDTIME").tips({
//					side:3,
//		            msg:'请输入终止日期',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CENDTIME").focus();
//			return false;
//			}
			if($("#ADDRESS").val()==""){
				$("#ADDRESS").tips({
					side:3,
		            msg:'请输入现住址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESS").focus();
			return false;
			}
//			if($("#BZ").val()==""){
//				$("#BZ").tips({
//					side:3,
//		            msg:'请输入备注',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#BZ").focus();
//			return false;
//			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		function change2(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
				data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#CITY").html('<option>请选择</option>');
//					$("#level4").html('<option>请选择</option>');
					$.each(data.list, function(i, dvar){
						$("#CITY").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					});
				}
			});
		}

		//第三级值改变事件(初始第四级)
		function change3(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
				data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level4").html('<option>请选择</option>');
					$.each(data.list, function(i, dvar){
						$("#level4").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					});
				}
			});
		}
		//下拉树
		var defaultNodes = {"treeNodes":${zTreeNodes}};
		function initComplete(){
			//绑定change事件
			$("#selectTree").bind("change",function(){
				if(!$(this).attr("relValue")){
			      //  top.Dialog.alert("没有选择节点");
			    }else{
					//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
					$("#DEPARTMENT_ID").val($(this).attr("relValue"));
			    }
			});
			//赋给data属性
			$("#selectTree").data("data",defaultNodes);  
			$("#selectTree").render();
			$("#selectTree2_input").val("${null==depname?'请选择':depname}");
		}
		$(function() {
			$('#role_id').chosen({allow_single_deselect:true});
			//下拉框
			if(!ace.vars['touch']) {
				$('#PROVINCE').chosen({allow_single_deselect:true}).change(function(){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
						data: {DICTIONARIES_ID:$("#PROVINCE").val()},
						dataType:'json',
						cache: false,
						success: function(data){
							$("#CITY").html('<option>请选择城市</option>');
							$("#AREA").html('<option>请选择区域</option>');
							$.each(data.list, function(i, dvar){
								$("#CITY").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							});
							$('#CITY').trigger("chosen:updated");
							$('#AREA').trigger("chosen:updated");
						}

					});
				});
				$('#CITY').chosen({allow_single_deselect:true}).change(function(){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
						data: {DICTIONARIES_ID:$("#CITY").val()},
						dataType:'json',
						cache: false,
						success: function(data){
							$("#AREA").html('<option>请选择区域</option>');
							$.each(data.list, function(i, dvar){
								$("#AREA").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							});
							$('#AREA').trigger("chosen:updated")
						}
					});
				});
				$('#AREA').chosen();
			}
		});
		</script>
</body>
</html>