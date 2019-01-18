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
	table {
		width: 70%;
	}
	td, th {
		text-align: center;
	}
	
	.btn {
		padding-top: 0px;
		font-size: 10pt;
		height: 20px;
		float: right;
	}
	
	#noticePage {
		text-align: center;
	}
	
	.on {
		font-size: 15pt;
	}
	
	a:link {
		text-decoration: none;
		color: black;
	}
	
	a:hover {
		text-decoration: none;
		color: black;
	}
	
	a:active {
		text-decoration: none;
		color: black;
	}
	
	a:visited {
		text-decoration: none;
		color: black;
	}
	
	select {
		width: 50%;
	}
</style>
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
		$("#regist").click(function() {
			location.href="/admin/notice/noticeRegForm.do?page=${data.page}&pageSize=10";
		});
	});
</script>
</head>
<body oncontextmenu="return false">
<h3>공지사항 게시판 관리</h3>
	<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
		</form>
		<table class="table table-striped">
			<thead>
				<tr>
					<th class="tac">글 번호</th>
					<th class="tac">제목</th>
					<th class="tac">등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ not empty noticeList }">
						<c:forEach var="notice" items="${ noticeList }" varStatus="status">
							<tr class="tac">
								<td>${ notice.n_number }</td>
								<td><a href="/admin/notice/getNoticeDetail.do?page=${ data.page }&pageSize=10&n_number=${ notice.n_number }">${ notice.n_title }</a></td>
								<td><fmt:formatDate value="${ notice.n_date }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="tac" align="center">
								등록된 공지사항 게시글이 존재하지 않습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div id="btnDiv">
			<input type="button" id="regist" name="regist" class="btn btn-info" value="글쓰기" />
		</div>
		<div id="noticePage">
			<tag:paging page="${ param.page }" total="${ total }" list_size="10" />
		</div>
	</div>
</body>
</html>