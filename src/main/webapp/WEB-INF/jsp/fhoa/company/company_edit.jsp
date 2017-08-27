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
		<%--上传文件css--%>
	<link href="plugins/fileinput/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />

	<script src="plugins/fileinput/js/jquery-2.2.4.min.js"></script>
		<%--上传文件js--%>
	<script src="plugins/fileinput/js/fileinput.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js" type="text/javascript"></script>

	<style >
		.imgbox{
			border: 1px solid #D6D6D6;padding: 5px;height: 20em;margin-top: 1em;margin-left:3em;
		}
		.imgboxnext{
			border: 1px solid #D6D6D6;padding: 5px;height: 20em;margin-top: 1em;margin-left:1.3em;
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
					<div class="col-xs-12 widget-box">
					<form action="company/${msg}.do" name="Form" id="Form" method="post" class="form-horizontal">
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">企业基本信息</h4>
						</div>
						<input type="hidden" name="COMPANY_ID" id="COMPANY_ID" value="${pd.COMPANY_ID}"/>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-2 control-label">公司名称:</label>
								<div class="col-sm-8">
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}"  placeholder="公司名称" title="公司名称" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="NAME" class="col-sm-2 control-label">公司地址:</label>
								<div class="col-sm-2">
									<select id="PROVINCE" name="PROVINCE" onchange="change2(this.value)" class="chosen-select form-control" data-placeholder="请选择等级" style="vertical-align:top;">
										<c:forEach items="${PROVINCEList}" var="province">
											<option value="${province.DICTIONARIES_ID }" <c:if test="${province.DICTIONARIES_ID == pd.PROVINCE}">selected</c:if>>${province.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-2">
									<select id="CITY" name="CITY"  class="chosen-select form-control" data-placeholder="请选择城市" style="vertical-align:top;">
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
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="ADDRESS" class="col-sm-2 control-label">详细地址:</label>
								<div class="col-sm-5">
									<input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}"  placeholder="详细地址" title="详细地址" class="form-control"/>
								</div>
								<label for="POSTAL_CODE" class="col-sm-1 control-label">邮政编码:</label>
								<div class="col-sm-2">
									<input type="text" name="POSTAL_CODE" id="POSTAL_CODE" value="${pd.POSTAL_CODE}"  placeholder="邮政编码" title="邮政编码" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="NATURE" class="col-sm-2 control-label">公司性质:</label>
								<div class="col-sm-2">
									<select id="NATURE" name="NATURE"  class="chosen-select form-control" data-placeholder="请选择公司性质" style="vertical-align:top;">
										<c:forEach items="${natureList}" var="nature">
											<option value="${nature.DICTIONARIES_ID }" <c:if test="${nature.DICTIONARIES_ID == pd.NATURE}">selected</c:if>>${nature.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<label for="ECONOMIC_TYPE" class="col-sm-1 control-label">公司经济类型:</label>
								<div class="col-sm-2">
									<select id="ECONOMIC_TYPE" name="ECONOMIC_TYPE"  class="chosen-select form-control" data-placeholder="请选择经济类型" style="vertical-align:top;">
										<c:forEach items="${economicTypeList}" var="economicType">
											<option value="${economicType.DICTIONARIES_ID }" <c:if test="${economicType.DICTIONARIES_ID == pd.ECONOMIC_TYPE}">selected</c:if>>${economicType.NAME }</option>
										</c:forEach>
									</select>
								</div>
								<label for="BUSINESS_LICENSE" class="col-sm-1 control-label">营业执照号:</label>
								<div class="col-sm-2">
									<input type="text" name="BUSINESS_LICENSE" id="BUSINESS_LICENSE" value="${pd.BUSINESS_LICENSE}" maxlength="255" placeholder="这里输入营业执照号" title="营业执照号" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="COMPANY_URL" class="col-sm-2 control-label">公司网址:</label>
								<div class="col-sm-2">
									<input type="text" name="COMPANY_URL" id="COMPANY_URL" value="${pd.COMPANY_URL}" maxlength="255" placeholder="这里输入公司网址" title="公司网址" class="form-control"/>
								</div>
								<label for="REGISTERED_CAPITAL" class="col-sm-1 control-label">注册资金:</label>
								<div class="col-sm-2">
									<input type="text" name="REGISTERED_CAPITAL" id="REGISTERED_CAPITAL" value="${pd.REGISTERED_CAPITAL}" maxlength="255" placeholder="这里输入注册资金" title="注册资金" class="form-control"/>
								</div>
								<label for="ORGANIZATION_NUMBER" class="col-sm-1 control-label">组织机构号:</label>
								<div class="col-sm-2">
									<input type="text" name="ORGANIZATION_NUMBER" id="ORGANIZATION_NUMBER" value="${pd.ORGANIZATION_NUMBER}" maxlength="255" placeholder="这里输入组织机构号" title="组织机构号" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="CORPORATION" class="col-sm-2 control-label">法人姓名:</label>
								<div class="col-sm-2">
									<input type="text" name="CORPORATION" id="CORPORATION" value="${pd.CORPORATION}" maxlength="255" placeholder="这里输入法人姓名" title="法人姓名" class="form-control"/>
								</div>
								<label for="ISSUING_AUTHORITY" class="col-sm-1 control-label">发证机关:</label>
								<div class="col-sm-2">
									<input type="text" name="ISSUING_AUTHORITY" id="ISSUING_AUTHORITY" value="${pd.ISSUING_AUTHORITY}" maxlength="255" placeholder="这里输入发证机关" title="发证机关" class="form-control"/>
								</div>
								<label for="START_TIME" class="col-sm-1 control-label">经营时间:</label>
								<div class="col-sm-1">
									<input class="span10 date-picker form-control" name="START_TIME" id="START_TIME" value="${pd.START_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="开始时间">
								</div>
								<div class="col-sm-1">
									<input class="span10 date-picker form-control" name="END_TIME" id="END_TIME" value="${pd.END_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="结束时间">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="TECHNOLOGY_DIRECTOR" class="col-sm-2 control-label">技术负责人:</label>
								<div class="col-sm-2">
									<input type="text" name="TECHNOLOGY_DIRECTOR" id="TECHNOLOGY_DIRECTOR" value="${pd.TECHNOLOGY_DIRECTOR}" maxlength="255" placeholder="这里输入技术负责人" title="技术负责人" class="form-control"/>
								</div>
								<label for="FINANCIAL_PRINCIPAL" class="col-sm-1 control-label">财务负责人:</label>
								<div class="col-sm-2">
									<input type="text" name="FINANCIAL_PRINCIPAL" id="FINANCIAL_PRINCIPAL" value="${pd.FINANCIAL_PRINCIPAL}" maxlength="255" placeholder="这里输入财务负责人" title="财务负责人" class="form-control"/>
								</div>
								<label for="NUMBER_EMPLOYEE" class="col-sm-1 control-label">员工数量:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_EMPLOYEE" id="NUMBER_EMPLOYEE" value="${pd.NUMBER_EMPLOYEE}" maxlength="255" placeholder="这里输入员工数量" title="员工数量" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="NUMBER_PM" class="col-sm-2 control-label">项目经理数量:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_PM" id="NUMBER_PM" value="${pd.NUMBER_PM}" maxlength="255" placeholder="这里输入项目经理数量" title="项目经理数量" class="form-control"/>
								</div>
								<label for="NUMBER_SENIOR" class="col-sm-1 control-label">高级职称人员数量:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_SENIOR" id="NUMBER_SENIOR" value="${pd.NUMBER_SENIOR}" maxlength="255" placeholder="这里输入高级职称人员数量" title="高级职称人员数量" class="form-control"/>
								</div>
								<label for="NUMBER_INTERMEDIATE" class="col-sm-1 control-label">中级职称人员数量:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_INTERMEDIATE" id="NUMBER_INTERMEDIATE" value="${pd.NUMBER_INTERMEDIATE}" maxlength="255" placeholder="这里输入中级职称人员数量" title="中级职称人员数量" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="NUMBER_PRIMARY" class="col-sm-2 control-label">初级职称人员数量:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_PRIMARY" id="NUMBER_PRIMARY" value="${pd.NUMBER_PRIMARY}" maxlength="255" placeholder="这里输入初级职称人员数量" title="初级职称人员数量" class="form-control"/>
								</div>
								<label for="NUMBER_TOTAL" class="col-sm-1 control-label">技工总数:</label>
								<div class="col-sm-2">
									<input type="text" name="NUMBER_TOTAL" id="NUMBER_TOTAL" value="${pd.NUMBER_TOTAL}" maxlength="255" placeholder="这里输入技工总数" title="技工总数" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="CORPORATION" class="col-sm-2 control-label">企业介绍:</label>
								<div class="col-sm-8">
									<textarea cols="100" rows="10" name="COMPANY_DESC"></textarea>
								</div>

							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">企业联络人信息</h4>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="CONTACTS_NAME" class="col-sm-2 control-label">联络人姓名:</label>
								<div class="col-sm-2">
									<input type="text" name="CONTACTS_NAME" id="CONTACTS_NAME" value="${pd.CONTACTS_NAME}" maxlength="255" placeholder="这里输入联络人姓名" title="联络人姓名" class="form-control"/>
								</div>
								<label for="CONTACTS_TELEPHONE" class="col-sm-1 control-label">联络人电话:</label>
								<div class="col-sm-2">
									<input type="text" name="CONTACTS_TELEPHONE" id="CONTACTS_TELEPHONE" value="${pd.CONTACTS_TELEPHONE}" maxlength="255" placeholder="这里输入联络人电话" title="联络人电话" class="form-control"/>
								</div>
								<label for="CONTACTS_MAIL" class="col-sm-1 control-label">电子邮箱:</label>
								<div class="col-sm-2">
									<input type="text" name="CONTACTS_MAIL" id="CONTACTS_MAIL" value="${pd.CONTACTS_MAIL}" maxlength="255" placeholder="这里输入电子邮箱" title="电子邮箱" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="CONTACTS_FAX" class="col-sm-2 control-label">传真:</label>
								<div class="col-sm-2">
									<input type="text" name="CONTACTS_FAX" id="CONTACTS_FAX" value="${pd.CONTACTS_FAX}" maxlength="255" placeholder="这里输入传真" title="传真" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">对公账户信息</h4>
						</div>
						<div class="row">
							<div class="form-group" style="margin-top: 10px">
								<label for="START_BANK" class="col-sm-2 control-label">开户银行:</label>
								<div class="col-sm-2">
									<input type="text" name="START_BANK" id="START_BANK" value="${pd.START_BANK}" maxlength="255" placeholder="这里输入开户银行" title="开户银行" class="form-control"/>
								</div>
								<label for="BRANCH_BANK" class="col-sm-1 control-label">所属支行:</label>
								<div class="col-sm-2">
									<input type="text" name="BRANCH_BANK" id="BRANCH_BANK" value="${pd.BRANCH_BANK}" maxlength="255" placeholder="这里输入所属支行" title="所属支行" class="form-control"/>
								</div>
								<label for="ACCOUNT_BANK" class="col-sm-1 control-label">银行账号:</label>
								<div class="col-sm-2">
									<input type="text" name="ACCOUNT_BANK" id="ACCOUNT_BANK" value="${pd.ACCOUNT_BANK}" maxlength="255" placeholder="这里输入银行账号" title="银行账号" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="widget-header widget-header-blue widget-header-flat wi1dget-header-large">
							<h4 class="lighter">企业证件照</h4>
						</div>
						<div class="row">
							<div class="col-sm-2 imgbox" >
								<div class="row text-center">
									营业执照
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
								<div class="navbar-left col-sm-1" style="margin-left:1em;">
									上传
								</div>
								<div style="display:none">
									<input id="image_business" type="file" multiple=false>
								</div>
								<%--<div class="navbar-right" style="margin-right: 2em;cursor:pointer">下载</div>--%>
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									组织机构代码证
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									安全生产许可证
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									法人身份证(正面)
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									法人身份证(反面)
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-2 imgbox">
								<div class="row text-center">
									其他附件1
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									其他附件2
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
							<div class="col-sm-2 imgboxnext">
								<div class="row text-center">
									其他附件3
								</div>
								<img src="<%=basePath%>static/images/nopic.jpg" class="img-thumbnail">
							</div>
						</div>

						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover" style="display: none">
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">备注35:</td>--%>
								<%--<td><input type="text" name="IMAGE_BUSINESS" id="IMAGE_BUSINESS" value="${pd.IMAGE_BUSINESS}" maxlength="255" placeholder="这里输入备注35" title="备注35" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注36:</td>
								<td><input type="text" name="IMAGE_ORGANIZATION" id="IMAGE_ORGANIZATION" value="${pd.IMAGE_ORGANIZATION}" maxlength="255" placeholder="这里输入备注36" title="备注36" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注37:</td>
								<td><input type="text" name="IMAGE_SECURITY" id="IMAGE_SECURITY" value="${pd.IMAGE_SECURITY}" maxlength="255" placeholder="这里输入备注37" title="备注37" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注38:</td>
								<td><input type="text" name="IMAGE_CORPORATION_IDCARD_POSITIVE" id="IMAGE_CORPORATION_IDCARD_POSITIVE" value="${pd.IMAGE_CORPORATION_IDCARD_POSITIVE}" maxlength="255" placeholder="这里输入备注38" title="备注38" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注39:</td>
								<td><input type="text" name="IMAGE_CORPORATION_IDCARD_SIDE" id="IMAGE_CORPORATION_IDCARD_SIDE" value="${pd.IMAGE_CORPORATION_IDCARD_SIDE}" maxlength="255" placeholder="这里输入备注39" title="备注39" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注40:</td>
								<td><input type="text" name="IMAGE_OTHER1" id="IMAGE_OTHER1" value="${pd.IMAGE_OTHER1}" maxlength="255" placeholder="这里输入备注40" title="备注40" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注41:</td>
								<td><input type="text" name="IMAGE_OTHER2" id="IMAGE_OTHER2" value="${pd.IMAGE_OTHER2}" maxlength="255" placeholder="这里输入备注41" title="备注41" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注42:</td>
								<td><input type="text" name="IMAGE_OTHER3" id="IMAGE_OTHER3" value="${pd.IMAGE_OTHER3}" maxlength="255" placeholder="这里输入备注42" title="备注42" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注43:</td>
								<td><input type="text" name="IMAGE_OTHER4" id="IMAGE_OTHER4" value="${pd.IMAGE_OTHER4}" maxlength="255" placeholder="这里输入备注43" title="备注43" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注44:</td>
								<td><input type="text" name="IMAGE_OTHER5" id="IMAGE_OTHER5" value="${pd.IMAGE_OTHER5}" maxlength="255" placeholder="这里输入备注44" title="备注44" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
			if($("#COMPANY_ID").val()==""){
				$("#COMPANY_ID").tips({
					side:3,
		            msg:'请输入备注1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_ID").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入备注2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#CODE").val()==""){
				$("#CODE").tips({
					side:3,
		            msg:'请输入备注3',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CODE").focus();
			return false;
			}
			if($("#PROVINCE").val()==""){
				$("#PROVINCE").tips({
					side:3,
		            msg:'请输入备注4',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROVINCE").focus();
			return false;
			}
			if($("#CITY").val()==""){
				$("#CITY").tips({
					side:3,
		            msg:'请输入备注5',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CITY").focus();
			return false;
			}
			if($("#AREA").val()==""){
				$("#AREA").tips({
					side:3,
		            msg:'请输入备注6',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AREA").focus();
			return false;
			}
			if($("#ADDRESS").val()==""){
				$("#ADDRESS").tips({
					side:3,
		            msg:'请输入备注7',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESS").focus();
			return false;
			}
			if($("#POSTAL_CODE").val()==""){
				$("#POSTAL_CODE").tips({
					side:3,
		            msg:'请输入备注8',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#POSTAL_CODE").focus();
			return false;
			}
			if($("#NATURE").val()==""){
				$("#NATURE").tips({
					side:3,
		            msg:'请输入备注9',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NATURE").focus();
			return false;
			}
			if($("#BUSINESS_LICENSE").val()==""){
				$("#BUSINESS_LICENSE").tips({
					side:3,
		            msg:'请输入备注10',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUSINESS_LICENSE").focus();
			return false;
			}
			if($("#ORGANIZATION_NUMBER").val()==""){
				$("#ORGANIZATION_NUMBER").tips({
					side:3,
		            msg:'请输入备注11',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORGANIZATION_NUMBER").focus();
			return false;
			}
			if($("#ECONOMIC_TYPE").val()==""){
				$("#ECONOMIC_TYPE").tips({
					side:3,
		            msg:'请输入备注12',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ECONOMIC_TYPE").focus();
			return false;
			}
			if($("#REGISTERED_CAPITAL").val()==""){
				$("#REGISTERED_CAPITAL").tips({
					side:3,
		            msg:'请输入备注13',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REGISTERED_CAPITAL").focus();
			return false;
			}
			if($("#COMPANY_URL").val()==""){
				$("#COMPANY_URL").tips({
					side:3,
		            msg:'请输入备注14',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_URL").focus();
			return false;
			}
			if($("#ISSUING_AUTHORITY").val()==""){
				$("#ISSUING_AUTHORITY").tips({
					side:3,
		            msg:'请输入备注15',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISSUING_AUTHORITY").focus();
			return false;
			}
			if($("#START_TIME").val()==""){
				$("#START_TIME").tips({
					side:3,
		            msg:'请输入备注16',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_TIME").focus();
			return false;
			}
			if($("#END_TIME").val()==""){
				$("#END_TIME").tips({
					side:3,
		            msg:'请输入备注17',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_TIME").focus();
			return false;
			}
			if($("#CORPORATION").val()==""){
				$("#CORPORATION").tips({
					side:3,
		            msg:'请输入备注18',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CORPORATION").focus();
			return false;
			}
			if($("#TECHNOLOGY_DIRECTOR").val()==""){
				$("#TECHNOLOGY_DIRECTOR").tips({
					side:3,
		            msg:'请输入备注19',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TECHNOLOGY_DIRECTOR").focus();
			return false;
			}
			if($("#FINANCIAL_PRINCIPAL").val()==""){
				$("#FINANCIAL_PRINCIPAL").tips({
					side:3,
		            msg:'请输入备注20',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FINANCIAL_PRINCIPAL").focus();
			return false;
			}
			if($("#NUMBER_EMPLOYEE").val()==""){
				$("#NUMBER_EMPLOYEE").tips({
					side:3,
		            msg:'请输入备注21',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_EMPLOYEE").focus();
			return false;
			}
			if($("#NUMBER_PM").val()==""){
				$("#NUMBER_PM").tips({
					side:3,
		            msg:'请输入备注22',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_PM").focus();
			return false;
			}
			if($("#NUMBER_SENIOR").val()==""){
				$("#NUMBER_SENIOR").tips({
					side:3,
		            msg:'请输入备注23',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_SENIOR").focus();
			return false;
			}
			if($("#NUMBER_INTERMEDIATE").val()==""){
				$("#NUMBER_INTERMEDIATE").tips({
					side:3,
		            msg:'请输入备注24',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_INTERMEDIATE").focus();
			return false;
			}
			if($("#NUMBER_PRIMARY").val()==""){
				$("#NUMBER_PRIMARY").tips({
					side:3,
		            msg:'请输入备注25',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_PRIMARY").focus();
			return false;
			}
			if($("#NUMBER_TOTAL").val()==""){
				$("#NUMBER_TOTAL").tips({
					side:3,
		            msg:'请输入备注26',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_TOTAL").focus();
			return false;
			}
			if($("#COMPANY_DESC").val()==""){
				$("#COMPANY_DESC").tips({
					side:3,
		            msg:'请输入备注27',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_DESC").focus();
			return false;
			}
			if($("#CONTACTS_NAME").val()==""){
				$("#CONTACTS_NAME").tips({
					side:3,
		            msg:'请输入备注28',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACTS_NAME").focus();
			return false;
			}
			if($("#CONTACTS_TELEPHONE").val()==""){
				$("#CONTACTS_TELEPHONE").tips({
					side:3,
		            msg:'请输入备注29',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACTS_TELEPHONE").focus();
			return false;
			}
			if($("#CONTACTS_MAIL").val()==""){
				$("#CONTACTS_MAIL").tips({
					side:3,
		            msg:'请输入备注30',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACTS_MAIL").focus();
			return false;
			}
			if($("#CONTACTS_FAX").val()==""){
				$("#CONTACTS_FAX").tips({
					side:3,
		            msg:'请输入备注31',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACTS_FAX").focus();
			return false;
			}
			if($("#START_BANK").val()==""){
				$("#START_BANK").tips({
					side:3,
		            msg:'请输入备注32',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_BANK").focus();
			return false;
			}
			if($("#BRANCH_BANK").val()==""){
				$("#BRANCH_BANK").tips({
					side:3,
		            msg:'请输入备注33',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BRANCH_BANK").focus();
			return false;
			}
			if($("#ACCOUNT_BANK").val()==""){
				$("#ACCOUNT_BANK").tips({
					side:3,
		            msg:'请输入备注34',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ACCOUNT_BANK").focus();
			return false;
			}
			if($("#IMAGE_BUSINESS").val()==""){
				$("#IMAGE_BUSINESS").tips({
					side:3,
		            msg:'请输入备注35',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_BUSINESS").focus();
			return false;
			}
			if($("#IMAGE_ORGANIZATION").val()==""){
				$("#IMAGE_ORGANIZATION").tips({
					side:3,
		            msg:'请输入备注36',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_ORGANIZATION").focus();
			return false;
			}
			if($("#IMAGE_SECURITY").val()==""){
				$("#IMAGE_SECURITY").tips({
					side:3,
		            msg:'请输入备注37',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_SECURITY").focus();
			return false;
			}
			if($("#IMAGE_CORPORATION_IDCARD_POSITIVE").val()==""){
				$("#IMAGE_CORPORATION_IDCARD_POSITIVE").tips({
					side:3,
		            msg:'请输入备注38',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_CORPORATION_IDCARD_POSITIVE").focus();
			return false;
			}
			if($("#IMAGE_CORPORATION_IDCARD_SIDE").val()==""){
				$("#IMAGE_CORPORATION_IDCARD_SIDE").tips({
					side:3,
		            msg:'请输入备注39',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_CORPORATION_IDCARD_SIDE").focus();
			return false;
			}
			if($("#IMAGE_OTHER1").val()==""){
				$("#IMAGE_OTHER1").tips({
					side:3,
		            msg:'请输入备注40',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_OTHER1").focus();
			return false;
			}
			if($("#IMAGE_OTHER2").val()==""){
				$("#IMAGE_OTHER2").tips({
					side:3,
		            msg:'请输入备注41',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_OTHER2").focus();
			return false;
			}
			if($("#IMAGE_OTHER3").val()==""){
				$("#IMAGE_OTHER3").tips({
					side:3,
		            msg:'请输入备注42',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_OTHER3").focus();
			return false;
			}
			if($("#IMAGE_OTHER4").val()==""){
				$("#IMAGE_OTHER4").tips({
					side:3,
		            msg:'请输入备注43',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_OTHER4").focus();
			return false;
			}
			if($("#IMAGE_OTHER5").val()==""){
				$("#IMAGE_OTHER5").tips({
					side:3,
		            msg:'请输入备注44',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMAGE_OTHER5").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
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
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
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
				$('#NATURE').chosen();
				$('#ECONOMIC_TYPE').chosen();

				$("#image_business").fileinput({
					showUpload: false,
					showCaption: false,
					allowedFileExtensions : ['jpg', 'png','gif'],
					browseClass: "btn btn-primary btn-lg",
					fileType: "any",
					previewFileIcon: "<i class='glyphicon glyphicon-king'></i>"
				});

//				$(window)
//						.off('resize.chosen')
//						.on('resize.chosen', function() {
//							$('.chosen-select').each(function() {
//								var $this = $(this);
//								$this.next().css({'width': $this.parent().width()});
//							});
//						}).trigger('resize.chosen');
//				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
//					if(event_name != 'sidebar_collapsed') return;
//					$('.chosen-select').each(function() {
//						var $this = $(this);
//						$this.next().css({'width': $this.parent().width()});
//					});
//				});
//				$('#chosen-multiple-style .btn').on('click', function(e){
//					var target = $(this).find('input[type=radio]');
//					var which = parseInt(target.val());
//					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
//					else $('#form-field-select-4').removeClass('tag-input-style');
//				});
			}
		});
		</script>
</body>
</html>