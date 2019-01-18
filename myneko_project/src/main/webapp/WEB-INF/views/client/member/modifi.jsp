<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js">
	
</script>
<script type="text/javascript">
	$(function() {

	});
</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
body {
	width: 1200px;
}

#content {
	width: 50%;
	margin: auto;
	margin-bottom: 20px;
}
</style>

</head>
<body>
	<div>
		<button onclick="withdrawal()" class="btn btn-danger">탈퇴하기</button>
	</div>
	<div id="content">
		<div>
			<div>
				<h2>회원정보</h2>
			</div>
			<div>
				<label class="control-label">아이디(변경불가)</label>
			</div>
			<div>
				<input class="form-control" id="m_id" name="m_id"
					placeholder="소문자영어+숫자 6~15자리" maxlength="15" required="required"
					min="6" value="<%=session.getAttribute("m_id")%>"
					readonly="readonly">
			</div>
		</div>
		<div>
			<div>
				<label class="control-label">이름</label>
			</div>
			<div>
				<input class="form-control" id="m_name" name="m_name" type="text"
					required="required" maxlength="10"
					value="<%=session.getAttribute("m_name")%>">
			</div>

		</div>
		<div>
			<div>
				<label class="control-label">핸드폰 번호</label>
			</div>
			<div>
				<input class="form-control" id="m_phone" name="m_phone" type="tel"
					required="required" maxlength="11"
					value="<%=session.getAttribute("m_phone")%>">
			</div>
		</div>
		<div>
			<div>
				<label class="control-label">이메일</label>
			</div>
			<div>
				<input class="form-control" id="m_email" name="m_email" type="email"
					required="required" value="<%=session.getAttribute("m_email")%>">
			</div>
		</div>
		<div>
			<div>
				<label class="control-label">우편번호</label>
				<button id="addressModifi"
					onclick="window.open('/member/addressmodifi','addressmodifi','width=500,height=300')" class="btn btn-default">주소
					변경하기</button>
			</div>
			<div>
				<input type="text" class="form-control" readonly="readonly"
					value="<%=session.getAttribute("m_postcode")%>">
			</div>
			<div>
				<label class="control-label">주소</label>
			</div>
			<div>
				<input type="text" readonly="readonly" class="form-control"
					value="<%=session.getAttribute("m_address")%>">
			</div>
		</div>
		<br>
		<div>
			<input type="button" id="joinBtn"
				class="btn btn-secondary btn-lg btn-block" value="회원정보 변경하기">
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#joinBtn").on("click", function() {
			$.ajax({
				url : "/member/modifi",
				type : "post",
				data : {
					"m_name" : $("#m_name").val(),
					"m_phone" : $("#m_phone").val(),
					"m_email" : $("#m_email").val()
				},
				success : function(result) {
					if (result == 1) {
						alert("회원정보 수정완료");
						window.location.reload();
					}
				}

			});

		});
	});
</script>
<script type="text/javascript">
	function withdrawal() {
		if (confirm("정말 탈퇴하시겠습니까? 탈퇴 시 해당 아이디로는 다시 만들 수 없습니다.")) {
			$.ajax({
				url : "/member/withdrawal",
				type : "post",
				data : {
					"m_number" :
<%=session.getAttribute("m_number")%>
	},
				success : function(result) {
					alert(result);
					if (result == 1) {
						alert("정상적으로 탈퇴처리 되었습니다.");
						location.href="/member/logout";
					}

				}

			});
		}
	}
</script>
</html>