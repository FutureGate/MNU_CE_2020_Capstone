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

	%>
	<link href="./css/tabulator.css" rel="stylesheet">
	<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
	<link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
	<link href="./css/filepond-plugin-get-file.css">
	
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
				    	판매 이력 관리 (자동)
				  	</div>
				</h2>
				
				<div class="ui divider"></div>
				
				<h3 class="ui header left aligned">
					<div class="content">
						<i class="building outline icon"></i>
						<%= shop.getShopName() %>
					</div>
				</h3>
				
				<div class ="ui segment" id="fileSegment">
					
					<form id="fileForm">
						<input type="file" class="filepond" name="filepond" id="filepond" data-max-file-size="3MB" />
					</form>
				</div>
				
				<div class="ui divider"></div>
		
				<div class="ui left aligned segment" id="listSegment">
					<h4 class="ui header left aligned">
						<div class="content">
							<i class="clipboard outline icon"></i>
							엑셀 파일 양식 받기
						</div>
					</h4>
					
					<div class="ui middle aligned divided list">
					
						<div class="item middle aligned" style="text-align: center;">
							<div class="content middle aligned">
								<a class="ui blue fluid button" href="saleFormDownload.do">
									<i class="download icon"></i> 다운로드
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>

	<script src="https://unpkg.com/filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.min.js"></script>
	<script src="https://unpkg.com/filepond-plugin-file-validate-size/dist/filepond-plugin-file-validate-size.js"></script>
	<script src="https://unpkg.com/filepond-plugin-file-encode/dist/filepond-plugin-file-encode.js"></script>
	<script src="./js/filepond-plugin-get-file.js"></script>
	<!-- include FilePond library -->
	<script src="https://unpkg.com/filepond/dist/filepond.min.js"></script>
	
	<!-- include FilePond jQuery adapter -->
	<script src="https://unpkg.com/jquery-filepond/filepond.jquery.js"></script>


	<script>
		$(function() {
			$.fn.filepond.registerPlugin(
	    		FilePondPluginFileEncode,
				FilePondPluginFileValidateSize,
				FilePondPluginFileValidateType,
				FilePondPluginGetFile
			);
		});
	
		$(document).ready(function() {
			initialize();
			setListener();
		});
		
		function initialize() {
			
			$('#filepond').filepond({
				acceptedFileTypes: [
					'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
				],
				fileValidateTypeLabelExpectedTypesMap: {
					'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'xlsx'
				},
				labelIdle: '파일 끌어오기 혹은 <span class="filepond--label-action"> 찾아보기 </span>',
				labelFileTypeNotAllowed: '지원하지 않는 파일입니다.',
				fileValidateTypeLabelExpectedTypes: '파일확장자는 {allTypes} 만 허용됩니다.',
				labelFileLoading: '불러오는 중',
				labelFileWaitingForSize: '크기 계산 중',
				labelTapToCancel: 'X를 눌러 취소할 수 있습니다.',
				labelFileSizeNotAvailable: '파일크기가 너무 큽니다. (3MB 제한)',
				labelFileProcessing: '업로드 중',
				labelFileProcessingComplete: '업로드 완료',
				labelButtonDownloadItem: '다운로드',
				labelFileProcessingError: '파일이 잘못되었거나 등록되지 않은 상품 정보가 있습니다',
				labelTapToRetry: '탭하여 재시도',
				
				allowDownloadByUrl: false,
				allowRevert: false,
				
				server: {
					process: 'saleManagementUpload.do',
					fetch: null,
					revert: null
				}
			});

		    // Set allowMultiple property to true
		    $('#filepond').filepond('allowMultiple', true);
		}
		
		function setListener() {
			$('#filepond').on('FilePond:addfile', (e, file) => {
		    });
			
			$('#filepond').on('FilePond:processfile', (error, file) => {
				console.log(error.body, ',', error.code);
				console.log(error);
		    });
		}
		
	</script>
	
	
</body>
</html>