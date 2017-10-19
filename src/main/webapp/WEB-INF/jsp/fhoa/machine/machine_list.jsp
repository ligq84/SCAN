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
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="machine/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td class="searchTabletd"  style="text-align: right">机器名称:</td>
								<td class="searchTabletd">
									<div class="nav-search">
										<input type="text"  class="nav-search-input" id="Name" autocomplete="off" name="Name"
											   value="${pd.Name}" style="width: 145px;" placeholder="这里输入机器名称"/>

									</div>
								</td>
								<td class="searchTabletd" style="text-align: right">机器类型:</td>
								<td class="searchTabletd">
									<div class="nav-search">
										<select class="nav-search-input" name="TYPE" id="TYPE"  style="vertical-align:top;width: 145px;"  title="现岗位"  >
											<option value="">全部</option>
											<c:forEach items="${machineTypeList}" var="machineType">
												<option value="${machineType.OCBID }" <c:if test="${machineType.OCBID == pd.TYPE}">selected</c:if> >${machineType.NAME}</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: right">负责人:</td>
								<td class="searchTabletd" >
									<div class="nav-search">
										<input type="text"  class="nav-search-input" id="Repairman" autocomplete="off" name="Repairman"
											   value="${pd.Repairman }" placeholder="这里输入负责人" style="width: 145px;"/>
									</div>
								</td>
								<%--<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>--%>
							</tr>
							<tr>
								<td class="searchTabletd" style="text-align: right">更改规格:</td>
								<td class="searchTabletd">
									<div class="nav-search">
										<select class="nav-search-input" name="CHANGE_RULE" id="id" data-placeholder="请选择" style="vertical-align:top;width: 145px;">
											<option value="">全部</option>
											<option value="0" <c:if test="${pd.CHANGE_RULE == '0'}">selected</c:if>>支持</option>
											<option value="1" <c:if test="${pd.CHANGE_RULE == '1'}">selected</c:if> >不支持</option>
										</select>
									</div>
								</td>
								<td class="searchTabletd" colspan="2">
									<a class="btn btn-mini btn-qg" onclick="tosearch();" >查询</a>
									<c:if test="${QX.add == 1 }">
										<a class="btn btn-mini btn-qg" onclick="add();">新增机器</a>
									</c:if>
								</td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:20px;">
							<thead>
								<tr>
									<%--<th class="center" style="width:35px;">--%>
									<%--<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>--%>
									<%--</th>--%>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">机器名称</th>
									<th class="center">类型</th>
									<th class="center">型号</th>
									<th class="center">功率</th>
									<th class="center">更改规格</th>
									<th class="center">机器负责人</th>
									<th class="center">白班维修员</th>
									<th class="center">晚班维修员</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'>${var.typeName}</td>
											<td class='center'>${var.MODEL}</td>
											<td class='center'>${var.POWER}</td>
											<td class='center'>${var.CHANGERULEName}</td>
											<td class='center'>${var.chargeName}</td>
											<td class='center'>${var.DayName}</td>
											<td class='center'>${var.NightName}</td>
											<td class="center">
												<div class=" btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="" title="打印条码" onclick="print('${var.BARCODE}','${var.MHID}');">
														<img src="/static/images/tiaoma.png" />
													</a>
													</c:if>
													<c:if test="${QX.edit == 1 }">
													<a class="" title="编辑" onclick="edit('${var.MHID}');">
														<img src="/static/images/edit.png" />
													</a>
													</c:if>
													<c:if test="${QX.edit == 1 }">
													<a class="" onclick="del('${var.MHID}');">
														<img src="/static/images/delete.png" />
													</a>
													</c:if>
												</div>
											</td>
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
		
		//新增
		function add(){
			var form = $('<form action="<%=basePath%>machine/goAdd.do" method="get"></form>');
			$(document.body).append(form);
			form.submit()
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>machine/delete.do?MHID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			var form = $('<form action="<%=basePath%>machine/goEdit.do" method="get"><input type="text" name="MHID" value="'+Id+'"/></form>');
			$(document.body).append(form);
			form.submit()
		}
		function print(BARCODE,MHID){
			window.open("<%=basePath%>/machine/printPage.do?BARCODE="+BARCODE+"&MHID="+MHID, "",
					'left=250,top=150,width=750,height=500,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,location=no');
		}

		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>machine/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>machine/excel.do';
		}
	</script>


</body>
</html>