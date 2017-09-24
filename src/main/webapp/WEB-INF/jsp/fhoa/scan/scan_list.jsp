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
							
						<!-- 检索  -->
						<form action="scan/list.do" method="post" name="Form" id="Form">
							<input type="hidden" name="scan_type" value="${pd.scan_type}">
						<table style="margin-top:5px;">
							<tr>
								<td style="padding-left:5px;text-align: right"><label>机器名称:</label></td>
								<td style="padding-left:5px;">
									<div class="nav-search">
										<input type="text" placeholder="机器名称" class="nav-search-input" id="machineName" autocomplete="off"
												   name="machineName" value="${pd.machineName }" style="width: 145px;"/>
									</div>
								</td>
								<c:if test="${pd.scan_type =='1,3'}">
								<td style="padding-left:5px;text-align: right"><label>扫描类型:</label></td>
								<td style="padding-left:5px;">
									<div class="nav-search">
										<select class="nav-search-input" name="selectScanType" id="selectScanType"  style="vertical-align:top;width: 145px;"  title="扫描类型"  >
											<option value="">全部</option>
											<option value="1" <c:if test="${pd.selectScanType =='1'}">selected</c:if> >巡视扫描</option>
											<option value="3" <c:if test="${pd.selectScanType == '3'}">selected</c:if> >保养扫描</option>
										</select>
									</div>
								</td>
								</c:if>
								<c:if test="${pd.scan_type =='2' || pd.scan_type =='4'}">
									<td style="padding-left:5px;text-align: right"><label>更改类型:</label></td>
									<td style="padding-left:5px;">
										<div class="nav-search">
											<select class="nav-search-input" name="changeType" id="changeType"  style="vertical-align:top;width: 145px;"  title="更改类型"  >
												<option value="">全部</option>
												<option value="0" <c:if test="${pd.changeType =='1'}">selected</c:if> >开始操作</option>
												<option value="1" <c:if test="${pd.changeType == '3'}">selected</c:if> >结束操作</option>
											</select>
										</div>
									</td>
								</c:if>

								<td style="padding-left:5px;text-align: right"><label>小推车名称:</label></td>
								<td style="padding-left:5px;">
									<div class="nav-search">
											<input type="text" placeholder="小推车名称" class="nav-search-input" id="carName" autocomplete="off"
												   name="carName" value="${pd.carName }" style="width: 145px;"/>
									</div>
								</td>
							</tr>
							<tr >
								<td style="padding-left:5px;text-align: right"><label>操作人:</label></td>
								<td style="padding-left:5px;">
									<div class="nav-search">
										<input type="text" placeholder="操作人" class="nav-search-input" id="staffName" autocomplete="off"
											   name="staffName" value="${pd.staffName}" style="width: 145px;"/>
									</div>
								</td>
								<td style="padding-left:5px;text-align: right"><label>扫描时间:</label></td>
								<td style="padding-left:5px;">
									<input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" data-date-format="yyyy-mm-dd"
										   readonly="readonly" style="width:145px;" placeholder="开始日期"/>
								</td>
								<td style="padding-left:5px;">
									<input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
										   style="width:145px;" placeholder="结束日期"/>
								</td>
								<td style="vertical-align:top;padding-left:5px">
									<a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a>
									<a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a>
								</td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">扫描类型</th>
									<c:if test="${pd.scan_type =='1,3'}">
									<th class="center">保养类型</th>
									</c:if>
									<c:if test="${pd.scan_type =='2' || pd.scan_type =='4'}">
									<th class="center">操作类型</th>
									</c:if>
									<th class="center">机器名称</th>
									<th class="center">机器编码</th>
									<th class="center">小推车名称</th>
									<th class="center">小推车编码</th>
									<th class="center">操作人</th>
									<th class="center">操作时间</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.srid}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.scan_type}</td>
											<c:if test="${pd.scan_type =='1,3'}">
											<td class='center'>${var.cycle_type}</td>
											</c:if>
											<c:if test="${pd.scan_type =='2' || pd.scan_type =='4'}">
											<td class='center'>${var.operation_type}</td>
											</c:if>
											<td class='center'>${var.mname}</td>
											<td class='center'>${var.mcode}</td>
											<td class='center'>${var.carName}</td>
											<td class='center'>${var.carCode}</td>
											<td class='center'>${var.staff_name}</td>
											<td class='center'>${var.scan_date}</td>
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