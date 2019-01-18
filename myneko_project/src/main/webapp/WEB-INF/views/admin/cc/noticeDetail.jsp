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
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		var code = "<c:out value='${ code }' />";
		if (code != 1) {
			alert("네트워크 오류입니다. 잠시후 다시 시도해주세요.");
			location.href = "/admin/notice/getNoticeList.do";
		}
		$("#goNoticeList").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/notice/getNoticeList.do"
			});
			$("#searchForm").submit();
		});
		$("#modBtn").click(function() {
			$("#modForm").attr({
				"method" : "get",
				"action" : "/admin/notice/noticeModForm.do"
			});
			$("#modForm").submit();
		});
		$("#delBtn").click(function() {
			var n_number = "<c:out value='${ noticeDetail.n_number }' />";
			var n_image = "<c:out value='${ noticeDetail.n_image }' />";

			if (n_image != "default.jpg") {
				var data = {
					"n_number" : n_number,
					"n_image" : n_image
				};
			} else {
				var data = {
					"n_number" : n_number	
				};
			}

			$.ajax({
				url : "/admin/notice/noticeDelete.do",
				type : "get",
				data : data,
				error : function() {
					alert("네트워크 오류로 삭제에 실패하였습니다. 잠시후에 다시 시도해주세요");
				},
				success : function(result) {
					if (result == 1) {
						alert("삭제되었습니다!");
						location.href = "/admin/notice/getNoticeList.do";
					} else {
						alert("네트워크 오류로 삭제에 실패하였습니다. 잠시후에 다시 시도해주세요");
						return false;
					}
				}
			});
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
		<form id="modForm" name="modForm">
			<input type="hidden" id="n_number" name="n_number"
				value="${ noticeDetail.n_number }" /> <input type="hidden"
				class="page" name="page" value="${ param.page }" /> <input
				type="hidden" class="pageSize" name="pageSize" value="10" />
		</form>
		<table class="table table-striped">
			<tr>
				<td class="tac" width="30%">제목</td>
				<td class="tac" width="70%">${ noticeDetail.n_title }</td>
			</tr>
			<c:choose>
				<c:when test="${ not empty noticeDetail.n_image }">
					<td class="tac" width="30%">이미지</td>
					<td class="tac" width="70%"><img
						src="/uploadStorage/notice/${ noticeDetail.n_image }" width="50%"
						height="auto" />
				</c:when>
				<c:otherwise>
					<td colspan="2">
						이미지 없음
					</td>
				</c:otherwise>
			</c:choose>
			<tr>
				<td class="tac" width="30%">내용</td>
				<td class="tac" width="70%">${ noticeDetail.n_content }</td>
			</tr>
			<tr>
				<td class="tac" width="30%">작성자</td>
				<td class="tac" width="70%">${ noticeDetail.a_id }</td>
			</tr>
			<tr>
				<td class="tac" colspan="2" align="center"><input type="button"
					id="modBtn" name="modBtn" value="수정" class="btn btn-info" /> <input
					type="button" id="delBtn" name="delBtn" value="삭제"
					class="btn btn-danger" /> <input type="button" id="goNoticeList"
					name="goNoticeList" value="목록으로" class="btn btn-default" /></td>
			</tr>
		</table>
	</div>
</body>
</html>