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
		<!-- jsp文件头和头部 -->
		<%@ include file="../../system/index/top.jsp"%>
	<link rel="stylesheet" href="static/css/pagePublic.css" />
	<link rel="stylesheet" href="static/ace/css/jquery-ui.css" />
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
	<script type="text/javascript" src="static/ace/js/jquery-ui.js"></script>

	<style type="text/css">

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
					
					<form action="department/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
						<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DEPARTMENT_ID:pd.PARENT_ID}"/>
						<div id="zhongxin">
						<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top:15px;">
							<%--<tr>--%>
								<%--<td style="width:90px;text-align: right;padding-top: 13px;">上级:</td>--%>
								<%--<td>--%>
									<%--<div class="col-xs-4 label label-lg label-light arrowed-in arrowed-right">--%>
										<%--<b>${null == pds.NAME ?'(无) 此部门为顶级':pds.NAME}</b>--%>
									<%--</div>--%>
								<%--</td>--%>
							<%--</tr>--%>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">部门名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入部门名称" class="pageInput"
								 style="border-radius: 4px"/></td>
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">负责人姓名:</td>
								<td>
									<input type="hidden" name="STAFF_ID" id="STAFF_ID">
									<input type="text" name="HEADMAN" id="HEADMAN" value="${pd.HEADMAN}" maxlength="32" placeholder="这里输入负责人"  class="pageInput"
										  autocomplete="off"  style="border-radius: 4px"/>
								</td>
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">负责人电话:</td>
								<td>
									<input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="32" placeholder="这里输入电话" class="pageInput" readonly  style="border-radius: 4px"/>
								</td>
							</tr>v
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">部门说明:</td>
								<td>
									<textarea rows="3" cols="46" name="BZ" id="BZ" placeholder="部门说明" title="备注"  style="width:69%;" class="pageTextarea"  style="border-radius: 4px">${pd.BZ}</textarea>
								</td>
							</tr>
							<tr>
								<td class="center" colspan="10">
									<a class="btn btn-mini btn-qg" onclick="save();">保存</a>
									<a class="btn btn-mini btn-qg" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						
					</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
	<!--自动补全-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/bootstrap3-typeahead.min.js"></script>
	<script type="text/javascript">
		$(top.hangge());
        $(document).ready(function($) {
//            $('.typeahead').typeahead({
//                source: function(query, process) {
//                    return ["Deluxe Bicycle", "Super Deluxe Trampoline", "Super Duper Scooter"];
//                }
//            });
            $("#HEADMAN").autocomplete({
                source: function(request, response){
                   $.ajax({
						url: '<%=basePath%>staff/listAll.do',
						type: 'post',
						data: {NAME: request.term},
						dataType:'json',
						success: function (result) {
                            response(result.data)
						}
                    });
				},
                select: function(event, ui){
                    // 这里的this指向当前输入框的DOM元素
                    // event参数是事件对象
                    // ui对象只有一个item属性，对应数据源中被选中的对象
                    $(this).value = ui.item.label;
                    $("#HEADMAN").val( ui.item.value );
                    $("#STAFF_ID").val( ui.item.STAFF_ID );
                    $("#TEL").val( ui.item.TEL );
                    // 必须阻止事件的默认行为，否则autocomplete默认会把ui.item.value设为输入框的value值
                    event.preventDefault();
                }
            });
            <%--({--%>
                <%--source: function (query, process) {--%>
                    <%--return $.ajax({--%>
                        <%--url: '<%=basePath%>staff/listAll.do',--%>
                        <%--type: 'post',--%>
                        <%--data: {NAME: query},--%>
                        <%--dataType:'json',--%>
                        <%--success: function (result) {--%>
                            <%--return process(result);--%>
                        <%--},--%>
                    <%--});--%>
                <%--}--%>
            <%--});--%>
        })

        //保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输部门名称',
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
//		}
//			if($("#BIANMA").val()==""){
//				$("#BIANMA").tips({
//					side:3,
//		            msg:'请输入编码',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#BIANMA").focus();
//			return false;
//		}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
		}
		
		//判断编码是否存在
		function hasBianma(){
			var BIANMA = $.trim($("#BIANMA").val());
			if("" == BIANMA)return;
			$.ajax({
				type: "POST",
				url: '<%=basePath%>department/hasBianma.do',
		    	data: {BIANMA:BIANMA,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
					 }else{
						$("#BIANMA").tips({
							side:1,
				            msg:'编码'+BIANMA+'已存在,重新输入',
				            bg:'#AE81FF',
				            time:5
				        });
						$('#BIANMA').val('');
					 }
				}
			});
		}
		</script>
</body>
</html>