<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리 정보</title>
</head>
<body>
	<div class="table-responsive">
		<table class="table">
			<tr>
				<th class="tac">제목</th>
				<td class="tac">${ data.b_title }</td>
			</tr>
			<tr>
				<th class="tac">내용</th>
				<td class="tac"><textarea id="b_content" name="b_content" class="form-control" rows="5" cols="20">${ data.b_content }</textarea>
			</tr>
		</table>
	</div>
</body>
</html>