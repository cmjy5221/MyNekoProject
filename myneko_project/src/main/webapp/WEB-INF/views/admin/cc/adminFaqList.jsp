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
<style>
	td, th {
		text-align: center;
	}
	
	#firstDate {
		width: 15%;
		float: left;
	}
	
	#lastDate {
		width: 15%;
		float: left;
	}
	
	.left {
		float: left;
	}
	
	#regist {
		padding-top: 0px;
		font-size: 10pt;
		height: 20px;
		float: right;
	}
	
	label {
		float: left;
	}
	
	#faqPage {
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
	
	#keyword {
		width: 15%;
		float: left;
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
		$("#firstDate").val("<c:out value='${firstDate}' />");
		$("#lastDate").val("<c:out value='${lastDate}' />");
		$("#regist").click(function() {
			location.href="/admin/faq/faqRegForm.do?page=${data.page}&pageSize=10";
		});
		$("#searchBtn").click(function() {
			if ($("#firstDate").val() > $("#lastDate").val()) {
				alert("검색시작 날짜는 종료날짜를 초과할 수 없습니다.");
				return false;
			} else {
				$("#searchForm").attr({
					"action" : "/admin/faq/getFaqList.do",
					"method" : "get"
				});
				$("#searchForm").submit();
			}
		});
	});
	
	function goPage(page) {
		$("#page").val(page);
		$("#searchForm").attr({
			"action" : "/admin/faq/getFaqList.do",
			"method" : "get"
		});
		$("#searchForm").submit();
	}
</script>
</head>
<body oncontextmenu="return false">
<h3>FAQ 게시판 관리</h3>
	<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
			<input type="date" id="firstDate" name="firstDate" class="form-control" />
			<label>~</label>
			<input type="date" id="lastDate" name="lastDate" class="form-control" />
			<input type="text" id="keyword" name="keyword" class="form-control" />
			<input type="button" id="searchBtn" value="검색" class="btn btn-default" />
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
					<c:when test="${ not empty faqList }">
						<c:forEach var="faq" items="${ faqList }" varStatus="status">
							<tr class="tac">
								<td>${ faq.f_number }</td>
								<td><a href="/admin/faq/faqDetail.do?page=${ data.page }&pageSize=10&f_number=${ faq.f_number }">${ faq.f_title }</a></td>
								<td><fmt:formatDate value="${ faq.f_date }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="tac" align="center">
								등록된 FAQ 게시글이 존재하지 않습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div id="btnDiv">
			<input type="button" id="regist" name="regist" class="btn btn-info" value="글쓰기" />
		</div>
		<div id="faqPage">
			<tag:paging page="${ param.page }" total="${ total }" list_size="10" />
		</div>
	</div>
</body>
</html>