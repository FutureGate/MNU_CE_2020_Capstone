<%@page import="com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

<%
	UserDTO user = (UserDTO)request.getSession().getAttribute("user");
%>

</head>
<body>
	<div class="ui top inverted fixed menu">
		<a class="item" id="sidebar_toggler">
			<i class="sidebar icon"></i>
		</a>
		
		<a class="item header" href="/goHome.do">
			<span><i class="big home icon"></i> 수요 모니터링 시스템</span>
		</a>

		<div class="right menu">
			<div class="ui simple dropdown item">
				
				<% if(user != null) { %>
					<%= user.getUserName() %>님 환영합니다. <i class="dropdown icon"></i>
				<% } %>
				<div class="menu">
					<a class="item" href="./userSetting.do"><i class="user icon"></i> 회원정보 수정</a>
					<div class="divider"></div>
					<a class="item" href="logoutAction.do"><i class="sign-out icon"></i> 로그아웃</a>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
	
</body>
</html>