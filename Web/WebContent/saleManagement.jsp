<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%
		String userID = "admin";
	
	
	%>
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
				
				<h3 class="ui header left aligned">
					<div class="content">
						<i class="building outline icon"></i>
						(주) 리우팩
					</div>
				</h3>
				
				
				<div class ="ui segment" id="viewSegment">
					<div class="ui grid">
						<div class="row">
							<div class="four wide left aligned column">
								<div class="ui form">
									<div class="field">
						  				<div class="ui icon input">
									  		<input type="text" name="search" id="searchInput" placeholder="상품코드">
									  		<i class="inverted circular search link icon" id="searchButton"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="twelve wide right aligned column">
								<div class="ui small basic icon buttons">
							  		<button class="ui button disabled" id="addButton"><i class="plus icon"></i></button>
							 		<button class="ui button disabled" id="deleteButton"><i class="minus icon"></i></button>
								</div>
							</div>
						</div>
					</div>
					<table class="ui selectable celled table" id="saleTable">
						
					</table>
				</div>
				
				<div class="ui divider"></div>
		
				<div class="ui left aligned segment" id="inputSegment">
					<form class="ui form" id="inputForm">
						<div class="four fields">
      						<div class="field">
      							<label>판매일</label>
        						<input type="date" name="saleDate" id="saleDateInput" onChange="onChangeListener();" >
      						</div>
      						
      						<div class="field">
      							<label>상품코드</label>
       	 						<input type="text" name="prodCode" id="prodCodeInput" placeholder="상품코드" onChange="onChangeListener();" disabled>
      						</div>
      						<div class="field">
      							<label>상품명</label>
       	 						<input type="text" name="prodName" id="prodNameInput" placeholder="상품명" onChange="onChangeListener();" disabled>
      						</div>
      						<div class="field">
      							<label>판매수량</label>
       	 						<input type="number" name="saleCount" id="saleCountInput" placeholder="판매수량" onChange="onChangeListener();">
      						</div>
    					</div>
    					
    					<div class="ui divider"></div>
      					
      					<div style="text-align:right;">
      						<input type="reset" class="ui button" id="resetButton" value="취소">
     						<input type="button" class="ui blue button" id="saveButton" value="저장">
     					</div>
					</form>
				</div>
			</div>
		</div>
		
		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>


	<script type="text/javascript" src="./js/tabulator.js"></script>
	<script type="text/javascript" src="./js/moment-with-locales.js"></script>
	<script>
		var userID = '<%= userID %>';
		var search = '';
	
		viewSegment = $('#viewSegment');
		inputSegment = $('#inputSegment');
		
		addButton = $('#addButton');
		deleteButton = $('#deleteButton');
		saveButton = $('#saveButton');
		resetButton = $('#resetButton');
		searchButton = $('#searchButton');
		
		saleDateInput = $('#saleDateInput');
		prodCodeInput = $('#prodCodeInput');
		prodNameInput = $('#prodNameInput');
		saleCountInput = $('#saleCountInput');
		searchInput = $('#searchInput');
		
		viewSegment = $('#viewSegment');
		
		inputForm = $('#inputForm')[0];
		
		table = null;
		
		var isSelected = false;
		var isEditing = false;
		var selectedRowId = -1;
		
		var prodCode = '';
		var prodName = '';
		
		$(document).ready(function() {
		 	initialize();
		});
		
		function initialize() {
			setInputState(false);
			setListener();
			
			initializeTable();
		}
		
		function initializeTable() {
		 	table = new Tabulator("#saleTable", {
			 	height:205,
			 	layout:"fitColumns",
			 	columns:[
			 		{title:"판매번호", field:"saleID"},
				 	{title:"판매일", field:"saleDate", sorter:"date"},
				 	{title:"상품코드", field:"prodCode"},
				 	{title:"상품명", field:"prodName"},
				 	{title:"판매수량", field:"saleCount"},
			 	],
			 	
			 	rowClick:function(e, row){
			 		tableRowClickListener(e, row);
			 	},
			});
		}
		
		function setListener() {
			addButton.click(addButtonListener);
			deleteButton.click(deleteButtonListener);
			saveButton.click(saveButtonListener);
			resetButton.click(resetButtonListener);
			searchButton.click(searchButtonListener);
		}
		
		function setLoading(state) {
			if(state == true) {
				viewSegment.addClass('loading');
			} else {
				viewSegment.removeClass('loading');
			}
		}
		
		function setInputState(state) {
			if(state == true) {
				inputSegment.removeClass('disabled');
				saleDateInput.attr('disabled', false);
				saleCountInput.attr('disabled', false);
				resetButton.removeClass('disabled');
				saveButton.removeClass('disabled');
			} else {
				resetInput();
				
				inputSegment.addClass('disabled');
				saleDateInput.attr('disabled', true);
				saleCountInput.attr('disabled', true);
				resetButton.addClass('disabled');
				saveButton.addClass('disabled');
			}
		}
		
		function tableRowClickListener(e, row) {
			isSave = false;
			
			if(isEditing == true) {
				isSave = showEditConfirm();
				
				if(isSave == true) {
					saveData();
					isEditing = false;
				}
			}
			
			table.deselectRow();
	 		table.selectRow(row.getData().id);
	 		
	 		selectedRowId = row.getData().id;
	 		isSelected = true;
	 		
	 		addButton.removeClass('disabled');
	 		deleteButton.removeClass('disabled');
	 		setInputState(true);
	 		
	 		loadInputData(row.getData());
		}
		
		function onChangeListener() {
			isEditing = true;
		}
		
		function addButtonListener() {
			setInputState(true);
			
			addButton.addClass('disabled');
			deleteButton.addClass('disabled');
			
			table.deselectRow();
			
			resetInput();
			
			prodCodeInput.val(prodCode);
			prodNameInput.val(prodName);
		}
		
		function deleteButtonListener() {
			isDelete = showDeleteConfirm();
			
			if(isDelete == true) {
				deleteData();
				
				selectedRowId = -1;
				
				setInputState(false);
				table.deselectRow();
				deleteButton.addClass('disabled');
			}
		}
		
		function saveButtonListener() {
			setInputState(false);
			saveData();
			
			addButton.removeClass('disabled');
		}
		
		function resetButtonListener() {
			setInputState(false);
			
			table.deselectRow();
			
			deleteButton.addClass('disabled');
			addButton.removeClass('disabled');
		}
		
		function searchButtonListener() {
			search = searchInput.val();
			
			addButton.addClass('disabled');
			deleteButton.addClass('disabled');
			
			resetTable();
			loadTableData(search);
		}
		
		function loadTableData(search) {
			setLoading(true);
			
			$.ajax({
				url: "saleSearchAction.do",
				type: "POST",
				data : {
					userID: encodeURIComponent(userID),
					prodCode: encodeURIComponent(search)
				},
				success: function(data) {
					if(data == "") {
						alert("해당 결과가 존재하지 않습니다.");
						return;
					}
					
					var jsonData = JSON.parse(data);
					var result = jsonData.result;
					
					table.setData(result);
					
					prodCode = result[0].prodCode;
					prodName = result[0].prodName;
					
					addButton.removeClass('disabled');
				},
				complete: function(data) {
					setLoading(false);
				}
			});
			
			
		}
		
		function loadInputData(data) {
			saleDateInput.val(data.saleDate);
			prodCodeInput.val(data.prodCode);
			prodNameInput.val(data.prodName);
			saleCountInput.val(data.saleCount);
		}
		
		function removeItem(id) {
			
		}
		
		function saveData() {
			
		}
		
		function deleteData(){
			removeItem(selectedRowId);
		}
		
		function resetTable() {
			table.clearData();
			table.deselectRow();
			table.clearSort();
		}
		
		function resetInput() {
			inputForm.reset();
		}
		
		function showEditConfirm() {
			return confirm("변경된 행이 있습니다. 저장하시겠습니까?");
		}
		
		function showDeleteConfirm() {
			return confirm("선택된 행을 삭제하시겠습니까?");
		}
		
	</script>
	
</body>
</html>