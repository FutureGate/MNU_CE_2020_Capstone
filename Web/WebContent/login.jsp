<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">
body {
	background-color: #DADADA;
}

body>.grid {
	height: 100%;
}

.image {
	margin-top: -100px;
}

.column {
	max-width: 450px;
}
</style>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

<%
	String error = (String) request.getSession().getAttribute("error");

	System.out.println(error);
%>

</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<h2 class="ui image header">
				<i class="eye icon"></i>
				<div class="content">수요 모니터링 시스템</div>
			</h2>
			<form class="ui large form" action="./loginAction.do" method="post">
				<div class="ui stacked segment">
					<div class="field">
						<div class="ui left icon input">
							<i class="user icon"></i> <input type="text" name="userID"
								placeholder="아이디">
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="lock icon"></i> <input type="password" name="password"
								placeholder="비밀번호">
						</div>
					</div>
					<input type="submit" class="ui fluid large blue button" value="로그인">
				</div>

				<div class="ui error message"></div>

			</form>

			<%
				if(error != null) {
			%>
				<div class="ui red message">
					<%= error %>
					<br>
					아이디/비밀번호 분실 시 관리자에게 문의하세요.
				</div>
			
			<%
				
				request.getSession().removeAttribute("error");
			
				}
			%>
		</div>
	</div>

	<script type="text/javascript" src="./js/tabulator.js"></script>
	<script type="text/javascript" src="./js/moment-with-locales.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							$('.ui.form')
									.form(
											{
												fields : {
													email : {
														identifier : 'email',
														rules : [
																{
																	type : 'empty',
																	prompt : 'Please enter your e-mail'
																},
																{
																	type : 'email',
																	prompt : 'Please enter a valid e-mail'
																} ]
													},
													password : {
														identifier : 'password',
														rules : [
																{
																	type : 'empty',
																	prompt : 'Please enter your password'
																},
																{
																	type : 'length[6]',
																	prompt : 'Your password must be at least 6 characters'
																} ]
													}
												}
											});
						});
	</script>
</body>
</html>