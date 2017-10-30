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
	<link rel="stylesheet" href="static/css/pagePublic.css" />
	<!-- 树形下拉框end -->
	<style type="text/css">
		/*::-webkit-scrollbar{*/
			/*display: none;*/
		/*}*/
		textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
			color: #282828;
			border: 1px solid #0e77d9;
		}
		input[readonly]:hover {
			border-color: #0e77d9;

		}
		input[readonly] {
			background-color: white !important;
			cursor: default;
		}
		.form-control {
			display: block;
			font-weight: normal;
			border: 1px solid #0e77d9;
			border-radius: 4px;

		}
		.col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 {
			position: relative;
			min-height: 1px;
		 	padding-right: 2px;
			padding-left: 2px;
		}

		.col-sm-1 {
			width: 125px;;
			font-weight: normal;
		}

		.chosen-container-single .chosen-single {
			position: relative;
			display: block;
			overflow: hidden;
			padding: 0 0 0 8px;
			height: 34px;
			border: 1px solid #0e77d9;
			border-radius: 5px;
			background: none !important;
			box-shadow: 0 0 3px white inset, 0 1px 1px rgba(0, 0, 0, 0.1);
			color: #282828;
			text-decoration: none;
			white-space: nowrap;
			line-height: 34px;
		}
		.chosen-container-single .chosen-search input[type="text"] {
			background: none !important;
		}
		.chosen-container .chosen-drop {
			border: 1px solid #0e77d9;
			background-image: none !important;
			background-color: white;
		}
		.chosen-container-active.chosen-with-drop .chosen-single {
			border-color: #0e77d9;
		}
		.chosen-container-single .chosen-single abbr {
			position: absolute;
			top: 6px;
			right: 26px;
			display: block;
			width: 12px;
			height: 12px;
			background-image: none;
			font-size: 1px;
		}
		.date-picker{
			cursor: pointer !important;
		}
		.row{
			margin: 0px;
		}
		.form-horizontal .form-group {
			 margin-right:0px;
			margin-left: 0px;
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
					<form action="staff/${msg}.do" name="Form" id="Form" method="post" class="form-horizontal">
						<input type="hidden" name="STAFF_ID" id="STAFF_ID" value="${pd.STAFF_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">基础信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>姓名:</label>
								<div class="col-sm-2">
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入姓名" title="姓名" class="form-control"/>
								</div>
								<label for="SEX" class="col-sm-1 control-label"><span style="color: red">*</span>性别:</label>
								<div class="col-sm-2">
									<select name="SEX" id="SEX" class="form-control">
										<option>请选择</option>
										<option <c:if test="${pd.SEX == '男'}">selected</c:if>>男</option>
										<option <c:if test="${pd.SEX == '女'}">selected</c:if>>女</option>
									</select>
								</div>
								<label for="BIRTHDAY" class="col-sm-1 control-label"><span style="color: red">*</span>出生日期:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker form-control" name="BIRTHDAY" id="BIRTHDAY" value="${pd.BIRTHDAY}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="出生日期" title="出生日期" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>籍贯:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control" name="FADDRESS" id="FADDRESS" value="${pd.FADDRESS}" maxlength="100" placeholder="这里输入籍贯" title="籍贯" style="width:98%;"/>
								</div>
								<label for="SEX" class="col-sm-1 control-label"><span style="color: red">*</span>电话:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control"  name="TEL" id="TEL" value="${pd.TEL}" maxlength="20" placeholder="这里输入电话" title="电话" style="width:98%;"/>
								</div>
								<label for="BIRTHDAY" class="col-sm-1 control-label"><span style="color: red">*</span>身份证号:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control"  name="SFID" id="SFID" value="${pd.SFID}" maxlength="20" placeholder="这里输入身份证号" title="身份证号" style="width:98%;"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>联系地址:</label>
								<div class="col-sm-2">
										<select id="PROVINCE" name="PROVINCE" class=" form-control" data-placeholder="请选择省份" style="vertical-align:top;">
										<option value="">请选择省份</option>
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
									<input type="text"  class="form-control" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="100" placeholder="这里输入详细地址" title="详细地址" style="width: 98%"/>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">学历信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>最高学历:</label>
								<div class="col-sm-2">
									<%--<input type="text" class="form-control"  name="EDUCATION" id="EDUCATION" value="${pd.EDUCATION}" maxlength="10" placeholder="这里输入学历" title="学历"--%>
										   <%--style="width:98%;"/>--%>
									<select id="EDUCATION" name="EDUCATION"   class="chosen-select form-control" data-placeholder="请选择输入学历" style="vertical-align:top;">
										<option value="">请选择</option>
										<option value="小学" <c:if test="${pd.EDUCATION =='小学'}">selected</c:if>>小学</option>
										<option value="初中" <c:if test="${pd.EDUCATION =='初中'}">selected</c:if>>初中</option>
										<option value="高中" <c:if test="${pd.EDUCATION =='高中'}">selected</c:if>>高中</option>
										<option value="中专" <c:if test="${pd.EDUCATION =='中专'}">selected</c:if>>中专</option>
										<option value="本科" <c:if test="${pd.EDUCATION =='本科'}">selected</c:if>>本科</option>
										<option value="研究生" <c:if test="${pd.EDUCATION =='研究生'}">selected</c:if>>研究生</option>
										<option value="博士" <c:if test="${pd.EDUCATION =='博士'}">selected</c:if>>博士</option>
										<option value="其他" <c:if test="${pd.EDUCATION =='其他'}">selected</c:if>>其他</option>
									</select>
								</div>
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>毕业学校:</label>
								<div class="col-sm-2">
									<input type="text"  class="form-control" name="SCHOOL" id="SCHOOL" value="${pd.SCHOOL}" maxlength="30" placeholder="这里输入毕业学校" title="毕业学校" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>毕业时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker form-control" name="GRADUATE" id="graduate" value="${pd.GRADUATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="毕业时间" title="毕业时间" style="width:98%;"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>专业:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control" name="MAJOR" id="MAJOR" value="${pd.MAJOR}" maxlength="30" placeholder="这里输入专业" title="专业" style="width:98%;"/>
								</div>

							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">工作信息</h4>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>参加工作时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker form-control" name="JOBJOINTIME" id="JOBJOINTIME" value="${pd.JOBJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="首次参加工作时间" title="参加工作时间" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>入职时间:</label>
								<div class="col-sm-2">
									<input class="span10 date-picker form-control" name="DJOINTIME" id="DJOINTIME" value="${pd.DJOINTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="进本单位时间" title="进本单位时间" style="width:98%;"/>
								</div>
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>所在部门:</label>
								<div class="col-sm-2">
									<%--<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>--%>
									<%--<div class="selectTree" id="selectTree"></div>--%>
										<select class="nav-search-input form-control" name="DEPARTMENT_ID" id="DEPARTMENT_ID" style="vertical-align:top;" >
											<option value="">请选择</option>
											<c:forEach items="${deptList}" var="dept">
												<option value="${dept.DEPARTMENT_ID }" <c:if test="${dept.DEPARTMENT_ID == pd.DEPARTMENT_ID }">selected</c:if> >${dept.NAME}</option>
											</c:forEach>
										</select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label" ><span style="color: red">*</span>所在岗位:</label>
								<div class="col-sm-2">
									<select class="chosen-select form-control" name="POST" id="POST" data-placeholder="这里输入现岗位" style="vertical-align:top;"  title="现岗位" style="width:98%;" >
										<option value="">请选择</option>
										<c:forEach items="${staffPostList}" var="staffPost">
											<option value="${staffPost.OCBID }" <c:if test="${staffPost.OCBID == pd.POST }">selected</c:if> >${staffPost.NAME}</option>
										</c:forEach>
									</select>
								</div>
								<label for="NAME" class="col-sm-1 control-label"><span style="color: red">*</span>在职状态:</label>
								<div class="col-sm-2">
									<select name="STATUS" id="STATUS" class="form-control">
										<option value="0" <c:if test="${pd.STATUS == 0}">selected</c:if>>在职</option>
										<option value="1" <c:if test="${pd.STATUS == 1}">selected</c:if>>离职</option>
									</select>
								</div>
								<label for="NAME" class="col-sm-1 control-label" >邮箱:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control"  name="EMAIL" id="EMAIL" value="${pd.EMAIL}" maxlength="50" placeholder="这里输入邮箱" title="邮箱" style="width:98%;text-align: left"/>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left: 15px;">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-1 control-label" >人员简介:</label>
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
								<label for="USERNAME" class="col-sm-1 control-label" >系统账号:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control" name="USERNAME" id="USERNAME" value="${pd.USERNAME}" maxlength="30" placeholder="这里输入系统账号"
										   style="width:98%; text-align: left;cursor: pointer"  <c:if test="${msg =='edit' && not empty pd.USERNAME }">readonly</c:if> />
								</div>
								<label for="PASSWORD" class="col-sm-1 control-label" >登录密码:</label>
								<div class="col-sm-2">
									<input type="text"  class="form-control" name="PASSWORD" id="PASSWORD" value="${pd.PASSWORD}" maxlength="30" placeholder="这里输入登录密码"
										   style="width:98%;text-align: left;"/>
								</div>
								<label for="role_id" class="col-sm-1 control-label" >系统角色:</label>
								<div class="col-sm-2">
									<select class="chosen-select form-control control-label"  name="ROLE_ID" id="role_id" data-placeholder="这里输入系统角色" style="vertical-align:top;"  title="系统角色" style="width:98%;" >
										<option value=""></option>
										<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-left:50px;text-align: center;height: 200px;">
							<div class="form-group" style="margin-top: 10px">
								<a class="btn btn-mini btn-qg" onclick="save();">保存</a>
								<a class="btn btn-mini btn-qg" onclick="back();">返回</a>
							</div>
						</div>
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
		function back(){
			var form = $('<form action="<%=basePath%>staff/list.do" method="get"></form>');
			$(document.body).append(form);
			form.submit()
		}
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
			if(isNaN($("#TEL").val())){
				$("#TEL").tips({
					side:3,
					msg:'电话只能是数字',
					bg:'#AE81FF',
					time:2
				});
				$("#TEL").focus();
				return false;
			}
//			if($("#EMAIL").val()==""){
//				$("#EMAIL").tips({
//					side:3,
//					msg:'请输入邮箱',
//					bg:'#AE81FF',
//					time:2
//				});
//				$("#EMAIL").focus();
//				return false;
//			}
//			if(!ismail($("#EMAIL").val())){
//				$("#EMAIL").tips({
//					side:3	,
//					msg:'邮箱格式不正确',
//					bg:'#AE81FF',
//					time:2
//				});
//				$("#EMAIL").focus();
//				return false;
//			}
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
			if($("#PROVINCE").val()==""){
				$("#PROVINCE").tips({
					side:3,
		            msg:'请输入省份',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROVINCE").focus();
			return false;
			}
			if($("#CITY").val()==""){
				$("#CITY").tips({
					side:3,
		            msg:'请输入城市',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CITY").focus();
			return false;
			}
			if($("#AREA").val()==""){
				$("#AREA").tips({
					side:3,
					msg:'请输入区域',
					bg:'#AE81FF',
					time:2
				});
				$("#AREA").focus();
				return false;
			}
			if($("#STATUS").val()==""){
				$("#STATUS").tips({
					side:3,
					msg:'请输入在职状态',
					bg:'#AE81FF',
					time:2
				});
				$("#STATUS").focus();
				return false;
			}

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
//			if(!IdentityCodeValid($("#SFID").val())){
//				$("#SFID").tips({
//					side:3,
//					msg:'身份证不合法',
//					bg:'#AE81FF',
//					time:2
//				});
//				$("#SFID").focus();
//				return false;
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
			if($("#USERNAME").val()==""){

			}else{
				if(/[\u4E00-\u9FA5]/i.test($("#USERNAME").val())){
					$("#USERNAME").tips({
						side:3,
						msg:'系统账号不能有中文',
						bg:'#AE81FF',
						time:2
					});
					$("#USERNAME").focus();
					return false;
				}

				if($("#USERNAME").val().length<6){
					$("#USERNAME").tips({
						side:3,
						msg:'账号不能小于6位',
						bg:'#AE81FF',
						time:2
					});
					$("#USERNAME").focus();
					return false;
				}
				if($("#PASSWORD").val()==""){
					$("#PASSWORD").tips({
						side:3,
						msg:'请输入密码',
						bg:'#AE81FF',
						time:2
					});
					$("#PASSWORD").focus();
					return false;
				}
				if($("#PASSWORD").val().length<6){
					$("#PASSWORD").tips({
						side:3,
						msg:'密码不能小于6位',
						bg:'#AE81FF',
						time:2
					});
					$("#PASSWORD").focus();
					return false;
				}
				if($("#ROLE_ID").val()==""){
					$("#ROLE_ID").tips({
						side:3,
						msg:'请输入角色',
						bg:'#AE81FF',
						time:2
					});
					$("#ROLE_ID").focus();
					return false;
				}
			}


//			$("#zhongxin").hide();
//			$("#zhongxin2").show();

			$.ajax({
				type: "POST",
				url: '<%=basePath%>staff/${msg}.do',
				data: $("#Form").serializeObject(),
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.result == "success"){
						alert(data.mesg);
						var form = $('<form action="<%=basePath%>staff/list.do" method="get"></form>');
						$(document.body).append(form);
						form.submit()
					}else if(data.result == "fail"){
						alert(data.mesg);
					}else {
						alert("添加异常");
//						$("#zhongxin").show();
//						$("#zhongxin2").hide();
					}
				}
			});
//			$("#Form").submit();

		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true,clearBtn: true,onSelect: function(selectedDate){
				$('.date-picker').not(this).datepicker("option", "maxDate", new Date());
			}});
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
		<%--var defaultNodes = {"treeNodes":${zTreeNodes}};--%>
		<%--function initComplete(){--%>
			<%--//绑定change事件--%>
			<%--$("#selectTree").bind("change",function(){--%>
				<%--if(!$(this).attr("relValue")){--%>
			      <%--//  top.Dialog.alert("没有选择节点");--%>
			    <%--}else{--%>
					<%--//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));--%>
					<%--$("#DEPARTMENT_ID").val($(this).attr("relValue"));--%>
			    <%--}--%>
			<%--});--%>
			<%--//赋给data属性--%>
			<%--$("#selectTree").data("data",defaultNodes);  --%>
			<%--$("#selectTree").render();--%>
			<%--$("#selectTree2_input").val("${null==depname?'请选择':depname}");--%>
		<%--}--%>
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

		function ismail(mail){
			return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
		function IdentityCodeValid(code) {
			var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
			var tip = "";
			var pass= true;

			if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
				tip = "身份证号格式错误";
				pass = false;
			}
			else if(!city[code.substr(0,2)]){
				tip = "地址编码错误";
				pass = false;
			}
			else{
				//18位身份证需要验证最后一位校验位
				if(code.length == 18){
					code = code.split('');
					//∑(ai×Wi)(mod 11)
					//加权因子
					var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
					//校验位
					var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
					var sum = 0;
					var ai = 0;
					var wi = 0;
					for (var i = 0; i < 17; i++)
					{
						ai = code[i];
						wi = factor[i];
						sum += ai * wi;
					}
					var last = parity[sum % 11];
					if(parity[sum % 11] != code[17]){
						tip = "校验位错误";
						pass =false;
					}
				}
			}
			return pass;
		}
		</script>
</body>
</html>