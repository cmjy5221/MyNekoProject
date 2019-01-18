<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/login.js"></script>
<script src="/resources/include/js/common.js"></script>
<script>
	$(document).ready(function() {
		$("#capslock").hide();
		$("#adminId").val("");
		$("#adminId").focus();
		$("#adminPw").val("");

		$("#adminLoginBtn").click(function() {
			if ($("#adminId").val() == '') {
				alert("아이디를 입력해주세요");
			} else if ($("#adminPw").val() == '') {
				alert("비밀번호를 입력해주세요");
			} else {
				var a_id = $("#adminId").val();
				var a_pw = $("#adminPw").val();
				var data = {
					"a_id" : a_id,
					"a_password" : a_pw
				};
				$.ajax({
					url : "/admin/adminLogin.do",
					type : "post",
					data : data,
					error : function() {
						alert("네트워크 에러!");
					},
					success : function(result) {
						if (result == 1) {
							alert("로그인 성공!");
							location.href = "/admin/order/getOrderList.do";
						} else {
							alert("일치하는 관리자 정보가 없습니다! 다시 시도해주세요.");
							location.reload();
						}
					}
				});
			}
		});
	});
	function fnKeyPress(e) {
		var keyCode = 0;
		var shiftKey = false;
		keyCode = e.keyCode;
		if (e.keyCode == 0) {
			keyCode = e.which;
		}
		shiftKey = e.shiftKey;

		if ((keyCode >= 65 && keyCode <= 90) && !shiftKey) {
			$("#capslock").show();
			setTimeout("hide_caps_lock()", 1500);
		}

		if ((keyCode >= 97 && keyCode <= 122) && shiftKey) {
			$("#capslock").show();
			setTimeout("hide_caps_lock()", 1500);
		}
	}
	function hide_caps_lock() {
		$("#capslock").hide();
	}
</script>
<style>
.wrapper {
	margin: 0px auto;
	margin-top: 10%;
	width: 50%;
	height: auto;
	text-align: center;
}

input[type=text] {
	width: 60%;
	height: auto;
	margin: 0px auto;
}

input[type=password] {
	width: 60%;
	height: auto;
	margin: 0px auto;
}

h2 {
	display: inline-block;
	margin-bottom: 10%;
}

#capslock {
	width: 50%;
	height: auto;
	margin: 0px auto;
	text-align: center;
}
</style>
</head>
<body oncontextmenu="return false">
	<div class="wrapper">
		<div class="contentContainer">
			<div class="well">
				<form id="adminLoginForm" class="form-horizontal">
					<img src="/resources/include/images/logo.png" />
					<div class="form-group">
						<label for="adminId" class="col-sm-2 control-label"> 아이디 </label>
						<input type="text" id="adminId" name="a_id" class="form-control"
							placeholder="ID" onkeypress="fnKeyPress(event)" />
						<p class="form-control-static error"></p>
					</div>
					<div class="form-group">
						<label for="adminPw" class="col-sm-2 control-label"> 비밀번호
						</label> <input type="password" id="adminPw" name="a_password"
							class="form-control" placeholder="Password"
							onkeypress="fnKeyPress(event)" />
						<p class="form-control-static error" id="capslock">
							<strong><font color="red">Capslock</font></strong>키가 눌려잇습니다.
						</p>
					</div>
					<div class="form-group">
						<input type="button" value="관리자로그인" id="adminLoginBtn"
							class="btn btn-info" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<nav class="navbar navbar-inverse navbar-fixed-bottom">
		<jsp:include page="../template/admin/footer.jsp" />
	</nav>
</body>
</html>