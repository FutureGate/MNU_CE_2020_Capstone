<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%
	UserDTO user = (UserDTO) request.getSession().getAttribute("user");
%>


<meta charset="UTF-8">
<title>수요 모니터링 시스템 - 제품 수요 모니터링</title>

<style type="text/css">
#contentBody {
	min-height: 500px;
}

#grid {
	margin-left: 5px;
	margin-right: 5px;
}

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

</style>

</head>

<body>
	<jsp:include page="./fragment/topmenu.jsp"></jsp:include>

	<div class="ui bottom attached segment pushable" id="contentBody">
		<jsp:include page="./fragment/sidebar.jsp"></jsp:include>

		<div class="pusher">
			<div class="ui container">
				<br> <br> <br>

				<h2 class="ui header">
					<i class="chart line icon"></i>
					<div class="content">월별 수요 통계</div>
				</h2>

				<div class="ui divider"></div>

				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">월간 합계 (2016년도)</div>
					</h4>
					
					<div id="monthly_sum_chart"></div>
				</div>
				
				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">월간 평균 (2016년도)</div>
					</h4>
					
					<div id="monthly_mean_chart"></div>
				</div>
			</div>
		</div>


		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-csv/0.8.3/jquery.csv.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
		google.charts.load('current', {
		  	callback: function () {
		    	$.get("monthly_sum.csv", function(csvString) {
			     	var arrayData = $.csv.toArrays(csvString, {onParseValue: $.csv.hooks.castToScalar});
	
			     	
			      	var data = new google.visualization.arrayToDataTable(arrayData);
					data.Ff[1].label = '판매량';
					
			      	var chart = new google.visualization.ColumnChart(document.getElementById('monthly_sum_chart'));
			      	chart.draw(data);
		    	});
		    	
		    	$.get("monthly_mean.csv", function(csvString) {
			     	var arrayData = $.csv.toArrays(csvString, {onParseValue: $.csv.hooks.castToScalar});

			      	var data = new google.visualization.arrayToDataTable(arrayData);
			      	data.Ff[1].label = '판매량';
			      	
			      	var chart = new google.visualization.ColumnChart(document.getElementById('monthly_mean_chart'));
			      	chart.draw(data);
			    	});
		  	},
		  	packages: ['corechart']
		});
	</script>
</body>
</html>