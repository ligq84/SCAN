﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="static/css/pagePublic.css" />
	<link rel="stylesheet" href="static/ace/css/jquery-ui.css" />
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
	<script type="text/javascript" src="static/ace/js/jquery-ui.js"></script>
	<style type="text/css">
		.inputStyle{
			border: 1px solid #0e77d9 !important;
		}

		textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"],
		input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"],
		input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
			border-radius: 4px !important;
		}
		.chosen-container {
			border: 1px solid #0e77d9 ;
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
				<div class="row" style="margin: 0px;">
					<div class="col-xs-12" >
						<form name="Form" id="Form" method="post" class="form-horizontal">
							<div id="zhongxin" style="padding-top: 10px;">
								<div class="row">
									<div class="form-group" style="margin-top: 10px">
										<label for="mesg_title" class="col-sm-2 control-label"><span style="color: red">*</span>通知标题:</label>
										<div class="col-sm-4 control-label">
											<input type="text" name="mesg_title" id="mesg_title" value="" maxlength="50" placeholder="请输入通知标题"  class="form-control inputStyle" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group" >
										<label for="machineName" class="col-sm-2 control-label"><span style="color: red">*</span>机器名称:</label>
										<div class="col-sm-4 control-label">
											<input type="text" name="machineName" id="machineName" value="" maxlength="50"  placeholder="请输入机器名称"
												   class="form-control inputStyle" autocomplete="off"/>
										</div>
									</div>
								</div>
								<div class="row" >
									<label for="chargeN" class="col-sm-2 control-label">机器负责人:</label>
									<div class="col-sm-2">
										<input type="text" name="chargeN" id="chargeN"  maxlength="50"  class="form-control inputStyle" style="border: 0px" readonly/>
									</div>
										<label for="Day_Repairman" class="col-sm-1 control-label" style="width: 130px;">白班维修员:</label>
									<div class="col-sm-2">
										<input type="text" name="Day_Repairman" id="Day_Repairman"  maxlength="50"  class="form-control inputStyle" style="border: 0px" readonly/>
									</div>
									<label for="Night_R" class="col-sm-1 control-label" style="width: 130px;">晚班维修员:</label>
									<div class="col-sm-2">
										<input type="text" name="Night_R" id="Night_R"  maxlength="50" class="form-control inputStyle" style="border: 0px" readonly/>
									</div>
									<input type="hidden" id="USERNAME" name="USERNAME" />
									<input type="hidden" id="CONTENT" name="CONTENT" />
									<input type="hidden" id="to_staff" name="to_staff" />
									<input type="hidden" id="mhid" name="mhid" />
								</div>
								<div class="row" style="margin-top:25px;">
									<label class="col-sm-2 control-label no-padding-right" ><span style="color: red">*</span>通知类型：</label>
									<div class="col-sm-9">
										<label style="float:left;padding-left: 8px;padding-top:7px;">
											<input name="mesgType" type="radio" class="ace inputStyle" value="2">
											<span class="lbl">维修通知</span>
										</label>
										<label style="float:left;padding-left: 5px;padding-top:7px;">
											<input name="mesgType" type="radio" class="ace inputStyle" value="4">
											<span class="lbl">改规格通知</span>
										</label>
									</div>
								</div>
								<div class="row" style="margin-top: 25px;">
									<label class="col-sm-2 control-label no-padding-right" >目标规格：</label>
									<div class="col-sm-2">
										<select class="chosen-select form-control inputStyle" name="rule"  id ="rule" data-placeholder="请选择目标规格" style="vertical-align:top;"  style="width:70%;" >
											<option value=""></option>
											<c:forEach items="${ruleList}" var="rp">
												<option value="${rp.NAME }"  >${rp.NAME}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="row" style="margin-top: 25px;">
									<div class="form-group" id="rulePost">
											<div id="rulePost1" style="margin-top: 5px;">
												<label class="col-sm-2 control-label no-padding-right" ><span style="color: red">*</span>更改部位1:</label>
												<div class="col-sm-2">
													<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改部位" style="vertical-align:top;"  style="width:70%;" >
														<option value=""></option>
														<c:forEach items="${rulePosttionList}" var="rp">
															<option value="${rp.NAME }" >${rp.NAME}</option>
														</c:forEach>
													</select>
												</div>
												<div class="col-sm-1" style="width: 120px;">
													<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>
													<a class="btn btn-mini btn-primary" style="margin-top: 5px;margin-left: 5px;"  >删除</a>
												</div>
											</div>
									</div>
								</div>

								<div class="row" style="margin-left:20px;text-align: center;">
									<div class="form-group" style="margin-top: 50px">
										<a class="btn btn-mini btn-primary" onclick="sendSms();">发送通知</a>
										<a class="btn btn-mini btn-primary" onclick="backSms();">返回</a>
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

            $("#machineName").autocomplete({
                source: function(request, response){
                    $.ajax({
                        url: '<%=basePath%>scan/findByBarcodeList.do?name='+$("#machineName").val(),
                        type: 'post',
                        data: {NAME: request.term},
                        dataType:'json',
                        success: function (result) {
//							console.log(result.data)
                            response(result.data)
                        }
                    });
                },
                select: function(event, ui){
                    // 这里的this指向当前输入框的DOM元素
                    // event参数是事件对象
                    // ui对象只有一个item属性，对应数据源中被选中的对象
                    $(this).value = ui.item.label;
                    $("#machineName").val( ui.item.value );
//                    $("#STAFF_ID").val( ui.item.STAFF_ID );
//                    $("#TEL").val( ui.item.TEL );
//                    $("#machine_name").val(machine.name);
                    $("#chargeN").val(ui.item.chargeN);
                    $("#Day_Repairman").val(ui.item.Day_Repairman);
                    $("#Night_R").val(ui.item.Night_R);
                    $("#to_staff").val('机器负责人：'+ui.item.chargeN+'、白班维修员：'+ui.item.Day_R+'、晚班维修员'+ui.item.Night_R)
                    $("#USERNAME").val(ui.item.chargeName+';'+ui.item.Day_Repairman+';'+ui.item.Night_Repairman)
                    $("#mhid").val(ui.item.mhid);
                    // 必须阻止事件的默认行为，否则autocomplete默认会把ui.item.value设为输入框的value值
                    event.preventDefault();
                }
            });
			<%--$("#machineName")[0].oninput =function(){--%>
				<%--$.ajax({--%>
					<%--type: "POST",--%>
					<%--url: '<%=basePath%>scan/findByBarcode.do?name='+$("#machineName").val(),--%>
					<%--data: $("#Form").serializeObject(),--%>
					<%--dataType:'json',--%>
					<%--cache: false,--%>
					<%--success: function(data){--%>
						<%--if(data.result == "success"){--%>
							<%--var machine = data.data;--%>
							<%--if(null!=machine && ""!=machine){--%>
								<%--$("#machine_name").val(machine.name);--%>
								<%--$("#chargeN").val(machine.chargeN);--%>
								<%--$("#Day_Repairman").val(machine.Day_Repairman);--%>
								<%--$("#Night_R").val(machine.Night_R);--%>
								<%--$("#to_staff").val('机器负责人：'+machine.chargeN+'、白班维修员：'+machine.Day_R+'、晚班维修员'+machine.Night_R)--%>
								<%--$("#USERNAME").val(machine.chargeName+';'+machine.Day_Repairman+';'+machine.Night_Repairman)--%>
								<%--$("#mhid").val(machine.mhid);--%>
							<%--}--%>
						<%--}--%>
					<%--}--%>
				<%--});--%>
			<%--};--%>
		});

		function addRulePost(){
			var rulePost = $("#rulePost");
			var rpdiv = $("#rulePost>div");
			var lent = rpdiv.length;
			var netx=lent+1;

			if((lent+1)%2 == 0){
				rulePost.append(getRPSelect(netx)+'<div class="row"></div>');
			}else{
				rulePost.append(getRPSelect(netx));
			}
			$('.chosen-select').chosen();
		}
		function getRPSelect(len){
		    var retStr='<div id="rpvvalue'+len+'" style="margin-top: 5px;">';

					if((len)%2 == 0){
                        retStr +='<label class="col-sm-1 control-label no-padding-right"  style="width: 125px;"';
					}else{
                        retStr +='<label class="col-sm-2 control-label no-padding-right"  ';
					}
            		retStr +=' ><span style="color: red">*</span>更改部位'+len+'：</label>'+
					'<div class="col-sm-2">'+
					'		<select class="chosen-select form-control" name="rpv"  data-placeholder="请选择更改部位" style="vertical-align:top;"  style="width:98%;" >'+
					'				<option value=""></option>'+
					<c:forEach items="${rulePosttionList}" var="rp">
					'<option value="${rp.NAME }">${rp.NAME}</option>'+
					</c:forEach>
					'		</select>'+
					'</div>'+
					'<div class="col-sm-1"  style="width: 120px;">'+
					'		<a class="btn btn-mini btn-primary"  style="margin-top: 5px;" onclick="addRulePost()">添加</a>'+
					'		<a class="btn btn-mini btn-primary" style="margin-top: 2px" onclick="deleteRPSelect(\'rpvvalue'+len+'\')">删除</a>'+
					'</div>'+
					'<div>';
            return retStr;
		}
		function deleteRPSelect(id){
			$("#"+id).remove();
		}
		function sendSms(){

			if($("#mesg_title").val()==""){
				$("#mesg_title").tips({side:3,msg:'请输通知标题',bg:'#AE81FF',time:2});
				$("#mesg_title").focus();
				return false;
			}
			if($("#machineName").val()==""){
				$("#machineName").tips({side:3,msg:'请输入机器名称',bg:'#AE81FF',time:2});
				$("#machineName").focus();
				return false;
			}
			if($("input[name=mesgType]:checked ").val()=="3"){
				if($("#rule").val()==""){
					$("#rule").next('.chosen-container').tips({side:3,msg:'请选择目标规格',bg:'#AE81FF',time:2});
					$("#rule").focus();
					return false;
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
			}
			var parts = [];
			$("select[name=rpv]").each(function(){
				if($(this).val()){
					parts.push($(this).val())

				}
			});

			var USERNAME=$("#USERNAME").val();
			var CONTENT="请维修机器："+$("#machineName").val();;
			$.ajax({
				type: "POST",
				url:'<%=basePath%>fhsms/sendSMS.do?tm='+new Date().getTime(),
				data: {USERNAME:USERNAME,CONTENT:CONTENT,SMS_TYPE:$("input[name=mesgType]:checked ").val(),"to_staff":$("#to_staff").val(),
					"TITLE":$("#mesg_title").val(),"rule":$("#rule").val(),"parts":parts.join(","),machine_name:$("#machineName").val(),mhid:$("#mhid").val()},
				dataType:'json',
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
		$('.chosen-select').chosen({allow_single_deselect:true,search_contains:true});
        function backSms() {
            var form = $('<form action="<%=basePath%>fhsms/adminList.do?STATUS=2" method="get"></form>');
            $(document.body).append(form);
            form.submit()
        }
	</script>

</body>
</html>