﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
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
						<form action="department/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<input type="text" placeholder="请输入部门名称" class="nav-search-input" id="keywords" name="keywords"
												   autocomplete="off" value="${page.pd.keywords }" style="width: 145px;"/>
									</div>
								</td>
								<td>
									<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${DEPARTMENT_ID}">
									<%--<select name="DEPARTMENT_ID" id="DEPARTMENT_ID">--%>
										<%--<option value="${DEPARTMENT_ID}" <c:if test="${DEPARTMENT_ID != ''}">selected</c:if>>本级</option>--%>
										<%--<option value="" <c:if test="${DEPARTMENT_ID == ''}">selected</c:if>>全部</option>--%>
									<%--</select>	--%>
								</td>
								<%--<c:if test="${QX.cha == 1 }">--%>
								<td style="vertical-align:top;padding-left:2px">
									<a class="btn btn-mini btn-qg" onclick="gsearch();">查询</a>
									<c:if test="${QX.add == 1 }">
										<a class="btn btn-mini btn-qg" onclick="add('${DEPARTMENT_ID}');">新增部门</a>
									</c:if>
								</td>
								<%--</c:if>--%>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">部门名称</th>
									<%--<th class="center">英文</th>--%>

									<th class="center">负责人</th>
									<th class="center">负责人电话</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.NAME}</td>
											<%--<td class='center'>${var.NAME_EN}</td>--%>

											<td class='center'>${var.HEADMAN}</td>
											<td class='center'>${var.TEL}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btnTb" title="编辑" onclick="edit('${var.DEPARTMENT_ID}');">
														<img src="/static/images/edit.png" />
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btnTb" onclick="del('${var.DEPARTMENT_ID}');">
														<img src="/static/images/delete.png" />
													</a>
													</c:if>
												</div>
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
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
								<%--<td style="vertical-align:top;">--%>
									<%----%>
									<%--<c:if test="${null != pd.DEPARTMENT_ID && pd.DEPARTMENT_ID != ''}">--%>
									<%--<a class="btn btn-sm btn-success" onclick="goSondict('${pd.PARENT_ID}');">返回</a>--%>
									<%--</c:if>--%>
								<%--</td>--%>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//去此ID下子级列表
		function goSondict(DEPARTMENT_ID){
			top.jzts();
			window.location.href="<%=basePath%>department/list.do?DEPARTMENT_ID="+DEPARTMENT_ID;
		};
		
		//新增
		function add(DEPARTMENT_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增部门";
			 diag.URL = '<%=basePath%>department/goAdd.do?DEPARTMENT_ID='+DEPARTMENT_ID;
			 diag.Width = 380;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				 if('none' == diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display){
					 parent.location.href="<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&dnowPage=${page.currentPage}";
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>department/delete.do?DEPARTMENT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if("success" == data.result){
							parent.location.href="<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&dnowPage=${page.currentPage}";
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>删除失败！请先删除子级部门.</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "确定",
										"className" : "btn-sm btn-success"
									}
								}
							});
						}
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑部门";
			 diag.URL = '<%=basePath%>department/goEdit.do?DEPARTMENT_ID='+Id;
			 diag.Width = 380;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 parent.location.href="<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&dnowPage=${page.currentPage}";
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>