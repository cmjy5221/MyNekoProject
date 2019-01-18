<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		var code = "<c:out value='${code}' />";
		if (code == 1 || code == "1") {
			location.href="/boast/boardList.do";
		} else {
			location.href="/boast/writeBoast.do";
		}
	});
</script>
</body>
</html>