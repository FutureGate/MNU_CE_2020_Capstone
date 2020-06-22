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
					<i class="file alternate outline icon"></i>
					<div class="content">제품별 수요 모니터링</div>
				</h2>

				<div class="ui divider"></div>

				<div class="ui segment" id="viewSegment">
					<div class="ui grid" id="grid">
						<div class="four wide column">
							<div class="ui card">
  								<div class="content">
    								<div class="left floated">사과잼</div>
  								</div>
  								
  								<div class="content">
    								<span class="right floated">
      								<i class="chart line icon"></i>
      									2 % 상승
    								</span>
							  	</div>
							  	
							  	<div class="extra content">
						      		<div class="ui vertical animated fluid blue button" tabindex="0">
								  		<div class="visible content">자세히 보기</div>
								  		<div class="hidden content">
								    		상품페이지로 이동
								  		</div>
									</div>
							  	</div>
							</div>
						</div>

						<div class="four wide column">
							<div class="ui card">
  								<div class="content">
    								<div class="left floated">딸기잼</div>
  								</div>
  								
  								<div class="content">
    								<span class="right floated">
      								<i class="chart line icon"></i>
      									7 % 상승
    								</span>
							  	</div>
							  	
							  	<div class="extra content">
						      		<a class="ui vertical animated fluid blue button" tabindex="0" href="./productView.do">
								  		<div class="visible content">자세히 보기</div>
								  		<div class="hidden content">
								    		상품페이지로 이동
								  		</div>
									</a>
							  	</div>
							</div>
						</div>
						
						<div class="four wide column">
							<div class="ui card">
  								<div class="content">
    								<div class="left floated">무화과 잼</div>
  								</div>
  								
  								<div class="content">
    								<span class="right floated">
      								<i class="chart line icon"></i>
      									0 % 상승
    								</span>
							  	</div>
							  	
							  	<div class="extra content">
						      		<div class="ui vertical animated fluid blue button" tabindex="0">
								  		<div class="visible content">자세히 보기</div>
								  		<div class="hidden content">
								    		상품페이지로 이동
								  		</div>
									</div>
							  	</div>
							</div>
						</div>
						
						<div class="four wide column">
							<div class="ui card">
  								<div class="content">
    								<div class="left floated">건미역</div>
  								</div>
  								
  								<div class="content">
    								<span class="right floated">
      								<i class="chart line icon"></i>
      									2 % 상승
    								</span>
							  	</div>
							  	
							  	<div class="extra content">
						      		<div class="ui vertical animated fluid blue button" tabindex="0">
								  		<div class="visible content">자세히 보기</div>
								  		<div class="hidden content">
								    		상품페이지로 이동
								  		</div>
									</div>
							  	</div>
							</div>
						</div>
						
						<div class="four wide column">
							<div class="ui card">
  								<div class="content">
    								<div class="left floated">건바나나</div>
  								</div>
  								
  								<div class="content">
    								<span class="right floated">
      								<i class="chart line icon"></i>
      									4 % 하락
    								</span>
							  	</div>
							  	
							  	<div class="extra content">
						      		<div class="ui vertical animated fluid blue button" tabindex="0">
								  		<div class="visible content">자세히 보기</div>
								  		<div class="hidden content">
								    		상품페이지로 이동
								  		</div>
									</div>
							  	</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>


</body>
</html>