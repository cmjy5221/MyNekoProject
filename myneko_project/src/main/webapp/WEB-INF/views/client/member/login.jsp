<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>로그인페이지</title>
<style type="text/css">
body, html {
	height: 100%;
}

.card-container.card {
	max-width: 350px;
	padding: 40px 40px;
}

.btn {
	font-weight: 700;
	height: 36px;
	-moz-user-select: none;
	-webkit-user-select: none;
	user-select: none;
	cursor: default;
}


/*
 * Card component
 */
.card {
	background-image: linear-gradient(rgb(0,0,0), rgb(555, 555, 555));
	/* just in case there no content*/
	padding: 20px 25px 30px;
	margin: 0 auto 25px;
	margin-top: 50px;
	/* shadows and rounded borders */
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	-webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}

.profile-img-card {
	width: 96px;
	height: 96px;
	margin: 0 auto 10px;
	display: block;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	border-radius: 50%;
}

/*
 * Form styles
 */
.profile-name-card {
	font-size: 16px;
	font-weight: bold;
	text-align: center;
	margin: 10px 0 0;
	min-height: 1em;
}

.reauth-email {
	display: block;
	color: #404040;
	line-height: 2;
	margin-bottom: 10px;
	font-size: 14px;
	text-align: center;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.form-signin #inputEmail, .form-signin #inputPassword {
	direction: ltr;
	height: 44px;
	font-size: 16px;
}

.form-signin input[type=email], .form-signin input[type=password],
	.form-signin input[type=text], .form-signin button {
	width: 100%;
	display: block;
	margin-bottom: 10px;
	z-index: 1;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.form-signin .form-control:focus {
	border-color: rgb(104, 145, 162);
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgb(104, 145, 162);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgb(104, 145, 162);
}

.btn.btn-signin {
	/*background-color: #4d90fe; */
	background-color: rgb(104, 145, 162);
	/* background-color: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/
	padding: 0px;
	font-weight: 700;
	font-size: 14px;
	height: 36px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: none;
	-o-transition: all 0.218s;
	-moz-transition: all 0.218s;
	-webkit-transition: all 0.218s;
	transition: all 0.218s;
}

.btn.btn-signin:hover, .btn.btn-signin:active, .btn.btn-signin:focus {
	background-color: rgb(12, 97, 33);
}	

.forgot-password {
}

.forgot-password:hover, .forgot-password:active, .forgot-password:focus
	{
	color: rgb(12, 97, 33);
}

#loginBtn{
width: 100%;
height: 50px;
background-color:#C9D5CA;
border-color: green;
border-radius: 5px;
font-size: 25px;
font-family: '굴림';
font-weight: bold;
}

</style>
</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<body>
	<div>
		<div class="card card-container">
			<img id="profile-img" class="profile-img-card"
				src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
			<p id="profile-name" class="profile-name-card"></p>
			<form class="form-signin" action="/member/login" method="post">
				<span id="reauth-email" class="reauth-email"></span> <input
					type="text" id="inputEmail" name="m_id" class="form-control"
					placeholder="ID" required autofocus> <input type="password"
					id="inputPassword" onkeyup="enter();" name="m_password" class="form-control"
					placeholder="Password" required>
				<div id="loginFalse"></div>
				<input type="button" id="loginBtn" 
					value="로그인">
			</form>
			<!-- /form -->
			<a href="/sendMail/id" class="forgot-password"> 아이디를 잊어버리셨나요? </a> <br>
			<a href="/sendMail/passwordemp" class="forgot-password"> 비밀번호를
				잊어버리셨나요? </a>
		</div>
		<!-- /card-container -->
	</div>
	<!-- /container -->
	<script type="text/javascript">
	$(function(){
		$("#loginBtn").on("click",function(){
			if($("#inputEmail").val() == null || $("#inputEmail").val() == "") {
				alert("아이디를 입력하세요");
				return;}
			if($("#inputPassword").val() == null || $("#inputPassword").val() == "") {
				alert("비밀번호를 입력하세요");
				return;}
			$.ajax({
				url:"/member/login",
				type:"post",
				data:{"id":$("#inputEmail").val(),
				"pass":	$("#inputPassword").val()
				},
				success:function(result){
					if(result == "정상"){
						location.href="/mdlist/allmdlist";
					}else{
						$("#loginFalse").empty().append("<p>아이디 또는 비밀번호를 다시 확인하세요.<br>등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다").css("color","red");
					}
				}
				
			});
			
		});
	});
	</script>
	<script type="text/javascript">
	function enter() {
		if(window.event.keyCode == 13){
			login();
		}
	}
	
	function login() {
		$.ajax({
			url:"/member/login",
			type:"post",
			data:{"id":$("#inputEmail").val(),
			"pass":	$("#inputPassword").val()
			},
			success:function(result){
				if(result == "정상"){
					location.href="/mdlist/allmdlist";
				}else{
				
					$("#loginFalse").empty().append("<p>아이디 또는 비밀번호를 다시 확인하세요.<br>등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다").css("color","red");
				}
			}
			
		});
	}
	</script>
</body>
</html>