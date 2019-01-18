<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	//전체목록 보기 버튼 클릭시 상세보기 페이지로 이동
	$(document).ready(function() {
		$("#goToList").click(function() {
			location.href = "/faqboard/faqboardlist";
		});

	});
</script>
<style>
	#btnDiv {
		text-align: center;
	}
</style>
</head>
<body>
	<h2>FAQ게시물 상세보기</h2>
	<table class="table table-striped">
		<tr>
			<td>글번호</td>
			<td>${ detail.f_number }</td>
		</tr>

		<tr>
			<td>작성자</td>
			<td>ID</td>
		</tr>

		<tr>
			<td>글내용</td>
			<td>${ detail.f_content }</td>
		</tr>

		<tr>
			<td>첨부 이미지</td>
			<c:if test="${ not empty detail.f_image }">
				<td><img src="/uploadStorage/faq/${ detail.f_image }" /></td>
			</c:if>
			<c:if test="${ empty detail.f_image }">
				<td>이미지 없음</td>
			</c:if>
		</tr>

		<tr>
			<td>작성일</td>
			<td><fmt:formatDate value="${ detail.f_date }"
					pattern="yyyy/MM/dd" /></td>
		</tr>

	</table>
	<div id="btnDiv">
		<input type="button" value="전체목록보기" class="btn btn-default"
			id="goToList" />
	</div>
</body>
</html>