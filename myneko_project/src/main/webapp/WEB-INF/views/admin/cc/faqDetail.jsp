<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#btnDiv {
		text-align: center;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<%
	String adminId = (String) session.getAttribute("adminId");
	if (adminId == null || adminId == "") {
%>
<script>
	location.href="/admin/adminLogin.do";
</script>
<%
	}
%>
<script>
	$(document).ready(function() {
		$("#goToList").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/faq/getFaqList.do"
			});
			$("#searchForm").submit();
		});
		$("#delBtn").click(function() {
			var f_number = "<c:out value='${ faqDetail.f_number }' />";
			var f_image = "<c:out value='${ faqDetail.f_image }' />";
			if (f_image == null && f_image == '') {
				var data = {
					"f_number" : f_number	
				};
			} else {
				var data = {
					"f_number" : f_number,
					"f_image" : f_image
				};
			}
			$.ajax({
				url : "/admin/faq/faqDelete.do",
				type : "get",
				data : data,
				error : function() {
					alert("네트워크 오류로 삭제하지 못했습니다. 잠시후에 다시 시도해주세요!");
					return false;
				},
				success : function(result) {
					if (result == 1) {
						alert("삭제성공!");
						location.href="/admin/faq/getFaqList.do";
					} else {
						alert("네트워크 오류로 삭제하지 못했습니다. 잠시후에 다시 시도해주세요!");
						return false;
					}
				}
			});
		});
		$("#modBtn").click(function() {
			location.href="/admin/faq/faqModForm.do?f_number=${ faqDetail.f_number }&page=${ param.page }&pageSize=10";
		});
	});
</script>
</head>
<body oncontextmenu="return false">
<h3>FAQ 게시글 상세보기</h3>
<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ param.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
		</form>
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%">${ faqDetail.f_title }</td>
			</tr>
			<tr>
				<th class="tac" width="30%">내용</th>
				<td class="tac" width="70%">${ faqDetail.f_content }</td>
			</tr>
			<c:choose>
				<c:when test="${ faqDetail.f_image != null }">
					<tr>
						<th class="tac" width="30%">이미지</th>
						<td class="tac" width="70%"><img src="/uploadStorage/faq/${ faqDetail.f_image }" width="30%" height="auto" alt="첨부이미지" /></td>
					</tr>
				</c:when>
			</c:choose>
			<tr>
				<th class="tac" width="30%">등록일</th>
				<td class="tac" width="70%"><fmt:formatDate value="${ faqDetail.f_date }" pattern="yyyy/MM/dd" /></td>
			</tr>
		</table>
</div>
<div id="btnDiv">
	<input type="button" id="modBtn" name="modBtn" class="btn btn-info" value="수정" />&nbsp;&nbsp;<input type="button" id="delBtn" name="delBtn" class="btn btn-danger" value="삭제" />&nbsp;&nbsp;<input type="button" id="goToList" name="goToList" class="btn btn-default" value="목록으로" />
</div>
</body>
</html>