<%@page import="com.dto.ShopDTO"%>
<%@page import="com.dao.ShopDAO"%>
<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%
	UserDTO user = (UserDTO) request.getSession().getAttribute("user");
	ShopDTO shop = null;
	ShopDAO shopDAO = new ShopDAO();
	
	if(user != null) {
		shop = shopDAO.getShop(user.getShopID());
	}

	String error = (String) request.getSession().getAttribute("error");
	String message = (String) request.getSession().getAttribute("message");
%>


<meta charset="UTF-8">
<title>수요 모니터링 시스템 - 회원 정보 수정</title>

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
					<i class="user icon"></i>
					<div class="content">회원 정보</div>
				</h2>

				<div class="ui divider"></div>

				<%
					if (error != null) {
				%>
						<div class="ui red message">
							<%=error%>
						</div>
	
				<%
						request.getSession().removeAttribute("error");
	
					}
				%>
				
				<%
					if (message != null) {
				%>
						<div class="ui green message">
							<%=message%>
						</div>
	
				<%
						request.getSession().removeAttribute("message");
	
					}
				%>

				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">회원 정보 수정</div>
					</h4>
				
					<form class="ui form" action="./userSettingUserSaveAction.do" method="post">
						<div class="two fields">
      						<div class="field">
      							<label>회원 ID</label>
      							<input type="hidden" name="userID" value="<%= user.getUserID() %>" />
       	 						<input type="text" value="<%= user.getUserID() %>" disabled />
      						</div>
      						
      						<div class="field">
      							<label>닉네임</label>
       	 						<input type="text" name="userName" value="<%= user.getUserName() %>" required="required"/>
      						</div>
      						
    					</div>
    					
    					<input type="hidden" name="password" value="<%= user.getPassword() %>" />
						<input type="hidden" name="shopID" value="<%= user.getShopID() %>" />
						<input type="hidden" name="registeredDate" value="<%= user.getRegisteredDate() %>" />
						<input type="hidden" name="userLevel" value="<%= user.getUserLevel() %>" />
    					
    					
    					
    					<div style="text-align:right;">
    						<input type="submit" class="ui blue button"  value="수정"/>
    					</div>
					</form>
					
					<div class="ui divider"></div>
					
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">비밀번호 수정</div>
					</h4>
					
					<form class="ui form" action="./userSettingUserPasswordSaveAction.do" method="post">
						
    					<div class="two fields">	
									
      						<div class="field">
      							<label>비밀번호</label>
       	 						<input type="password" name="password" required="required"/>
      						</div>
      						
      						<div class="field">
      							<label>비밀번호 확인</label>
       	 						<input type="password" name="password2" required="required"/>
      						</div>
      						
    					</div>
    					
    					<input type="hidden" name="userID" value="<%= user.getUserID() %>" />
    					<input type="hidden" name="userName" value="<%= user.getUserName() %>" />
    					<input type="hidden" name="shopID" value="<%= user.getShopID() %>" />
						<input type="hidden" name="registeredDate" value="<%= user.getRegisteredDate() %>" />
						<input type="hidden" name="userLevel" value="<%= user.getUserLevel() %>" />
    					
    					<div style="text-align:right;">
    						<input type="submit" class="ui blue button"  value="수정"/>
    					</div>
					</form>
				</div>
				
				<div class="ui segment" id="viewSegment">
					<h4 class="ui header">
						<i class="file alternate outline icon"></i>
						<div class="content">판매점 정보 수정</div>
					</h4>
					
					<form class="ui form" action="./userSettingShopSaveAction.do" method="post">
						
    					<div class="three fields">	
									
      						<div class="field">
      							<label>판매점 이름</label>
       	 						<input type="text" name="shopName" value="<%= shop.getShopName() %>"  required="required"/>
      						</div>
      						
      						<div class="field">
      							<label>연락처</label>
       	 						<input type="text" name="contact" value="<%= shop.getContact() %>"  required="required"/>
      						</div>
      						
      						<div class="field">
      							<label>이메일</label>
       	 						<input type="email" name="email" value="<%= shop.getEmail() %>" required="required"  />
      						</div>
      						
    					</div>
    					
    					<input type="hidden" name="shopID" value="<%= shop.getShopID() %>" />
    					
    					<div style="text-align:right;">
    						<input type="submit" class="ui blue button"  value="수정"/>
    					</div>
					</form>
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

	</script>
</body>
</html>