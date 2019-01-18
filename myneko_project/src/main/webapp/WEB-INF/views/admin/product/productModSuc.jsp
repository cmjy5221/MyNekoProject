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
		var code = "<c:out value='${ result }' />";
		if (code == 1 || code == "1") {
			alert("수정 성공!");
			location.href="/admin/product/productDetail.do?p_number=${p_number}";
		} else {
			alert("수정 실패! 잠시후에 다시 시도해주세요!");
			location.href="/admin/product/productModForm.do?p_number=${p_number}";
		}
	});
</script>
</body>
</html>