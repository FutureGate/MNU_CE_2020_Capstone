<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
</head>


<body>

	<div class="ui left vertical sidebar fixed menu" id="sidebar">
		<br> <br> <br>
		<a class="item header" href="./productMonitoring.do"> 제품별 수요 모니터링 </a>
		<a class="item header" href="./monthlyMonitoring.do"> 월별 수요 모니터링 </a>
		<a class="item header" href="./monthlyMonitoring.do"> 계절별 수요 모니터링 </a>
		<a class="item header" href="./productMonitoring.do"> 명절별 수요 모니터링 </a>
		<a class="item header" href="./productMonitoring.do"> 상품 관리 </a>
		<a class="item header" href="./saleManagement.do"> 판매 이력 관리 (수동)</a>
		<a class="item header" href="./saleManagementAuto.do"> 판매 이력 관리 (자동)</a>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#sidebar').sidebar({
				context : $('#contentBody')
			}).sidebar('attach events', '#sidebar_toggler');
		
			$('#sidebar').hide();
		});
	</script>
</body>
</html>