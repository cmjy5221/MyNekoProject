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
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#goQnaList").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/qna/getQnaList.do"
			});
			$("#searchForm").submit();
		});
		$("#qnaReplyReg").click(function() {
			$("#regForm").attr({
				"method" : "get",
				"action" : "/admin/qna/qnaReplyRegForm.do"
			});
			$("#regForm").submit();
		});
	});
</script>
</head>
<body oncontextmenu="return false">
<h3>1 : 1 문의 상세보기</h3>
<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ param.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
		</form>
		<form id="regForm" name="regForm">
			<input type="hidden" id="i_number" name="i_number" value="${ qnaDetail.i_number }" />
			<input type="hidden" class="page" name="page" value="${ param.page }" />
			<input type="hidden" class="pageSize" name="pageSize" value="10" />
		</form>
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">문의제목</th>
				<td class="tac" width="70%">${ qnaDetail.i_title }</td>
			</tr>
			<tr>
				<th class="tac" width="30%">문의자</th>
				<td class="tac" width="70%">${ qnaDetail.m_id }</td>
			</tr>
			<tr>
				<th class="tac" width="30%">문의일자</th>
				<td class="tac" width="70%"><fmt:formatDate value="${ qnaDetail.i_date }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
			</tr>
			<tr>
				<th class="tac" width="30%">문의내용</th>
				<td class="tac" width="70%">${ qnaDetail.i_content }</td>
			</tr>
		</table>
		<table class="table table-striped">
			<c:choose>
				<c:when test="${ not empty reply }">
					<tr>
						<th class="tac" width="30%">답변내용</th>
						<td class="tac" width="70%">${ reply.rep_content }</td>
					</tr>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${ qnaDetail.i_repwhether == 'N' }">
					<tr>
						<td class="tac" colspan="2" align="center">
							<input type="button" id="qnaReplyReg" name="qnaReplyReg" value="답변등록" class="btn btn-info" />
							<input type="button" id="goQnaList" name="goQnaList" value="목록으로" class="btn btn-default" />
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="tac" colspan="2" align="center">
							<input type="button" id="goQnaList" name="goQnaList" value="목록으로" class="btn btn-info" />
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>