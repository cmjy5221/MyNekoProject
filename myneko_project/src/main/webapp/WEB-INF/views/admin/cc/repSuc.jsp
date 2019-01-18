<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body oncontextmenu="return false">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		var code = "<c:out value='${code}' />";
		if (code == 0) {
			alert("답변등록 실패! 다시 시도해주세요");
			location.href="/admin/qna/qnaReplyRegForm.do?i_number=${i_number}";
		} else if (code == 1) {
			alert("답변등록 성공!");
			$("#form").attr({
				"method" : "get",
				"action" : "/admin/qna/getQnaDetail.do"
			});
			$("#form").submit();
		}
	});
</script>
<form id="form" name="form">
	<input type="hidden" id="i_number" name="i_number" value="${ i_number }" />
</form>
</body>
</html>