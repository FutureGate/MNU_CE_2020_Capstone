<%@page import="com.dto.ShopDTO"%>
<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%
	UserDTO user = (UserDTO) request.getSession().getAttribute("user");
	ShopDTO shop = (ShopDTO) request.getSession().getAttribute("shop");
	
	String userID = user.getUserID();
	int shopID = shop.getShopID();
%>


<meta charset="UTF-8">
<title>수요 모니터링 시스템 - 계절별 수요 모니터링</title>
<link href="./css/tabulator.css" rel="stylesheet">
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">


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
					<i class="file alternate outline icon"></i>
					<div class="content">계절별 수요 모니터링</div>
				</h2>

				<div class="ui divider"></div>

				<div class="ui red message" id="errorMessage">
					
				</div>

				<div class="ui segment" id="viewSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="chart line icon"></i>
							상품 선택
						</div>
					</h4>
					
					<div class="ui middle aligned divided list">
						<div class="ui grid">
							<div class="row">
								<div class="five wide column">
	      							<div class="ui fluid icon input">
								  		<input type="text" name="itemID" id="itemIDInput" placeholder="상품 번호" onChange="onChangeListener();" disabled>
								  		<i class="inverted circular link search icon"  id="itemSearchButton"></i>
									</div>
								</div>
								
								<div class="five wide column">
	      							<div class="ui fluid input">
								  		<input type="text" name="itemName" id="itemNameInput" placeholder="상품 이름" onChange="onChangeListener();" disabled>
									</div>
								</div>
								
								<div class="six wide column">
									<div class="ui blue fluid button disabled" id="searchButton">
									<i class="search icon"></i> 검색
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="ui divider"></div>
				
				<div class="ui segment disabled" id="forecastSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="chart line icon"></i>
							예측 데이터
						</div>
					</h4>
				
					<div>
						<canvas id="forecastChart" style="height:30vh; width:50vw"></canvas>
					</div>
					
				</div>
				
				<div class="ui divider"></div>
				
				<div class="ui segment disabled" id="statSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="chart line icon"></i>
							과거 데이터
						</div>
					</h4>
				
					<div>
						<canvas id="statSumChart" style="height:30vh; width:50vw"></canvas>
					</div>
					
					<br />
					<div class="ui divider"></div>
					<br />
					
					<div>
						<canvas id="statAvgChart" style="height:30vh; width:50vw"></canvas>
					</div>
					
				</div>
				
			</div>
			
			<br/>
			<br/>
		</div>

		

		<div class="ui modal" id="itemSearchModal">
			<div class="header">
				상품 선택
  			</div>
  			
  			<div class="content">
				<div class="ui grid">
					<div class="row">
						<div class="four wide left aligned column">
							<div class="ui form">
								<div class="field">
					  				<div class="ui icon input">
								  		<input type="text" name="search" id="searchItemInput" placeholder="상품 이름">
								  		<i class="inverted circular search link icon" id="searchItemButton"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="twelve wide right aligned column">
						</div>
					</div>
				</div>
				<table class="ui selectable celled table" id="itemTable">
					
				</table>
    		</div>
  		
	  		<div class="actions">
	    		<div class="ui black deny button" id="modalCancelButton">
	      			취소
	    		</div>
	    	
		    	<div class="ui positive labeled icon button" id="modalConfirmButton">
		      		확인
		      		<i class="checkmark icon"></i>
		    	</div>
	  		</div>
		</div>

		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>

	<script type="text/javascript" src="./js/tabulator.js"></script>
	<script type="text/javascript" src="./js/moment-with-locales.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-csv/0.8.3/jquery.csv.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
	
	
	<script>
		shopID = <%= shopID %>;
		
		var forecastContext = document.getElementById('forecastChart').getContext('2d');
		var statSumContext = document.getElementById('statSumChart').getContext('2d');
		var statAvgContext = document.getElementById('statAvgChart').getContext('2d');
		
		var errorMessage = $('#errorMessage');
		
		var forecastChart = null;
		var statSumChart = null;
		var statAvgChart = null;
		
		var forecastChartConfig = {
				type: 'line',
				data: {
					labels: [],
					datasets: []
				},
				options: {
					maintainAspectRatio: false,
					title: {
						text: '판매량 예측'
					},
					scales: {
						yAxes: [{
							scaleLabel: {
								display: true,
								labelString: '판매량'
							}
						}],
						xAxes: [{
							scaleLabel: {
								display: true,
								labelString: '날짜'
							}
						}]
					},
				}
			};
		
		var statSumChartConfig = {
				type: 'line',
				data: {
					labels: [],
					datasets: []
				},
				options: {
					maintainAspectRatio: false,
					title: {
						text: '판매량 합계'
					},
					scales: {
						yAxes: [{
							scaleLabel: {
								display: true,
								labelString: '판매량'
							}
						}],
						xAxes: [{
							scaleLabel: {
								display: true,
								labelString: '날짜'
							}
						}]
					},
				}
			};
		
		var statAvgChartConfig = {
				type: 'line',
				data: {
					labels: [],
					datasets: []
				},
				options: {
					maintainAspectRatio: false,
					title: {
						text: '판매량 평균'
					},
					scales: {
						yAxes: [{
							scaleLabel: {
								display: true,
								labelString: '판매량'
							}
						}],
						xAxes: [{
							scaleLabel: {
								display: true,
								labelString: '날짜'
							}
						}]
					},
				}
			};
		
		var forecastSegment = $('#forecastSegment');
		var statSegment = $('#statSegment');
		
		var itemTable = null;
		var search = '';
		var itemID = -1;
		
		var cancelButton = $('#modalCancelButton');
		var confirmButton = $('#modalConfirmButton');
		var searchItemButton = $('#searchItemButton');
		
		var searchItemInput = $('#searchItemInput');
		var itemIDInput = $('#itemIDInput');
		var itemNameInput = $('#itemNameInput');
		
		var isItemSelected = false;
		var selectedItemTableRowId = -1;
		
		var searchButton = $('#searchButton');
		var itemSearchButton = $('#itemSearchButton');
		
		itemSearchModal = $('#itemSearchModal');
			
		$(document).ready(function() {
			init();
			
			errorMessage.hide();
			
			setListener();
		});
	
		function init() {
			forecastChart = new Chart(forecastContext, forecastChartConfig);
			
			statSumChart = new Chart(statSumContext, statSumChartConfig);
			statAvgChart = new Chart(statAvgContext, statAvgChartConfig);
		}
		
		function setListener() {
			searchButton.click(searchButtonListener);
			itemSearchButton.click(itemSearchButtonListener);
		}
		
		function searchButtonListener() {
			searchButton.addClass('loading');
			searchButton.addClass('disabled');
			itemSearchButton.removeClass('link');
			
			forecastSegment.addClass('disabled');
			statSegment.addClass('disabled');
			
			searchData();
		}
		
		function itemSearchButtonListener() {
			initModal();
		}
		
		function loadState() {
			
		}
		
		function searchData() {
			resetChart();
			forecastSearch();
		}
		
		function forecastSearch() {
			
			errorMessage.hide();
			itemID = itemIDInput.val();
			
			$.ajax({
				url: 'monitoringSeasonalForecastSearch.do',
				type: 'post',
				data : {
					shopID: shopID,
					itemID: itemID
				},
				success: function(data) {
					if(data == "") {
						errorMessage.show();
						errorMessage.html('해당결과가 존재하지 않습니다.');
						return;
					}

					jsonData = JSON.parse(data);
					
					updateForecastChart(jsonData.result);
					
					forecastSegment.removeClass('disabled');
				},
				error: function(xtr, status, error) {
					errorMessage.show();
					errorMessage.html('에러 발생');
				},
				complete: function(data) {
					searchButton.removeClass('loading');
					itemSearchButton.addClass('link');
					searchButton.removeClass('disabled');
					
					statSearch();
				}
			});
		}
		
		function statSearch() {
			itemID = itemIDInput.val();
			
			$.ajax({
				url: 'monitoringItemStatSearch.do',
				type: 'post',
				data : {
					shopID: shopID,
					itemID: itemID
				},
				success: function(data) {
					if(data == "") {
						errorMessage.show();
						errorMessage.html('해당결과가 존재하지 않습니다.');
						return;
					}

					jsonData = JSON.parse(data);
					
					updateStatChart(jsonData.result);
					
					statSegment.removeClass('disabled');
					
				},
				error: function(xtr, status, error) {
					alert('error');
				},
				complete: function(data) {
					searchButton.removeClass('loading');
					itemSearchButton.addClass('link');
					searchButton.removeClass('disabled');
				}
			});
		}
		
		function resetChart() {
			var labels = [];
			var datasets = [];
			
			forecastChartConfig.data.datasets = datasets;
			forecastChartConfig.data.labels = labels;
			
			forecastChart.update();
			
			statSumChartConfig.data.datasets = datasets;
			statSumChartConfig.data.labels = labels;
			
			statSumChart.update();
			
			statAvgChartConfig.data.datasets = datasets;
			statAvgChartConfig.data.labels = labels;
			
			statAvgChart.update();
		}
		
		function updateForecastChart(result) {
			
			var labels = [];
			datasets = [{
				label : '판매량',
				backgroundColor: 'rgba(75, 192, 192, 1)',
				borderColor: 'rgba(75, 192, 192, 1)',
				fill: false,
				data: []
			}];
			
			for(i=0; i<result.length; i++) {
				labels.push(result[i].saleDate);
				datasets[0].data.push(result[i].saleCount);
			}
			
			forecastChartConfig.data.datasets = datasets;
			forecastChartConfig.data.labels = labels;
			
			forecastChart.update();
		}
		
		function updateStatChart(result) {
			updateStatSumChart(result);
		}
		
		function updateStatSumChart(result) {
			var labels = [];
			datasets = [{
				label : '합계',
				backgroundColor: 'rgba(255, 99, 132, 1)',
				borderColor: 'rgba(255, 99, 132, 1)',
				fill: false,
				data: []
			}];
			
			for(i=0; i<result.length; i++) {
				labels.push(result[i].statDate);
				datasets[0].data.push(result[i].sum);
			}
			
			statSumChartConfig.data.datasets = datasets;
			statSumChartConfig.data.labels = labels;
			
			statSumChart.update();
			
			updateStatAvgChart(result);
		}
		
		function updateStatAvgChart(result) {
			var labels = [];
			datasets = [{
				label : '평균',
				backgroundColor: 'rgba(255, 99, 132, 1)',
				borderColor: 'rgba(255, 99, 132, 1)',
				fill: false,
				data: []
			}];
			
			for(i=0; i<result.length; i++) {
				labels.push(result[i].statDate);
				datasets[0].data.push(result[i].avg);
			}
			
			statAvgChartConfig.data.datasets = datasets;
			statAvgChartConfig.data.labels = labels;
			
			statAvgChart.update();
		}
		
		// Modal 창 js 부분
		
		var itemTable = null;
		
		var cancelButton = $('#modalCancelButton');
		var confirmButton = $('#modalConfirmButton');
		var searchItemButton = $('#searchItemButton');
		
		var searchItemInput = $('#searchItemInput');
		
		
		var isItemSelected = false;
		var selectedItemTableRowId = -1;
		
		function initModal() {
			itemSearchModal.modal('show');
			
			confirmButton.addClass('disabled');
			
			initializeItemTable();

			setModalListener();
		}
		
		function initializeItemTable() {
			itemTable = new Tabulator("#itemTable", {
			 	height:205,
			 	layout:"fitColumns",
			 	columns:[
			 		{title:"상품 번호", field:"itemID"},
				 	{title:"상품 이름", field:"itemName"}
			 	],
			 	
			 	rowClick:function(e, row){
			 		itemTableRowClickListener(e, row);
			 	},
			});
		 	
		 	search = searchItemInput.val();
		 	
		 	loadItemTableData(search);
		}
		
		function setModalListener() {
			confirmButton.click(confirmButtonListener);
			searchItemButton.click(searchItemButtonListener);
		}
		
		function searchItemButtonListener() {
			search = searchItemInput.val();
			
			loadItemTableData(search);
		}
		
		function loadItemTableData(itemName) {
			
			$.ajax({
				url: "itemSearchAction.do",
				type: "POST",
				data : {
					shopID: encodeURIComponent(shopID),
					itemID: encodeURIComponent(itemID),
					itemName: encodeURIComponent(itemName)
				},
				success: function(data) {
					
					if(data == "") {
						alert("해당 결과가 존재하지 않습니다.");
						return;
					}
					
					var jsonData = JSON.parse(data);
					var result = jsonData.result;
					
					itemTable.setData(result);
					
				},
				complete: function(data) {
				}
			});
			
			
		}
		
		function itemTableRowClickListener(e, row) {
			itemTable.deselectRow();
			itemTable.selectRow(row.getData().id);
	 		
			confirmButton.removeClass('disabled');
			
			selectedItemID = row.getData().itemID;
			selectedItemName = row.getData().itemName;
	 		selectedItemTableRowId = row.getData().id;
	 		isItemSelected = true;
		}
		
		function confirmButtonListener() {
			itemIDInput.val(selectedItemID);
			itemNameInput.val(selectedItemName);
			searchButton.removeClass('disabled');
		}
	</script>
</body>
</html>