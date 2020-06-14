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
	
	<title>수요 모니터링 시스템 - 상품정보관리</title>
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
				    	상품 정보 관리
				  	</div>
				</h2>
				
				<div class="ui divider"></div>
				
				<h3 class="ui header left aligned">
					<div class="content">
						<i class="building outline icon"></i>
						<%= shop.getShopName() %>
					</div>
				</h3>
				
				
				<div class ="ui segment" id="viewSegment">
					<div class="ui grid">
						<div class="row">
							<div class="four wide left aligned column">
								<div class="ui form">
									<div class="field">
						  				<div class="ui icon input">
									  		<input type="text" name="search" id="searchInput" placeholder="상품 이름">
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
					<table class="ui selectable celled table" id="itemTable">
						
					</table>
				</div>
				
				<div class="ui divider"></div>
		
				<div class="ui left aligned segment" id="inputSegment">
					<form class="ui form" id="inputForm">
						<div class="two fields">
      						<div class="field">
      							<label>상품 번호</label>
        						<input type="text" name="itemID" id="itemIDInput" onChange="onChangeListener();"  required="required" disabled>
      						</div>
      						
      						<div class="field">
      							<label>상품 이름</label>
       	 						<input type="text" name="itemName" id="itemNameInput" placeholder="상품 이름" onChange="onChangeListener();" disabled>
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
		var shopID = '<%= shopID %>';
		var search = '';
	
		viewSegment = $('#viewSegment');
		inputSegment = $('#inputSegment');
		
		addButton = $('#addButton');
		deleteButton = $('#deleteButton');
		saveButton = $('#saveButton');
		resetButton = $('#resetButton');
		searchButton = $('#searchButton');
		
		itemIDInput = $('#itemIDInput');
		itemNameInput = $('#itemNameInput');
		
		searchInput = $('#searchInput');
		
		viewSegment = $('#viewSegment');
		
		inputForm = $('#inputForm')[0];
		
		table = null;
		
		var isSelected = false;
		var isEditing = false;
		var selectedRowId = -1;
		
		var itemID = 0;
		var itemName = '';
		
		$(document).ready(function() {
		 	initialize();
		});
		
		function initialize() {
			setInputState(false);
			setListener();
			
			scrollDisable();
			initializeTable();
		}
		
		function initializeTable() {
		 	table = new Tabulator("#itemTable", {
			 	height:205,
			 	layout:"fitColumns",
			 	columns:[
			 		{title:"상품 번호", field:"itemID"},
				 	{title:"상품 이름", field:"itemName"}
			 	],
			 	
			 	rowClick:function(e, row){
			 		tableRowClickListener(e, row);
			 	},
			});
		 	
		 	search = searchInput.val();
		 	
		 	loadTableData(search);
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
				itemNameInput.attr('disabled', false);
				resetButton.removeClass('disabled');
				saveButton.removeClass('disabled');
			} else {
				resetInput();
				
				inputSegment.addClass('disabled');
				itemNameInput.attr('disabled', true);
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
	 		
	 		itemID = row.getData().itemID;
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
			itemID = 0;
			
			itemIDInput.val(itemID);
			itemNameInput.val(itemName);
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
			setInputState(false);
			
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
			
			setInputState(false);
			
			isEditing = false;
			
			resetInput();
			resetTable();
			loadTableData(search);
		}
		
		function loadTableData(itemName) {
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
			itemIDInput.val(data.itemID);
			itemNameInput.val(data.itemName);
		}
		
		function removeItem(id) {
			table.deleteRow(id);
			table.deselectRow();
		}
		
		function saveData() {
			
			var itemID = itemIDInput.val();
			var itemName = itemNameInput.val();
			
			setLoading(false);
			
			$.ajax({
				url: "itemSaveAction.do",
				type: "POST",
				data : {
					itemID : encodeURIComponent(itemID),
					itemName: encodeURIComponent(itemName),
					shopID: encodeURIComponent(shopID)
				},
				success: function(data) {
					search = searchInput.val();
					
					loadTableData(search);
					
					isEditing = false;
					isSelected = false;
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("저장에 실패하였습니다.");
				},
				complete: function(data) {
					
				}
			});
		}
		
		function deleteData(){
			setLoading(true);			
			
			$.ajax({
				url: "itemDeleteAction.do",
				type: "POST",
				data : {
					itemID : encodeURIComponent(itemID),
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
			itemID = 0;
			isSelected = false;
			table.clearData();
			table.deselectRow();
			table.clearSort();
		}
		
		function resetInput() {
			
			isEditing = false;
			itemID = 0;
			inputForm.reset();
		}
		
		function showEditConfirm() {
			return confirm("변경된 행이 있습니다. 저장하시겠습니까?");
		}
		
		function showDeleteConfirm() {
			return confirm("선택된 행을 삭제하시겠습니까?");
		}
		
		function scrollDisable(){
			$('html').addClass('no-scroll').on('scroll touchmove mousewheel', function(e){
		        //e.preventDefault();
		    });
		    $('html, body').addClass('no-scroll');
		}
		
	</script>
	
</body>
</html>