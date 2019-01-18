<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<style>
#btnDiv {
	text-align: center;
}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#goToList").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/client/notice/noticeList"
			});
			$("#searchForm").submit();
		});
	});
</script>
</head>
<body oncontextmenu="return false">
	<h3>공지사항 상세보기</h3>
	<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ param.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
		</form>
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%">${ noticeDetail.n_title }</td>
			</tr>
			<c:choose>
				<c:when test="${ noticeDetail.n_image != null }">
					<tr>
						<th class="tac" width="30%">내용</th>
						<td class="tac" width="70%">${ noticeDetail.n_content }<img
							src="/uploadStorage/notice/${ noticeDetail.n_image }" width="30%"
							height="auto" alt="첨부이미지" /></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th class="tac" width="30%">내용</th>
						<td class="tac" width="70%">${ noticeDetail.n_content }</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th class="tac" width="30%">등록일</th>
				<td class="tac" width="70%"><fmt:formatDate
						value="${ noticeDetail.n_date }" pattern="yyyy/MM/dd" /></td>
			</tr>
		</table>
	</div>
	<div id="btnDiv">
		<input type="button" id="goToList" name="goToList"
			class="btn btn-default" value="목록으로" />
	</div>
</body>
</html>