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
		$("#firstDate").val("<c:out value='${firstDate}' />");
		$("#lastDate").val("<c:out value='${lastDate}' />");
		$("#keyword").val("<c:out value='${keyword}' />");
		$("#searchBtn").click(function() {
			if ($("#firstDate").val() > $("#lastDate").val()) {
				alert("검색시작 날짜는 종료날짜를 초과할 수 없습니다.");
				return false;
			} else {
				$("searchForm").attr({
					"action" : "/admin/qna/getQnaList.do",
					"method" : "get"
				});
				$("#searchForm").submit();
			}
		});
	});
	
	function goPage(page) {
		$("#page").val(page);
		$("#searchForm").attr({
			"action" : "/admin/qna/getQnaList.do",
			"method" : "get"
		});
		$("#searchForm").submit();
	}
</script>
<style>
	table {
		width: 70%;
	}
	td, th {
		text-align: center;
	}
	
	#qnaPage {
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
	#firstDate {
		width: 15%;
		float: left;
	}
	
	#lastDate {
		width: 15%;
		float: left;
	}
	
	label {
		float: left;
	}
	
	#keyword {
		width: 15%;
		float: left;
	}
</style>
</head>
<body oncontextmenu="return false">
<h3>1 : 1 문의 관리</h3>
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
			<input type="date" id="firstDate" name="firstDate" class="form-control" />
			<label>~</label>
			<input type="date" id="lastDate" name="lastDate" class="form-control" />
			<input type="text" id="keyword" name="keyword" class="form-control" />
			<input type="button" id="searchBtn" class="btn btn-default" value="검색" />
		</form>
		<table class="table table-striped">
			<thead>
				<tr>
					<th class="tac">문의자</th>
					<th class="tac">문의제목</th>
					<th class="tac">문의일자</th>
					<th class="tac">답변여부</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ not empty qnaList }">
						<c:forEach var="qna" items="${ qnaList }" varStatus="status">
							<tr class="tac">
								<td>${ qna.m_id }</td>
								<td><a href="/admin/qna/getQnaDetail.do?i_number=${ qna.i_number }&page=${ data.page }&pageSize=10">${ qna.i_title }</a></td>
								<td><fmt:formatDate value="${ qna.i_date }" pattern="yyyy-MM-dd" /></td>
								<td>${ qna.i_repwhether }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="tac" align="center">
								등록된 문의가 존재하지 않습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div id="qnaPage">
			<tag:paging page="${ param.page }" total="${ total }" list_size="10" />
		</div>
</body>
</html>