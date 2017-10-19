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
			font-size:19px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			margin-left: 84px;
			margin-top: 46px;
		}
		.fontSize >div{
			width: 98px;
			display: inline-block;
		}.fontSize >span{
			 width: 140px;
			 display: inline-block;
		 }

		.fontSizeCode{
			font-size:35px;
			font-family: Microsoft YaHei;
			color: #282828;
			text-align: left;
			padding-left:70px;
			padding-top: 10px;
			letter-spacing:13px;
		}
	</style>
	</head>
<body>
<div id="zhongxin" style="width: 1190px;text-align: left;">

<table  style="width: 660px;height: 660px;border: 1px solid black;margin-left: 96px;" cellspacing="1" bgcolor="#221144">
  <tr bgcolor="#EFEFFF">
    <td  style="text-align: left">
		<img src="/static/images/printCompayLogo.jpg" style="margin-left: 52px;margin-top: 26px;width: 560px;"><br/>
		<div class="row fontSize">
			<div>机器名称：</div><span>${pd.NAME}</span>
			<div>机器类型：</div><span>${pd.typeName}</span>
		</div>
		<div class="row fontSize">
			<div>机器型号：</div><span>${pd.MODEL}</span>
			<div>机器功率：</div><span>${pd.POWER}</span>
		</div>
		<div class="row fontSize">
			<div>出厂年月：</div><span>${pd.production_date}</span>
			<div>机台速度：</div><span>${pd.speed}</span>
		</div>
		<div class="row fontSize">
			<div>生产厂家：</div><span style="width: 280px;">${pd.manufacturer}</span>
		</div>
		<img src="${pd.BARCODEURL}" style="margin-top: 44px;margin-left: 4px;"><br/>
		<div class="row fontSizeCode"  >
			<span>${pd.BARCODE}</span>
		</div>
    </td>
  </tr>
</table>
</div>
<script type="text/javascript">

    window.print();
</script>
</body>
</html>