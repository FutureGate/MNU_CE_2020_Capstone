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
					<div class="content">제품 페이지</div>
				</h2>

				<div class="ui divider"></div>

				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">제품 상세</div>
					</h4>
				
					<form class="ui form" id="inputForm">
						<div class="two fields">	      						
      						<div class="field">
      							<label>판매점 코드</label>
       	 						<input type="text" name="prodCode" id="prodCodeInput" value="25">
      						</div>
      						<div class="field">
      							<label>상품코드</label>
       	 						<input type="text" name="prodName" id="prodNameInput" value="105574">
      						</div>
    					</div>
					</form>
				</div>
				
				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">연간 예측</div>
					</h4>
					
					<div id="chart"></div>
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
	
		google.charts.load('current', {packages: ['corechart', 'line']});
		google.charts.setOnLoadCallback(drawLineColors);
	
		var origin_data;
		var pred_data;
		var dataArray = new Array();
		
		function drawLineColors() {
			dataArray.push(['day', '기존 판매량', '예측된 판매량']);
			$.get("origin_data.csv", getOriginData);
		}
		
		function getOriginData(csvString) {
			var arrayData = $.csv.toArrays(csvString, {onParseValue: $.csv.hooks.castToScalar});
			
			console.log(arrayData[1][0]);
			
	      	for(i=1; i<arrayData.length; i++) {
	      		
	      		dataArray.push([i, arrayData[i][1], null]);
	      	}
	      	
	      	$.get("pred_data.csv", getPredData);
		}
		
		function getPredData(csvString) {
			var arrayData = $.csv.toArrays(csvString, {onParseValue: $.csv.hooks.castToScalar});
			
			console.log('원데이터');
			console.log(arrayData);
			
			for(i=1; i<arrayData.length; i++) {
	      		
				dataArray.push([i + arrayData[1][0], null, arrayData[i][1]]);
	      	}
			
			console.log(dataArray);
	      	var dataTable = new google.visualization.arrayToDataTable(dataArray);
	      	
	      	
	      	var options = {
			        hAxis: {
			          title: '일'
			        },
			        vAxis: {
			          title: '판매량'
			        },
			        chart: {
			            title: 'Box Office Earnings in First Two Weeks of Opening',
			            subtitle: 'in millions of dollars (USD)'
			        },
			        height: 500,
			        colors: ['#000000', '#a52714']
		      	};

	      	var chart = new google.visualization.LineChart(document.getElementById('chart'));
	      	chart.draw(dataTable, options);
		}
	</script>
</body>
</html>