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
			font-size:10px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			padding-left: 50px;
			padding-top: 10px;
		}
		.fontSizeCode{
			font-size:12px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			padding-left:47px;
			padding-top: 0px;
			letter-spacing:10px;
		}
	</style>
</head>
<body>
<div id="zhongxin" style="width: 1190px;text-align: left;">
	<table style="width: 330px;height: 330px;border: 1px solid black;margin-left: 21px;"  cellspacing="1" bgcolor="#221144">
		<tr bgcolor="#EFEFFF">
			<td align="center" style="text-align: left">
				<img src="/static/images/printCompayLogo.jpg" style="margin-left: 21px;margin-top: 16px;width: 288px;"><br/>
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
				<img src="${pd.BARCODEURL}" style="margin-top: 20px;margin-left: 12px;"><br/>
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