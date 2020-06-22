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
								<div class="ten wide column">
	      							<div class="ui fluid icon input">
								  		<input type="text" name="itemID" id="itemIDInput" placeholder="상품 번호" onChange="onChangeListener();" disabled>
								  		<i class="inverted circular link search icon"  id="itemSearchButton"></i>
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
					
					<table class="ui celled striped table">
  						<tbody>
   							<tr>
      							<td>
        							<span>
	        							<i class="circle icon"></i>
        							</span><p id="stateText">처리 중</p>
      							</td>
      							
      							<td>상품번호 : 3번</td>
      							<td class="right floated collapsing">2020-06-20에 요청함</td>
    						</tr>
  						</tbody>
					</table>
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
		
		var cancelButton = $('#modalCancelButton');
		var confirmButton = $('#modalConfirmButton');
		var searchItemButton = $('#searchItemButton');
		
		var searchItemInput = $('#searchItemInput');
		var itemIDInput = $('#itemIDInput');
		
		
		var isItemSelected = false;
		var selectedItemTableRowId = -1;
		
		requestButton = $('#requestButton');
		itemSearchButton = $('#itemSearchButton');
		
		itemSearchModal = $('#itemSearchModal');
			
		$(document).ready(function() {
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
			
			$.ajax({
				url: 'http://localhost:12038/process',
				type: 'post',
				data : {
					shopID: shopID
				},
				success: function(data) {
					if(data == "") {
						alert("해당 결과가 존재하지 않습니다.");
						return;
					}

					var shopID = data.result;
					
					alert(result);
					
				},
				error: function(xtr, status, error) {
					alert('error');
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
			requestButton.removeClass('disabled');
		}
	</script>
</body>
</html>