$(document).ready(function() {
	$("#loginBtn").click(function() {
		if ($("#m_id").val() == '') {
			alert("아이디를 입력해주세요");
		} else if ($("#m_password").val() == '') {
			alert("비밀번호를 입력해주세요");
		} else {
			$("#loginForm").attr({
				"method" : "post",
				"action" : "/member/login"
			});
			$("#loginForm").submit();
		}
	});
});