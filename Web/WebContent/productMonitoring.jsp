<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수요 모니터링 시스템 - 제품 수요 모니터링</title>

<%
	UserDTO user = (UserDTO)request.getSession().getAttribute("user");

	if(user == null) {
		response.sendRedirect("login.do");
	}
%>


</head>

<body>
	<jsp:include page="./fragment/topmenu.jsp"></jsp:include>

	<div class="ui bottom attached segment pushable" id="contentBody">
		<jsp:include page="./fragment/sidebar.jsp"></jsp:include>
		
		<div class="pusher">
			<br>
			<br>
			<br>
			제품별 수요예측 모니터링
		</div>
		
		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>
	
	
</body>
</html>