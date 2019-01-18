<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

</head>
<body>
	<div class="jumbotron">
		<img src="/resources/include/images/joinsuccess.jpg" width="700px"
			height="500px"><br>
		 <h1 class="display-3">회원님의 가입을 축하합니다!</h1>
		  <p class="lead">하단 로그인 창을 이용하여 로그인 해 주세요</p>
	</div>
	<div>
		<jsp:include page="login.jsp" />
	</div>
</body>
</html>