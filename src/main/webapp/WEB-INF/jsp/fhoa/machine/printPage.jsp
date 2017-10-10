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
			padding-left: 150px;
			padding-top: 10px;
			letter-spacing:26px;
		}
	</style>
	</head>
<body>
<div id="zhongxin">

<table width="650"    border="0" align="center" cellspacing="1" bgcolor="#221144">
  <tr bgcolor="#EFEFFF">
    <td align="center" style="padding-top: 20px;padding-bottom: 20px;">
		<img src="/static/images/printCompayLogo.png"><br/>
		<div class="row fontSize">
			<label>机器名称：</label><span>${pd.NAME}</span>
		</div>
		<div class="row fontSize">
			<label>机器类型：</label><span>${pd.typeName}</span>
		</div>
		<div class="row fontSize">
			<label>机器型号：</label><span>${pd.MODEL}</span>
		</div>
		<div class="row fontSize">
			<label>机器功率：</label><span>${pd.POWER}</span>
		</div>
        <img src="${pd.BARCODEURL}" style="margin-top: 80px;"><br/>
		<div class="row fontSizeCode">
			<span>${pd.BARCODE}</span>
		</div>
    </td>

  </tr>
</table>




</div>
		

		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
<script type="text/javascript">

    window.print();
</script>
</body>
</html>