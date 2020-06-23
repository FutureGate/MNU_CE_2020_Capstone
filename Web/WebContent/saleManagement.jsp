<%@page import="com.dto.ShopDTO"%>
<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%
		UserDTO user = (UserDTO) request.getSession().getAttribute("user");
		ShopDTO shop = (ShopDTO) request.getSession().getAttribute("shop");
		
		String userID = user.getUserID();
		int shopID = shop.getShopID();
		
	%>
	<link href="./css/tabulator.css" rel="stylesheet">
	<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
	
	<title>수요 모니터링 시스템 - 판매이력관리</title>
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
						<%= shop.getShopName() %>
					</div>
				</h3>
				
				
				<div class ="ui segment">
					<div class="ui grid">
						<div class="row">
							<div class="six wide left aligned column">
								<div class="ui form">
									<div class="field">
										<label>상품 이름</label>
									
						  				<div class="ui input">
									  		<input type="text" name="search" id="searchInput" placeholder="상품 이름">
										</div>
									</div>
								</div>
							</div>
							
							<div class="ten wide left aligned column">
								<div class="ui form">
									<div class="ui grid">
										<div class="ui row">
											<div class="ui eight wide column">
												<div class="field">
													<label>시작일</label>
												
									  				<div class="ui input">
												  		<input type="date" name="startDate" id="startDateInput" placeholder="시작일">
													</div>
												</div>
											</div>
											
											<div class="ui eight wide column">
												<div class="field">
													<label>종료일</label>
													
													<div class="ui input">
										  				<input type="date" name="endDate" id="endDateInput" placeholder="종료일">
										  			</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div style="text-align:right; margin-top:20px">
						<i class="inverted circular search link icon" id="searchButton"></i>
					</div>
				</div>
				
				<div class ="ui segment" id="viewSegment">
					<div class="ui grid">
						<div class="row">
							<div class="right aligned column">
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
        						<input type="date" name="saleDate" id="saleDateInput" onChange="onChangeListener();"  required="required">
      						</div>
      						
      						<div class="field">
      							<label>상품 번호</label>
      							
      							<div class="ui icon input disabled">
								  		<input type="text" name="itemID" id="itemIDInput" placeholder="상품 번호" onChange="onChangeListener();" disabled>
								  		<i class="inverted circular search icon"  id="itemSearchButton"></i>
								</div>
      						</div>
      						<div class="field">
      							<label>상품 이름</label>
       	 						<input type="text" name="itemName" id="itemNameInput" placeholder="상품 이름" onChange="onChangeListener();" disabled>
      						</div>
      						<div class="field">
      							<label>판매수량</label>
       	 						<input type="number" name="saleCount" id="saleCountInput" placeholder="판매수량" onChange="onChangeListener();" required="required">
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
	<script>
		var userID = '<%= userID %>';
		var shopID = '<%= shopID %>';
		var search = '';
	
		var startDate = '';
		var endDate = '';
		
		viewSegment = $('#viewSegment');
		inputSegment = $('#inputSegment');
		
		addButton = $('#addButton');
		deleteButton = $('#deleteButton');
		saveButton = $('#saveButton');
		resetButton = $('#resetButton');
		searchButton = $('#searchButton');
		itemSearchButton = $('#itemSearchButton');
		
		saleDateInput = $('#saleDateInput');
		itemIDInput = $('#itemIDInput');
		itemNameInput = $('#itemNameInput');
		saleCountInput = $('#saleCountInput');
		searchInput = $('#searchInput');
		
		startDateInput = $('#startDateInput');
		endDateInput = $('#endDateInput');
		
		viewSegment = $('#viewSegment');
		
		inputForm = $('#inputForm')[0];
		
		itemSearchModal = $('#itemSearchModal');
		
		table = null;
		
		var isSelected = false;
		var isEditing = false;
		var selectedRowId = -1;
		
		var saleID = 0;
		var itemID = 0;
		var itemName = '';
		
		var selectedItemID = 0;
		var selectedItemName = '';
		
		$(document).ready(function() {
		 	initialize();
		});
		
		function initialize() {
			endDate = new Date();
			startDate = new Date();
			startDate.setDate(endDate.getDate() - 7);
			
			startDateInput.val(toFormattedDate(startDate));
			endDateInput.val(toFormattedDate(endDate));
			
			setInputState(false);
			setListener();
			
			scrollDisable();
			initializeTable();
		}
		
		function initializeTable() {
		 	table = new Tabulator("#saleTable", {
			 	height:205,
			 	layout:"fitColumns",
			 	columns:[
			 		{title:"판매 번호", field:"saleID"},
				 	{title:"판매일", field:"saleDate", sorter:"date"},
				 	{title:"상품 번호", field:"itemID"},
				 	{title:"상품 이름", field:"itemName"},
				 	{title:"판매 수량", field:"saleCount"},
			 	],
			 	
			 	rowClick:function(e, row){
			 		tableRowClickListener(e, row);
			 	},
			});
		 	
		 	search = searchInput.val();
		 	startDate = startDateInput.val();
		 	endDate = endDateInput.val();
		 	
		 	loadTableData(search, startDate, endDate);
		}
		
		function toFormattedDate(date) {
		    var d = new Date(date),
		        month = '' + (d.getMonth() + 1),
		        day = '' + d.getDate(),
		        year = d.getFullYear();

		    if (month.length < 2) 
		        month = '0' + month;
		    if (day.length < 2) 
		        day = '0' + day;

		    return [year, month, day].join('-');
		}
		
		function setListener() {
			addButton.click(addButtonListener);
			deleteButton.click(deleteButtonListener);
			saveButton.click(saveButtonListener);
			resetButton.click(resetButtonListener);
			searchButton.click(searchButtonListener);
			itemSearchButton.click(itemSearchButtonListener);
		}
		
		function setLoading(state) {
			if(state == true) {
				searchButton.removeClass('link');
				viewSegment.addClass('loading');
			} else {
				searchButton.addClass('link');
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
				itemSearchButton.addClass('link');
			} else {
				resetInput();
				
				inputSegment.addClass('disabled');
				saleDateInput.attr('disabled', true);
				saleCountInput.attr('disabled', true);
				
				resetButton.addClass('disabled');
				saveButton.addClass('disabled');
				itemSearchButton.removeClass('link');
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
	 		
	 		saleID = row.getData().saleID;
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
			selectedItemID = 0;
			selectedItemName = '';
			
			setInputState(true);
			
			addButton.addClass('disabled');
			deleteButton.addClass('disabled');
			
			table.deselectRow();
			
			resetInput();
			saleID = 0;
		}
		
		function deleteButtonListener() {
			isDelete = showDeleteConfirm();
			
			if(isDelete == true) {
				deleteData();
				
				setInputState(false);
				table.deselectRow();
				deleteButton.addClass('disabled');
			}
		}
		
		function saveButtonListener() {
			saveData();
			
		}
		
		function resetButtonListener() {
			setInputState(false);
			
			table.deselectRow();
			
			deleteButton.addClass('disabled');
			addButton.removeClass('disabled');
		}
		
		function searchButtonListener() {
			addButton.addClass('disabled');
			deleteButton.addClass('disabled');
			
			resetTable();
			
			search = searchInput.val();
		 	startDate = startDateInput.val();
		 	endDate = endDateInput.val();
		 	
		 	loadTableData(search, startDate, endDate);
		}
		
		function itemSearchButtonListener() {
			initModal();
			
		}
		
		function loadTableData(search, startDate, endDate) {
			setLoading(true);
			
			$.ajax({
				url: "saleSearchAction.do", 
				type: "POST",
				data : {
					shopID: shopID,
					itemName: search,
					startDate: startDate,
					endDate: endDate
				},
				success: function(data) {
					if(data == "") {
						alert("해당 결과가 존재하지 않습니다.");
						return;
					}
					
					var jsonData = JSON.parse(data);
					var result = jsonData.result;
					
					table.setData(result);
					
					itemID = result[0].itemID;
					itemName = result[0].itemName;
					
					addButton.removeClass('disabled');
				},
				complete: function(data) {
					setLoading(false);
				}
			});
			
			
		}
		
		function loadInputData(data) {
			saleDateInput.val(data.saleDate);
			itemIDInput.val(data.itemID);
			itemNameInput.val(data.itemName);
			saleCountInput.val(data.saleCount);
		}
		
		function removeItem(id) {
			table.deleteRow(id);
			table.deselectRow();
		}
		
		function saveData() {
			var saleDate = saleDateInput.val();
			var saleCount = saleCountInput.val();
			var itemID = itemIDInput.val();
			
			setLoading(false);
			
			$.ajax({
				url: "saleSaveAction.do",
				type: "POST",
				data : {
					saleID : encodeURIComponent(saleID),
					saleDate: encodeURIComponent(saleDate),
					shopID: encodeURIComponent(shopID),
					itemID: encodeURIComponent(itemID),
					saleCount: encodeURIComponent(saleCount)
				},
				success: function(data) {
					search = searchInput.val();
				 	startDate = startDateInput.val();
				 	endDate = endDateInput.val();
				 	
				 	loadTableData(search, startDate, endDate);
					
					isEditing = false;
					isSelected = false;
					
					setInputState(false);
					addButton.removeClass('disabled');
				},
				error: function (req, status, error) {
					if(req.status == 566) {
						alert('정보를 모두 입력해주세요');
					}
				},
				complete: function(data) {
					
				}
			});
		}
		
		function deleteData(){
			setLoading(true);			
			
			$.ajax({
				url: "saleDeleteAction.do",
				type: "POST",
				data : {
					saleID : encodeURIComponent(saleID),
				},
				success: function(data) {
					removeItem(selectedRowId);
					isEditing = false;
					isSelected = false;
					selectedRowId = -1;
					
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("삭제에 실패하였습니다.");
				},
				complete: function(data) {
					setLoading(false);	
				}
			});
			
		}
		
		function resetTable() {
			saleID = 0;
			isSelected = false;
			
			table.clearData();
			table.deselectRow();
			table.clearSort();
		}
		
		function resetInput() {
			
			isEditing = false;
			saleID = 0;
			
			inputForm.reset();
		}
		
		function showEditConfirm() {
			return confirm("변경된 행이 있습니다. 저장하시겠습니까?");
		}
		
		function showDeleteConfirm() {
			return confirm("선택된 행을 삭제하시겠습니까?");
		}
		
		function scrollDisable(){
			
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
			
			searchItemInput.val('');
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
		
		function confirmButtonListener() {
			
		}
		
		function searchItemButtonListener() {
			search = searchItemInput.val();
			
			loadItemTableData(search);
		}
		
		function loadItemTableData(itemName) {
			setLoading(true);
			
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
					setLoading(false);
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
		}
		
	</script>
	
</body>
</html>