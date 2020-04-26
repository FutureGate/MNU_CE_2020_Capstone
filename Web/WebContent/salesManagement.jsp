<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수요 예측 모니터링 시스템 - 판매이력관리</title>
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
				
				<div class ="ui segment">
					<div class="ui grid">
						<div class="row">
							<div class="four wide left aligned column">
								<div class="ui form">
									<div class="field">
										<div class="ui action input">
							  				<input type="text" name="prod_code">
							  				<button class="ui blue button">
							    				조회
							  				</button>
										</div>
									</div>
								</div>
							</div>
							<div class="twelve wide right aligned column">
								<div class="ui small basic icon buttons">
							  		<button class="ui button"><i class="plus icon"></i></button>
							 		<button class="ui button"><i class="minus icon"></i></button>
								</div>
							</div>
						</div>
					</div>
					<table class="ui selectable celled table">
						<thead>
							<tr>
								<th>판매일</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>판매수량</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>2020-04-11</td>
								<td>1231321</td>
								<td>사과 잼</td>
								<td>1</td>
							</tr>
							<tr>
								<td>2020-02-02</td>
								<td>1232331</td>
								<td>딸기 잼</td>
								<td>2</td>
							</tr>
							<tr>
								<td>2021-03-01</td>
								<td>12313222221</td>
								<td>포도 잼</td>
								<td>2</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="ui divider"></div>
		
				<div class="ui left aligned segment">
					<div class="ui form">
						<div class="four fields">
      						<div class="field">
      							<label>판매일</label>
        						<input type="date" name="sale_date">
      						</div>
      						
      						<div class="field">
      							<label>상품코드</label>
       	 						<input type="text" name="prod_code" placeholder="상품코드" disabled>
      						</div>
      						<div class="field">
      							<label>상품명</label>
       	 						<input type="text" name="prod_name" placeholder="상품명" disabled>
      						</div>
      						<div class="field">
      							<label>판매수량</label>
       	 						<input type="number" name="sale_count" placeholder="판매수량">
      						</div>
    					</div>
    					
    					<div class="ui divider"></div>
      					
      					<div style="text-align:right;">
      						<input type="submit" class="ui button" value="취소">
     						<input type="submit" class="ui blue button" value="저장">
     					</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="./fragment/footer.jsp"></jsp:include>
	</div>

	
</body>
</html>