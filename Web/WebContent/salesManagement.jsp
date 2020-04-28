<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<link href="./css/tabulator.css" rel="stylesheet">
	
	<title>수요 예측 모니터링 시스템 - 판매이력관리</title>
</head>
<body>
	<jsp:include page="./fragment/topmenu.jsp"></jsp:include>

	<div class="ui bottom attached segment pushable" id="contentBody">
		<jsp:include page="./fragment/sidebar.jsp"></jsp:include>

		<div class="pusher">
			<div class="ui center aligned container">
				<br> <br> <br>
				
				<h2 class="ui header">
					<i class="file alternate outline icon"></i>
					<div class="content">
				    	판매 이력 관리
				  	</div>
				</h2>
				<div class="ui divider"></div>
				
				<div class ="ui segment" id="viewSegment">
					<div class="ui grid">
						<div class="row">
							<div class="four wide left aligned column">
								<div class="ui form">
									<div class="field">
										<div class="ui action input">
							  				<input type="text" name="prodCodeSearch" id="prodCodeSearchInput">
							  				<button class="ui blue button" id="prodCodeSearchButton">
							    				조회
							  				</button>
										</div>
									</div>
								</div>
							</div>
							<div class="twelve wide right aligned column">
								<div class="ui small basic icon buttons">
							  		<button class="ui button" id="addButton"><i class="plus icon"></i></button>
							 		<button class="ui button" id="deleteButton"><i class="minus icon"></i></button>
								</div>
							</div>
						</div>
					</div>
					<table class="ui selectable celled table" id="salesTable">
						
					</table>
				</div>
				
				<div class="ui divider"></div>
		
				<div class="ui left aligned segment" id="inputSegment">
					<div class="ui form" id="inputForm">
						<div class="four fields">
      						<div class="field">
      							<label>판매일</label>
        						<input type="date" name="saleDate" id="saleDateInput">
      						</div>
      						
      						<div class="field">
      							<label>상품코드</label>
       	 						<input type="text" name="prodCode" placeholder="상품코드" disabled>
      						</div>
      						<div class="field">
      							<label>상품명</label>
       	 						<input type="text" name="prodName" placeholder="상품명" disabled>
      						</div>
      						<div class="field">
      							<label>판매수량</label>
       	 						<input type="number" name="saleCount" id="saleCountInput" placeholder="판매수량">
      						</div>
    					</div>
    					
    					<div class="ui divider"></div>
      					
      					<div style="text-align:right;">
      						<input type="submit" class="ui button" id="resetButton" value="취소">
     						<input type="submit" class="ui blue button" id="saveButton" value="저장">
     					</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>


	<script type="text/javascript" src="./js/tabulator.js"></script>
	<script>
		viewSegment = $('#viewSegment');
		inputSegment = $('#inputSegment');
		
		addButton = $('#addButton');
		deleteButton = $('#deleteButton');
		saveButton = $('#saveButton');
		resetButton = $('#resetButton');
		
		saleDateInput = $('#saleDateInput');
		saleCountInput = $('#saleCountInput');
		
		inputForm = $('#inputForm');
		
		table = null;
		
		$(document).ready(function() {
		 	initialize();
		});
		
		function initialize() {
			setInputState(false);
			setListener();
			
			initializeTable();
			loadTableData();
			
		}
		
		function initializeTable() {
		 	table = new Tabulator("#salesTable", {
			 	height:205,
			 	layout:"fitColumns",
			 	columns:[
				 	{title:"판매일", field:"saleDate", sorter:"date"},
				 	{title:"상품코드", field:"prodCode"},
				 	{title:"상품명", field:"prodName"},
				 	{title:"판매수량", field:"saleCount"},
			 	],
			 	
			 	rowClick:function(e, row){
			 		alert("Row " + row.getData().saleDate + " Clicked!!!!");
			 	},
			});
		}
		
		function setListener() {
			addButton.click(addButtonListener);
			deleteButton.click(deleteButtonListener);
			saveButton.click(saveButtonListener);
			resetButton.click(resetButtonListener);
		}
		
		function setInputState(state) {
			if(state == true) {
				inputSegment.removeClass('disabled');
				saleDateInput.attr('disabled', false);
				saleCountInput.attr('disabled', false);
				resetButton.removeClass('disabled');
				saveButton.removeClass('disabled');
			} else {
				inputSegment.addClass('disabled');
				saleDateInput.attr('disabled', true);
				saleCountInput.attr('disabled', true);
				resetButton.addClass('disabled');
				saveButton.addClass('disabled');
			}
		}
		
		function loadTableData() {
			var tabledata = [
			 	{id:1, saleDate:"2019-04-14", prodCode:"1521", prodName:"사과잼", saleCount:"1"},
			 	{id:2, saleDate:"2019-04-14", prodCode:"1521", prodName:"사과잼", saleCount:"1"},
			 	{id:3, saleDate:"2019-04-14", prodCode:"1521", prodName:"사과잼", saleCount:"1"},
			 	{id:4, saleDate:"2019-04-14", prodCode:"1521", prodName:"사과잼", saleCount:"1"},
			 	{id:5, saleDate:"2019-04-14", prodCode:"1521", prodName:"사과잼", saleCount:"1"},
			 ];
			
			table.setData(tabledata);
		}
		
		function addButtonListener() {
			setInputState(true);
		}
		
		function deleteButtonListener() {
			setInputState(false);
		}
		
		function saveButtonListener() {
			setInputState(false);
			save();
		}
		
		function resetButtonListener() {
			setInputState(true);
			reset();
		}
		
		function addItem() {
			
		}
		
		function removeItem(id) {
			
		}
		
		function save() {
			
		}
		
		function reset() {
			inputForm.trigger('reset');
		}
		
	</script>
	
</body>
</html>