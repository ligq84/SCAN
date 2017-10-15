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
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- 树形下拉框start -->
<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
<!-- 树形下拉框end -->
	<style type="text/css">
		.searchTabletd{
			padding-left:10px;
			padding-top: 10px;
		}
		.btn-qg,.btn-qg:hover{
			background-color: #0e77d9 !important;color: white !important;
			border-color: #0e77d9 !important;
			border-radius:4px;
		}
		.nav-search .nav-search-input{
			color: #282828 !important;
			font-family: Microsoft YaHei !important;
		}
		input[readonly] {
			color: #939192;
			background: none !important;
			cursor: default;
		}
		.table > thead > tr{
			color:#282828;
		}
		#selectTree >table >tbody >tr>td:first-of-type > input{
			color: #282828 !important;
			font-family: Microsoft YaHei !important;
			width: 145px !important;
			border-radius: 4px !important;
			border: 1px solid #6FB3E0;
		}
		#selectTree >table >tbody >tr>td:nth-of-type(2) > input{
			display: none;
		}
		div.selectbox-tree {
			width: 145px !important;
		}
		*{
			font-family: Microsoft YaHei;
			color: #282828;
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
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="staff/list.do" method="post" name="Form" id="Form">
						<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden" value="${pd.ZDEPARTMENT_ID }" />
						<input name="DEPARTMENT_ID" id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" />
						<table style="margin-top:5px;" id="searchTable">
							<tr>
								<td class="searchTabletd" style="text-align: right">
									<label>姓名:</label>
								</td>
								<td class="searchTabletd">
									<div class="nav-search">
										<input type="text" class="nav-search-input " name="NAME" value="${pd.NAME}"  placeholder="这里输入姓名" style="width: 145px;"/>
									</div>
								</td>
								<td  class="searchTabletd" style="text-align: right"><label>联系电话:</label></td>
								<td class="searchTabletd">
									<div class="nav-search">
										<input type="text" class="nav-search-input"  name="TEL" value="${pd.TEL}" placeholder="这里输入联系电话" style="width: 145px;"/>
									</div>
								</td>
								<td  class="searchTabletd" style="text-align: right"><label>所属部门:</label></td>
								<td  class="searchTabletd">
									<div class="nav-search">
										<div class="selectTree" id="selectTree"></div>
									</div>
								</td>

							</tr>
							<tr>
								<td  class="searchTabletd" style="text-align: right"><label>人员岗位:</label></td>
								<td  class="searchTabletd">
									<div class="nav-search">
										<select class="nav-search-input" name="POST" id="POST" style="vertical-align:top;width: 145px;"  title="人员岗位"  >
											<option value="">全选</option>
											<c:forEach items="${staffPostList}" var="staffPost">
												<option value="${staffPost.OCBID }" <c:if test="${staffPost.OCBID == pd.POST }">selected</c:if> >${staffPost.NAME}</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: right">
									<label>系统账号:</label>
								</td>
								<td  class="searchTabletd">
									<div class="nav-search">
										<input type="text" class="nav-search-input" name="USERNAME" value="${pd.USERNAME}"  placeholder="这里输入系统账号" style="width: 145px;"/>
									</div>
								</td>
								<td  class="searchTabletd" style="text-align: right"><label>在职状态:</label></td>
								<td  class="searchTabletd">
									<div class="nav-search">
										<select name="STATUS" id="STATUS" class="nav-search-input" style="width: 145px;">
											<option value="" >全选</option>
											<option value="0" <c:if test="${pd.STATUS == '0'}">selected</c:if>>在职</option>
											<option value="1" <c:if test="${pd.STATUS == '1'}">selected</c:if>>离职</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td  class="searchTabletd"style="text-align: right"><label>入职时间:</label></td>
								<td  class="searchTabletd" >
									<div class="nav-search">
										<input class="span10 date-picker nav-search-input" name="DJOINTIMESTART" value="${pd.DJOINTIMESTART}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
											   placeholder="开始时间"  style="width: 145px;"/>
									</div>
								</td>
								<td class="searchTabletd" style="text-align: center"><label>---</label></td>
								<td class="searchTabletd">
									<div class="nav-search">
										<input class="span10 date-picker nav-search-input" name="DJOINTIMEEND" value="${pd.DJOINTIMEEND}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
											   placeholder="结束时间"  style="width: 145px;"/>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td class="searchTabletd" style="vertical-align:top;text-align: center;">
										<%--<a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a>--%>
										<a class="btn btn-mini btn-qg" onclick="tosearch();" >查询</a>
									</td>
								</c:if>
								<c:if test="${QX.add == 1 }">
									<td class="searchTabletd">
										<a class="btn btn-mini btn-qg" onclick="add();">添加人员</a>
										<c:if test="${QX.del == 1 }">
										<%--<a class="" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >--%>
											<%--<img src="/static/images/delete.png" />--%>
										<%--</a>--%>
										</c:if>
									</td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td class="searchTabletd" style="vertical-align:top;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>


							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<%--<th class="center" style="width:35px;">--%>
									<%--<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>--%>
									<%--</th>--%>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">姓名</th>
									<th class="center">联系电话</th>
									<%--<th class="center">身份证号码</th>--%>
									<th class="center">所属部门</th>
									<th class="center">人员岗位</th>
									<th class="center">学历</th>
									<th class="center">毕业院校</th>
									<th class="center">入职时间</th>
									<th class="center">系统账号</th>
									<th class="center" style="width:130px;" id="fhadmincz">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<%--<td class='center'>--%>
												<%--<label class="pos-rel"><input type='checkbox' name='ids' value="${var.STAFF_ID}" class="ace" /><span class="lbl"></span></label>--%>
											<%--</td>--%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'>${var.TEL}</td>
											<%--<td class='center'>${var.SFID}</td>--%>
											<td class='center'>${var.departmentName}</td>
											<td class='center'>${var.postName}</td>
											<td class='center'>${var.EDUCATION}</td>
											<td class='center'>${var.SCHOOL}</td>
											<td class='center'>${var.DJOINTIME}</td>
											<td class='center'>${var.USERNAME}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-xs btn-group">
													<%--<c:if test="${QX.userBinding == 1 }">--%>
													<%--<a class="btn btn-xs btn-info" title="绑定用户" onclick="userBinding('${var.STAFF_ID}');">--%>
														<%--<i class="ace-icon glyphicon glyphicon-user"></i>--%>
													<%--</a>--%>
													<%--</c:if>--%>
													<%--<c:if test="${QX.Datajur == 1 }">--%>
													<%--<a class="btn btn-warning btn-xs" title="授权" onclick="setDatajur('${var.STAFF_ID}');">--%>
														<%--<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>--%>
													<%--</a>--%>
													<%--</c:if>--%>
													<c:if test="${QX.edit == 1 }">
													<a class="" title="编辑" onclick="edit('${var.STAFF_ID}');">
														<img src="/static/images/edit.png" />
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="" onclick="del('${var.STAFF_ID}');">
														<%--<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>--%>
														<img src="/static/images/delete.png" />
													</a>
													</c:if>
												</div>
												<%--<div class=" hidden-lg">--%>
													<%--<div class="inline pos-rel">--%>
														<%--&lt;%&ndash;<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">&ndash;%&gt;--%>
															<%--&lt;%&ndash;<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>&ndash;%&gt;--%>
														<%--&lt;%&ndash;</button>&ndash;%&gt;--%>
			<%----%>
														<%--<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">--%>
															<%--<c:if test="${QX.userBinding == 1 }">--%>
															<%--&lt;%&ndash;<li>&ndash;%&gt;--%>
																<%--&lt;%&ndash;<a style="cursor:pointer;" onclick="userBinding('${var.STAFF_ID}');" class="tooltip-warning" data-rel="tooltip" title="绑定用户">&ndash;%&gt;--%>
																	<%--&lt;%&ndash;<span class="blue">&ndash;%&gt;--%>
																		<%--&lt;%&ndash;<i class="ace-icon glyphicon glyphicon-user"></i>&ndash;%&gt;--%>
																	<%--&lt;%&ndash;</span>&ndash;%&gt;--%>
																<%--&lt;%&ndash;</a>&ndash;%&gt;--%>
															<%--&lt;%&ndash;</li>&ndash;%&gt;--%>
															<%--</c:if>--%>
															<%--<c:if test="${QX.Datajur == 1 }">--%>
															<%--&lt;%&ndash;<li>&ndash;%&gt;--%>
																<%--&lt;%&ndash;<a style="cursor:pointer;" onclick="setDatajur('${var.STAFF_ID}');" class="tooltip-warning" data-rel="tooltip" title="授权">&ndash;%&gt;--%>
																	<%--&lt;%&ndash;<span class="orange">&ndash;%&gt;--%>
																		<%--&lt;%&ndash;<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>&ndash;%&gt;--%>
																	<%--&lt;%&ndash;</span>&ndash;%&gt;--%>
																<%--&lt;%&ndash;</a>&ndash;%&gt;--%>
															<%--&lt;%&ndash;</li>&ndash;%&gt;--%>
															<%--</c:if>--%>
															<%--<c:if test="${QX.edit == 1 }">--%>
															<%--<li>--%>
																<%--<a style="cursor:pointer;" onclick="edit('${var.STAFF_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">--%>
																	<%--<span class="green">--%>
																		<%--<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>--%>
																	<%--</span>--%>
																<%--</a>--%>
															<%--</li>--%>
															<%--</c:if>--%>
															<%--<c:if test="${QX.del == 1 }">--%>
															<%--<li>--%>
																<%--<a style="cursor:pointer;" onclick="del('${var.STAFF_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">--%>
																	<%--<span class="red">--%>
																		<%--<i class="ace-icon fa fa-trash-o bigger-120"></i>--%>
																	<%--</span>--%>
																<%--</a>--%>
															<%--</li>--%>
															<%--</c:if>--%>
														<%--</ul>--%>
													<%--</div>--%>
												<%--</div>--%>
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
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
			// 创建Form
			var form = $('<form action="<%=basePath%>staff/goAdd.do" method="get"><input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden" value="${pd.ZDEPARTMENT_ID }" />'+
					'<input name="DEPARTMENT_ID" id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" /></form>');
			$(document.body).append(form);
			form.submit()
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>staff/delete.do?STAFF_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 <%--top.jzts();--%>
			 <%--var diag = new top.Dialog();--%>
			 <%--diag.Drag=true;--%>
			 <%--diag.Title ="编辑";--%>
			 <%--diag.URL = '<%=basePath%>staff/goEdit.do?STAFF_ID='+Id;--%>
			 <%--diag.Width = 800;--%>
			 <%--diag.Height = 500;--%>
			 <%--diag.Modal = true;				//有无遮罩窗口--%>
			 <%--diag. ShowMaxButton = true;	//最大化按钮--%>
		     <%--diag.ShowMinButton = true;		//最小化按钮--%>
			 <%--diag.CancelEvent = function(){ //关闭事件--%>
				 <%--if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){--%>
					 <%--nextPage(${page.currentPage});--%>
				<%--}--%>
				<%--diag.close();--%>
			 <%--};--%>
			 <%--diag.show();--%>
			var form = $('<form action="<%=basePath%>staff/goEdit.do" method="get"><input type="text" name="STAFF_ID" value="'+Id+'"/><input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden" value="${pd.ZDEPARTMENT_ID }" />'+
					'<input name="DEPARTMENT_ID" id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" /></form>');
			$(document.body).append(form);
			form.submit()
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
								url: '<%=basePath%>staff/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		};
		
		
		function initComplete(){
			//下拉树
			var defaultNodes = {"treeNodes":${zTreeNodes}};
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
			$("#selectTree2_input").val("${'0'==depname?'请选择':depname}");
		}
		
		//授权(组织机构数据权限)
		function setDatajur(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="授予组织机构数据权限";
			 diag.URL = '<%=basePath%>datajur/goEdit.do?DATAJUR_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//打开绑定用户窗口
		function userBinding(STAFF_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="绑定用户";
			 diag.URL = '<%=basePath%>user/listUsersForWindow.do';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					var USERNAME = diag.innerFrame.contentWindow.document.getElementById('USERNAME').value;
					var url = "<%=basePath%>staff/userBinding.do?STAFF_ID="+STAFF_ID+"&USER_ID="+USERNAME+"&tm="+new Date().getTime();
					$.get(url,function(data){
						$("#fhadmincz").tips({
							side:1,
				            msg:'绑定成功',
				            bg:'#009933',
				            time:3
				        });
						tosearch();
					});
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>staff/excel.do';
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true,clearBtn: true});
		});
	</script>


</body>
</html>