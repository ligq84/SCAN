<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title></title>
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<style type="text/css">
		.fontSize{
			font-size:35px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			padding-left: 180px;
			padding-top: 50px;
		}
		.fontSizeCode{
			font-size:35px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			padding-left:175px;
			padding-top: 10px;
			letter-spacing:13px;
		}
	</style>
</head>
<body>
<div id="zhongxin">

	<table width="1190"    border="0" align="center" cellspacing="1" bgcolor="#221144">
		<tr bgcolor="#EFEFFF">
			<td align="center" style="padding-top: 20px;padding-bottom: 20px;text-align: left">
				<img src="/static/images/printCompayLogo.jpg" style="margin-left: 180px;"><br/>
				<div class="row fontSize">
					<label>小推车名称：</label><span>${pd.NAME}</span>
				</div>
				<div class="row fontSize">
					<label>小推车类型：</label><span>${pd.typeName}</span>
				</div>
				<div class="row fontSize">
					<label>小推车编号：</label><span>${pd.CAR_ID}</span>
				</div>
				<div class="row fontSize">
					<label>采购时间：</label><span>${pd.PURCHASEDATE}</span>
				</div>
				<img src="${pd.BARCODEURL}" style="margin-top: 80px;margin-left: 105px;"><br/>
				<div class="row fontSizeCode"  >
					<span>${pd.BARCODE}</span>
				</div>
			</td>

		</tr>
	</table>




</div>


<!-- 引入 -->
<%--<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>--%>
<%--<script src="static/js/bootstrap.min.js"></script>--%>
<%--<script src="static/js/ace-elements.min.js"></script>--%>
<%--<script src="static/js/ace.min.js"></script>--%>

<script type="text/javascript">

	window.print();
</script>
</body>
</html>