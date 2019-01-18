<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<title></title>
<style type="text/css">
#wapper {
	width: 100%;
}

#wapper #accountPw {
	width: 300px;
	margin: auto;
}
</style>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<div id="wapper">
		<div id="accountPw">
			<div><strong>비밀번호찾기</strong></div>
			<div>회원가입 시 입력하신 이메일로 인증메일을 발송합니다.</div>
			<div>
				<form>
				<div class="form-group">
					<c:choose>
						<c:when test="${ not empty m_id }">
							<input type="text"  class="form-control" id="m_id" name="m_id" placeholder="아이디" value="${ m_id }" readonly>
						</c:when>
						<c:otherwise>
							<input type="text"  class="form-control" id="m_id" name="m_id" placeholder="아이디">
						</c:otherwise>
					</c:choose>
				</div>
					<br> <div class="form-group"><input  class="form-control" type="email" id="m_email" name="m_email"
						placeholder="회원가입 시 입력 한 E-mail"></div><br>
					<input type="button" id="sendEmail" class="btn btn-default btn-lg btn-block" value="이메일 발송">
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#sendEmail").click(function() {
				var id = $("#m_id").val();
				var email = $("#m_email").val();
				var data = {
					"m_id" : id,
					"m_email" : email
				}
				$.ajax({
					url : "/sendMail/password",
					type : "post",
					data : data,
					success : function(data) {
						if (data == "true") {
							alert("이메일이 정상적으로 보내졌습니다 이메일을 확인하세요.");
							history.back();
						} else if (data == "false") {
							alert("인증실패 아이디와 이메일을 확인 후 다시 입력 해 주세요.");
						}
					},
					error : function() {
						alert("인증실패 아이디와 이메일을 확인 후 다시 입력 해 주세요.");
					}

				});
			});

		});
	</script>
</body>
</html>