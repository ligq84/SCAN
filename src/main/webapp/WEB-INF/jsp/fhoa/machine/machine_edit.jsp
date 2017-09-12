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
						<input type="hidden" name="MHID"  value="${pd.MHID}"/>
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
									<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>保养方式：</label>
									<div class="col-sm-10">
										<c:forEach items="${machineCycleList}" var="var" varStatus="vs">
											<label style="float:left;padding-left: 8px;padding-top:7px;" >
												<input id="cycle${var.OCBID}" name="cycleName" type="checkbox" class="ace" value="${var.OCBID}"
													   onclick="cycleChange('cycle${var.OCBID}','${var.OCBID}','${var.NAME}')"
												<c:forEach items="${cycleList}" var="cl" varStatus="ts">
													   <c:if test="${cl.CYCLEID == var.OCBID}">checked</c:if>
												</c:forEach>
												><span class="lbl" >${var.NAME}</span>
											</label>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px" id="cycleDes">
									<c:forEach items="${cycleList}" var="cl" varStatus="ts">
										<div id="desc${cl.CYCLEID}">
											<label class="col-sm-1 control-label no-padding-right">${cl.NAME}:</label>
											<div class="col-sm-2">
												<textarea rows="5" cols="30" name="cdesc${cl.CYCLEID}">${cl.BZ}</textarea>
													</div>
											</div>
									</c:forEach>
								</div>
							</div>
							<div class="col-sm-12 widget-header widget-header-blue widget-header-flat wi1dget-header-large" style="padding: 0px;margin: 0px;">
								<h4 class="lighter">机器维修信息</h4>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px" id="mplist">
									<c:if test="${projecList== null || fn:length(projecList) == 0}">
										<div id="mpvalue1" style="margin-top: 5px;">
											<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>维修项目1：</label>
											<div class="col-sm-2">
												<select class="chosen-select form-control" name="mpv" data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >
													<option value=""></option>
													<c:forEach items="${mpList}" var="mp">
														<option value="${mp.OCBID }">${mp.NAME}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-sm-1">
												<a class="btn btn-mini btn-primary" onclick="addMP()" style="margin-top: 5px;" >添加</a>
												<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;" >删除</a>
											</div>
										</div>
									</c:if>
									<c:if test="${projecList!= null || fn:length(projecList) > 0}">
										<c:forEach items="${projecList}" var="project"  varStatus="pj">
											<c:if test="${(pj.index+1)%3 != 0}">
												<div id="mpvalue${pj.index+1}" style="margin-top: 5px;">
													<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>维修项目${pj.index+1}：</label>
													<div class="col-sm-2">
														<select class="chosen-select form-control" name="mpv" data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >
															<option value=""></option>
															<c:forEach items="${mpList}" var="mp">
																<option value="${mp.OCBID }" <c:if test="${mp.OCBID == project.PROJECTID }">selected</c:if> >${mp.NAME}</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-1">
														<a class="btn btn-mini btn-primary" onclick="addMP()" style="margin-top: 5px;" >添加</a>
														<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;" onclick="deleteSelect('mpvalue${pj.index+1}')">删除</a>
													</div>
												</div>
											</c:if>
											<c:if test="${(pj.index+1)%3 == 0}">
												<div id="mpvalue${pj.index+1}" style="margin-top: 5px;">
													<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>维修项目${pj.index+1}：</label>
													<div class="col-sm-2">
														<select class="chosen-select form-control" name="mpv"  data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >
															<option value=""></option>
															<c:forEach items="${mpList}" var="mp">
																<option value="${mp.OCBID }"  <c:if test="${mp.OCBID == project.PROJECTID }">selected</c:if> >${mp.NAME}</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-1">
														<a class="btn btn-mini btn-primary" onclick="addMP()" style="margin-top: 5px;" >添加</a>
														<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;" onclick="deleteSelect('mpvalue${pj.index+1}')">删除</a>
													</div>
												</div>
												<div class="row"></div>
											</c:if>
										</c:forEach>
									</c:if>

								</div>

							</div>
							<div class="col-sm-12 widget-header widget-header-blue widget-header-flat wi1dget-header-large" style="padding: 0px;margin: 0px;">
								<h4 class="lighter">机器更改规格 </h4>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top: 10px">
									<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>更改规格:</label>
									<div class="col-sm-2">
										<label style="float:left;padding-left: 20px;padding-top:7px;">
											<input name="CHANGE_RULE" type="radio" value="0" class="ace" <c:if test="${pd.CHANGE_RULE == 0}">checked</c:if> ><span class="lbl">支持</span>
										</label>
										<label style="float:left;padding-left:35px;padding-top:7px;">
											<input name="CHANGE_RULE" type="radio" value="1" class="ace"  <c:if test="${pd.CHANGE_RULE == 1}">checked</c:if>  ><span class="lbl">不支持</span>
										</label>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" >
									<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>支持规格:</label>
									<div class="col-sm-2">
										<c:forEach items="${ruleList}" var="var" varStatus="vs">
											<label style="float:left;padding-left: 8px;padding-top:7px;">
												<input name="ruleId" type="checkbox" class="ace" value="${var.OCBID}"><span class="lbl"
													<c:forEach items="${machineruleList}" var="mr" varStatus="ts">
														<c:if test="${mr.RULEID == var.OCBID}">checked</c:if>
													</c:forEach>
											>${var.NAME}</span>
											</label>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" id="rulePost">
									<c:if test="${partsList== null || fn:length(partsList) == 0}">
										<div id="rulePost1" style="margin-top: 5px;">
											<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>更改规格1:</label>
											<div class="col-sm-2">
												<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改规格" style="vertical-align:top;"  style="width:70%;" >
													<option value=""></option>
													<c:forEach items="${rulePosttionList}" var="rp">
														<option value="${rp.OCBID }">${rp.NAME}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-sm-1">
												<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>
												<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;"  >删除</a>
											</div>
										</div>
									</c:if>
									<c:if test="${partsList!= null || fn:length(partsList) > 0}">
										<c:forEach items="${partsList}" var="parts"  varStatus="pt">
											<c:if test="${(pt.index+1)%3 != 0}">
												<div id="rulePost1" style="margin-top: 5px;">
													<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>更改规格1:</label>
													<div class="col-sm-2">
														<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改规格" style="vertical-align:top;"  style="width:70%;" >
															<option value=""></option>
															<c:forEach items="${rulePosttionList}" var="rp">
																<option value="${rp.OCBID }" <c:if test="${rp.OCBID == parts.PARTSID }">selected</c:if> >${rp.NAME}</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-1">
														<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>
														<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;"  >删除</a>
													</div>
												</div>
											</c:if>
											<c:if test="${(pt.index+1)%3 == 0}">
												<div id="rulePost1" style="margin-top: 5px;">
													<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>更改规格1:</label>
													<div class="col-sm-2">
														<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改规格" style="vertical-align:top;"  style="width:70%;" >
															<option value=""></option>
															<c:forEach items="${rulePosttionList}" var="rp">
																<option value="${rp.OCBID }" <c:if test="${rp.OCBID == parts.PARTSID }">selected</c:if> >${rp.NAME}</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-1">
														<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>
														<a class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 5px;"  >删除</a>
													</div>
												</div>
												<div class="row"></div>
											</c:if>
										</c:forEach>
									</c:if>


								</div>
							</div>
							<div class="col-sm-12" >
								<div class="form-group" style="margin-top:50px;text-align: center">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="back();">返回</a>
								</div>
							</div>
						</div>
						<div id="zhongxin2" class="center" style="display:none;" ><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
			var form = $('<form action="<%=basePath%>machine/list.do" method="get"></form>');
			$(document.body).append(form);
			form.submit()
		}

		function addRulePost(){
			var rulePost = $("#rulePost");
			var rpdiv = $("#rulePost>div");
			var lent = rpdiv.length;
			var netx=lent+1;
			console.log(netx);
			if((lent+1)%3 == 0){
				rulePost.append(getRPSelect(netx)+'<div class="row"></div>');
			}else{
				rulePost.append(getRPSelect(netx));
			}
			$('.chosen-select').chosen({allow_single_deselect:true,search_contains:true});
		}
		function getRPSelect(len){
			return '<div id="rpvvalue'+len+'" style="margin-top: 5px;">'+
					'<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>更改规格'+len+'：</label>'+
					'<div class="col-sm-2">'+
					'		<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改规格" style="vertical-align:top;"  style="width:98%;" >'+
					'				<option value=""></option>'+
					<c:forEach items="${rulePosttionList}" var="rp">
									'<option value="${rp.OCBID }">${rp.NAME}</option>'+
					</c:forEach>
					'		</select>'+
					'</div>'+
					'<div class="col-sm-1">'+
					'		<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>'+
					'		<a class="btn btn-mini btn-danger" style="margin-top: 2px" onclick="deleteRPSelect(\'rpvvalue'+len+'\')">删除</a>'+
					'</div>'+
					'<div>';
		}
		function deleteRPSelect(id){
			$("#"+id).remove();
		}
		function cycleChange(id,v,n){
			if($("#"+id).is(":checked")){
				$("#cycleDes").append('<div id="desc'+v+'">'+
										'	<label class="col-sm-1 control-label no-padding-right">'+n+':</label>'+
										'<div class="col-sm-2">'+
										'	<textarea rows="5" cols="30" name="cdesc'+v+'"></textarea>'+
										'	</div>'+
										'</div>');
			}else{
				$("#desc"+v).remove();
			}
		}
		function addMP(){
			var mplist = $("#mplist");
			var mpdiv = $("#mplist>div");
			var len = mpdiv.length;
			if((len+1)%3 == 0){
				mplist.append(getMPSelect(len)+'<div class="row"></div>');
			}else{
				mplist.append(getMPSelect(len));
			}
			$('.chosen-select').chosen({allow_single_deselect:true,search_contains:true});
		}
		function getMPSelect(len){
			return '<div id="mpvalue'+(len+1)+'" style="margin-top: 5px;">'+
			'<label class="col-sm-1 control-label no-padding-right"><span style="color: red">*</span>维修项目'+(len+1)+'：</label>'+
			'<div class="col-sm-2">'+
//			'		<select class="chosen-select form-control" name="mpv'+(len+1)+'"  data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >'+
			'		<select class="chosen-select form-control" name="mpv"  data-placeholder="请选择维修项目" style="vertical-align:top;"  style="width:98%;" >'+
			'				<option value=""></option>'+
			<c:forEach items="${mpList}" var="mp">
			'<option value="${mp.OCBID }">${mp.NAME}</option>'+
			</c:forEach>
			'		</select>'+
			'</div>'+
			'<div class="col-sm-1">'+
			'<a class="btn btn-mini btn-primary" onclick="addMP()" style="margin-top: 5px;" >添加</a>'+
			'		<a class="btn btn-mini btn-danger" style="margin-top: 2px" onclick="deleteSelect(\'mpvalue'+(len+1)+'\')">删除</a>'+
			'</div>'+
			'<div>';
		}
		function deleteSelect(id){
			$("#"+id).remove();
		}
		//保存
		function save(){

			//机器维修信息

			//更改规格信息

			if($("#NAME").val()==""){
				$("#NAME").tips({side:3, msg:'请输入机器名称', bg:'#AE81FF', time:2});
				$("#NAME").focus();
				return false;
			}
			if($("#TYPE").val()==""){$("#TYPE").next('.chosen-container').tips({side:3, msg:'请输入类型', bg:'#AE81FF', time:2});
				$("#TYPE").focus();
				return false;
			}
			if($("#MODEL").val()==""){
				$("#MODEL").tips({side:3, msg:'请输入型号', bg:'#AE81FF', time:2});
				$("#MODEL").focus();
				return false;
			}
			if($("#POWER").val()==""){
				$("#POWER").tips({side:3, msg:'请输入功率', bg:'#AE81FF', time:2});
				$("#POWER").focus();
				return false;
			}
			if($("#CHARGE").val()==""){
				$("#CHARGE").next('.chosen-container').tips({side:3, msg:'请输入机器负责人', bg:'#AE81FF', time:2});
				$("#CHARGE").focus();
			return false;
			}
			if($("#DAY_REPAIRMAN").val()==""){
				$("#DAY_REPAIRMAN").next('.chosen-container').tips({side:3,msg:'请输入白班维修员',bg:'#AE81FF',time:2 });
				$("#DAY_REPAIRMAN").focus();
			return false;
			}
			if($("#NIGHT_REPAIRMAN").val()==""){
				$("#NIGHT_REPAIRMAN").next('.chosen-container').tips({side:3,msg:'请输入晚班维修员',bg:'#AE81FF',time:2});
				$("#NIGHT_REPAIRMAN").focus();
			return false;
			}

			//机器保养信息
			var cycleName="";
			$("input[name=cycleName]").each(function(){
				if($(this).is(':checked')){
					cycleName+=$(this).val()+',';
				}
			});
			if(cycleName == ""){
				$("input[name=cycleName]").eq(0).tips({side:3, msg:'请选择机器保养信息', bg:'#AE81FF', time:2});
				return false
			}
			var bl=false;
			$("select[name=mpv]").each(function(){
				if(!$(this).val()){
					$(this).next('.chosen-container').tips({side:3, msg:'请输入维修项目', bg:'#AE81FF', time:2});
					bl=true;
					return false;
				}
			});
			if(bl){
				return false;
			}

			var CHANGE_RULE="";
			$("input[name=CHANGE_RULE]").each(function(){
				if($(this).is(':checked')){
					CHANGE_RULE+=$(this).val()+',';
				}
			});
			if(CHANGE_RULE == ""){
				$("input[name=CHANGE_RULE]").eq(0).tips({side:3, msg:'请选择是否支持更改规格', bg:'#AE81FF', time:2});
				return false
			}

			var ruleId="";
			$("input[name=ruleId]").each(function(){
				if($(this).is(':checked')){
					ruleId+=$(this).val()+',';
				}
			});
			if(ruleId == ""){
				$("input[name=ruleId]").eq(0).tips({side:3, msg:'请选择支持规格', bg:'#AE81FF', time:2});
				return false
			}
			var bool=false;
			$("select[name=rpv]").each(function(){
				if(!$(this).val()){
					$(this).next('.chosen-container').tips({side:3, msg:'请输入更改规格', bg:'#AE81FF', time:2});
					bool=true;
					return false;
				}
			});
			if(bool){
				return false;
			}

			$("#zhongxin").hide();
			$("#zhongxin2").show();
			var from = $("#Form").serializeObject();


			$.ajax({
				type: "POST",
				url: '<%=basePath%>machine/${msg}.do',
				data: from,
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.result == "success"){
						alert(data.mesg);
						var form = $('<form action="<%=basePath%>machine/list.do" method="get"></form>');
						$(document.body).append(form);
						form.submit()
					}else if(data.result == "fail"){
						alert(data.mesg);
					}else {
						alert("添加异常");
						$("#zhongxin").show();
						$("#zhongxin2").hide();
					}
				}
			});
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