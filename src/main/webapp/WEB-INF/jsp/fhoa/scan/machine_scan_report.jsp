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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/css/pagePublic.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container" style="overflow-x: auto">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12" >
							
						<!-- 检索  -->
						<form action="scan/michineScanReport.do" method="post" name="Form" id="Form">
							<input type="hidden" name="scan_type" value="${pd.scan_type}">
						<table style="margin-top:5px;">
							<tr>
								<td class="searchTabletd" style="text-align: right"><label>机器名称:</label></td>
								<td class="searchTabletd">
									<div class="nav-search">
										<input type="text" placeholder="机器名称" class="nav-search-input" id="machineName" autocomplete="off"
												   name="machineName" value="${pd.machineName }" style="width: 145px;"/>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: right"><label>小推车名称:</label></td>
								<td class="searchTabletd">
									<div class="nav-search">
											<input type="text" placeholder="小推车名称" class="nav-search-input" id="carName" autocomplete="off"
												   name="carName" value="${pd.carName }" style="width: 145px;"/>
									</div>
								</td>
							</tr>
							<tr >
								<td class="searchTabletd" style="text-align: right"><label>操作人:</label></td>
								<td class="searchTabletd" >
									<div class="nav-search">
										<input type="text" placeholder="操作人" class="nav-search-input" id="staffName" autocomplete="off"
											   name="staffName" value="${pd.staffName}" style="width: 145px;"/>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: right"><label>扫描时间:</label></td>
								<td class="searchTabletd">
									<div class="nav-search">
									<input class="span10 date-picker nav-search-input" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" data-date-format="yyyy-mm-dd"
										   readonly="readonly" style="width:145px;" placeholder="开始日期"/>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: right">--</td>
								<td class="searchTabletd">
									<div class="nav-search">
									<input class="span10 date-picker nav-search-input" name="lastEnd" name="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
										   style="width:145px;" placeholder="结束日期"/>
									</div>
								</td>
								<td class="searchTabletd">
									<a class="btn btn-mini btn-qg" onclick="tosearch();" >查询</a>
									<%--<a class="btn btn-mini btn-qg" onclick="toExcel();" >导出</a>--%>
								</td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table-striped table-bordered table-hover" style="margin-top:20px;background-color: transparent;border-collapse: collapse;border-spacing: 0;width: 2088px;">
							<thead>
								<tr>
									<%--<th class="center" style="width:35px;" rowspan="2">--%>
									<%--<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>--%>
									<%--</th>--%>
									<th class="center" style="width:50px;" rowspan="2">序号</th>
									<th class="center" style="width:120px;" rowspan="2">机器名称</th>
									<th class="center"  style="width:120px;" rowspan="2">机器编码</th>
									<th class="center"  style="width:120px;" rowspan="2">机器类型</th>
									<th class="center"  style="width:120px;" rowspan="2">巡视次数</th>
									<th class="center"  style="width:120px;" rowspan="2">保养信息</th>
									<th class="center" colspan ="6">维修信息</th>
									<th class="center" colspan ="6">改规格信息</th>
								</tr>
								<tr>
									<th class="center"  style="width:150px;">通知维修次数</th>
									<th class="center"  style="width:150px;">开始维修次数</th>
									<th class="center"  style="width:150px;">结束维修次数</th>
									<th class="center"  style="width:150px;">平均通知响应时效(分)</th>
									<th class="center"  style="width:150px;">平均维修时长(分)</th>
									<th class="center"  style="width:150px;">维修总用时(分)</th>
									<th class="center"  style="width:150px;">通知改规格次数</th>
									<th class="center"  style="width:150px;">开始改规格次数</th>
									<th class="center"  style="width:150px;">结束改规格次数</th>
									<th class="center"  style="width:150px;">平均通知响应时效(分)</th>
									<th class="center"  style="width:150px;">平均改规格时长(分)</th>
									<th class="center"  style="width:150px;">改规格总用时(分)</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<%--<td class='center'>--%>
												<%--<label class="pos-rel"><input type='checkbox' name='ids' value="${var.srid}" class="ace" /><span class="lbl"></span></label>--%>
											<%--</td>--%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.machineName}</td>
											<td class='center'>${var.machineCode}</td>
											<td class='center'>${var.typeName}</td>
											<td class='center'>${var.xsCount}</td>
											<td class='center'>${var.cycleInfo}</td>
											<td class='center'>${var.wxtzCount}</td>
											<td class='center'>${var.wxksCount}</td>
											<td class='center'>${var.wxjsCount}</td>
											<td class='center'>${var.wxavgtz}</td>
											<td class='center'>${var.wxavgwx}</td>
											<td class='center'>${var.wxsum}</td>
											<td class='center'>${var.gggtzCount}</td>
											<td class='center'>${var.gggksCount}</td>
											<td class='center'>${var.gggjsCount}</td>
											<td class='center'>${var.gggavgtz}</td>
											<td class='center'>${var.gggavgggg}</td>
											<td class='center'>${var.gggsum}</td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">

								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				clearBtn: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>company/excel.do';
		}
	</script>


</body>
</html>