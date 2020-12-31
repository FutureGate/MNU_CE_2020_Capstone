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
<title>수요 모니터링 시스템 - 대시보드</title>
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
					<div class="content">대시보드</div>
				</h2>

				<div class="ui divider"></div>

				<div class="ui red message" id="errorMessage">
					
				</div>
				<div class="ui segment" id="viewSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="chart line icon"></i>
							데이터 처리 요청
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
									<div class="ui blue fluid button disabled" id="requestButton">
									<i class="check icon"></i> 요청
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="ui divider"></div>
				
				<div class="ui segment" id="viewSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="database icon"></i>
							데이터 처리 상태
						</div>
					</h4>
					
					<div class="ui floating message">
						<div style="display: inline;">
       						<i class="circle icon" id="requestStateIcon"></i> <div id="requestStateCell"></div>
      					</div>
      					
      					<br/>
    							
    					<div class="">
				        	<span id="requestItemIDCell"></span>
				      	</div>
				      	
				      	<div class="">
				        	<span id="requestItemNameCell"></span>
				      	</div>
				      	
				      	<br />
				      	
				      	<div class="">
				        	<span id="requestDateCell"></span>
				      	</div>
					</div>
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
		shopID = <%= shopID %>;
		
		var itemTable = null;
		var search = '';
		var itemID = -1;
		
		var isProcessing = false;
		
		var cancelButton = $('#modalCancelButton');
		var confirmButton = $('#modalConfirmButton');
		var searchItemButton = $('#searchItemButton');
		
		var searchItemInput = $('#searchItemInput');
		var itemIDInput = $('#itemIDInput');
		var itemNameInput = $('#itemNameInput');
		
		var errorMessage = $('#errorMessage');
		
		var isItemSelected = false;
		var selectedItemTableRowId = -1;
		
		var requestButton = $('#requestButton');
		
		var itemSearchButton = $('#itemSearchButton');
		var itemSearchModal = $('#itemSearchModal');
			
		$(document).ready(function() {
			tick();
			
			setInterval(tick, 1000);
			
			errorMessage.hide();
			
			setListener();
		});
	
		function setListener() {
			requestButton.click(requestButtonListener);
			itemSearchButton.click(itemSearchButtonListener);
		}
		
		function requestButtonListener() {
			requestButton.addClass('loading');
			itemSearchButton.removeClass('link');
			
			request();
		}
		
		function itemSearchButtonListener() {
			initModal();
		}
		
		function loadState() {
			
		}
		
		function request() {
			errorMessage.hide();
			itemID = itemIDInput.val();
			
			$.ajax({
				url: 'http://localhost:12038/process',
				type: 'post',
				data : {
					shopID: shopID,
					itemID: itemID
				},
				success: function(data) {
					if(data == "") {
						return;
					}
				},
				error: function(req, status, error) {
					if(req.status == 577 ) {
						errorMessage.show();
						errorMessage.html('정보가 이미 최신입니다.');
					} else if(req.status == 578) {
						errorMessage.show();
						errorMessage.html('최소 14개 이상의 판매 이력이 필요합니다.');
					} else if(req.status == 576) {
						errorMessage.show();
						errorMessage.html('최근 처리된 데이터 이후로 최소 1개이상의 추가된 데이터가 필요합니다.');
					}
					
				},
				complete: function(data) {
				}
			});
			
		}
		
		// Modal 창 js 부분
		
		var itemTable = null;
		
		var cancelButton = $('#modalCancelButton');
		var confirmButton = $('#modalConfirmButton');
		var searchItemButton = $('#searchItemButton');
		
		var searchItemInput = $('#searchItemInput');
		
		var requestDateCell = $('#requestDateCell');
		var requestItemIDCell = $('#requestItemIDCell');
		var requestStateCell = $('#requestStateCell');
		var requestStateIcon = $('#requestStateIcon');
		var requestItemNameCell = $('#requestItemNameCell');
		
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
			requestButton.removeClass('disabled');
		}
		
		function tick() {
			$.ajax({
				url: "dashboardRequestSearch.do",
				type: "POST",
				data : {
					shopID: shopID,
				},
				success: function(data) {
					if(data == "") {
						requestStateIcon.removeClass('green');
						requestStateIcon.removeClass('red');
						requestStateIcon.removeClass('black');
						
						requestStateIcon.addClass('black');
						
						requestDateCell.html('요청일 : -');
						requestItemIDCell.html('상품 번호 : -');
						
						requestStateCell.html('상태 : -');
						requestItemNameCell.html('상품 이름 : -');
						
						setFormState(true);
						
						return;
					}
					
					var jsonData = JSON.parse(data);
					var result = jsonData.result[0];
					
					requestDateCell.html('요청일 : ' + result.requestDate);
					requestItemIDCell.html('상품 번호 : ' + result.itemID);
					
					requestStateCell.html('상태 : ' + result.state);
					requestItemNameCell.html('상품 이름 : ' + result.itemName);
					
					state = result.state;
					
					requestStateIcon.removeClass('green');
					requestStateIcon.removeClass('red');
					requestStateIcon.removeClass('black');
					
					if(state == '처리 중') {
						isProcessing = true;
						
						setRequestButtonState(false);
						requestStateIcon.addClass('green');
						
						setFormState(false);
					} else if(state == '오류 발생'){
						isProcessing = false;
						requestStateIcon.addClass('red');
						
						setFormState(true);
					} else if(state == '완료') {
						
						if(isProcessing) {
							setRequestButtonState(true);
						}
						
						isProcessing = false;
						requestStateIcon.addClass('black');
						
						setFormState(true);
						
					}
						
				},
				complete: function(data) {
				}
			});
		}
		
		function setFormState(state) {
			requestButton.removeClass('loading');
			
			if(state == false) {
				itemSearchButton.removeClass('link');
				requestButton.addClass('disabled');
				
			} else if(state == true) {
				itemSearchButton.addClass('link');
			}
			
		}
		
		function setRequestButtonState(state) {
			if(state == false) {
				requestButton.addClass('disabled');
				
			} else if(state == true) {
				requestButton.removeClass('disabled');
			}
		}
	</script>
</body>
</html>