<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ목록 게시판</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<style>
	.form-control {
		width: 25%;
		float: left;
	}
	
	#FaqboardPage {
		text-align: center;
	}
	
	a:hover {
		text-decoration: none;
		color: black;
	}
	
	a:active {
		text-decoration: none;
		color: black;
	}
	
	a:link {
		text-decoration: none;
		color: black;
	}
	
	a:visited {
		text-decoration: none;
		color: black;
	}
	
	.on {
		font-size: 15pt;
		color: black;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
$(function() {
	/* 검색후 검색 대상과 검색 단어 출력 */
	var word="<c:out value='${data.keyword}' />";
	var value="";
	if(word!=""){
		$("#keyword").val("<c:out value='${data.keyword}' />");
		$("#search").val("<c:out value='${data.search}' />");
	}
	/* 검색 버튼 클릭시 처리 이벤트 */
	$("#searchData").click(function() {
		if($("#search").val()!="all") {
		if(!chkSubmit($('#keyword'),"검색어를")) return;
		}
		search(1);
	});
	/* 엔터키 이벤트 */
		
	});
	
	/*(페이징)한페이지에 보여줄 레코드 수 변경될 때마다 처리 이벤트*/
	$("#pageSize").change(function() {
		goPage(1);
	});
	$(".order").click(function() {
		var order_by = $(this).attr("data-value");
		console.log("선택값:" + order_by);
		$("#order_by").val(order_by);
		if ($("#order_sc").val() == 'DESC') {
			$("#order_sc").val('ASC');
		} else {
			$("#order_sc").val('DESC');
		}
		goPage(1);
	});
/* 제목클릭시 상세 페이지로 이동을 위한 이벤트 */
	$(".goDetail").click(function() {
		var f_number = $(this).parents("tr").attr("data-num");
		$("#f_number").val(f_number);
	});
	/* 상세 페이지로 이동 하기 위해 from 추가 */
	$("#faqboarddetail").attr({
		"method" : "get",
		"action" : "/faqboard/faqdetail.do"
	});

$(document).keydown(function(e) {
	key = (e) ? e.keyCode : event.keyCode;
	var t = document.activeElement;
	if (key == 13) {
		if (t.tagName != "input") {
			return false;
		} else {
			$("#page").val(1);
			$("#f_search").attr({
				"method" : "get",
				"action" : "/faqboard/faqboardlist"
			});
			$("#f_search").submit();
		}
	}
});

/* 검색한 한페이지에 보여줄 레코드 수 처리 및 페이징을 위한 실질적인 처리 함수 */
function goPage(page) {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#f_search").attr({
			"method" : "get",
			"action" : "/faqboard/faqboardlist"
		});
		$("#f_search").submit();
	}
	function search(page) {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#f_search").attr({
			"method" : "get",
			"action" : "/faqboard/faqboardlist"
		});
		$("#f_search").submit();
	}
</script>
</head>
<body>
	<h2>FAQ 게시판</h2>
	<div class="table-reponsive">
		<form id="f_search" name="f_search">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<input type="hidden" id="pageSize" name="pageSize"
				value="${ data.pageSize }" /> 
				
			<!-- <label>검색조건</label>  -->
			<select id="search" name="search" class="form-control">
				<option value="all">전체</option>
				<option value="title">제목</option>
			</select> <input type="text" name="keyword" id="keyword"
				placeholder="검색어를입력하세요" class="form-control" /> <input type="button" value="검색"
				id="searchData" class="btn btn-default" />
		</form>
	</div>
	<table class="table table-striped">
		<tr>
			<td>글번호</td>
			<td>제목</td>
			<td>등록일</td>
		</tr>
		<c:choose>
			<c:when test="${ not empty Faqboard }">
				<c:forEach items="${ Faqboard }" var="Faqboard" varStatus="status">
					<tr>
						<td>${ Faqboard.f_number }</td>
						<%-- <td><img src="/uploadStorage/faqboard/${ Faqboard.f_image }" /> --%>

						<td><a
							href="/faqboard/faqdetail.do?f_number=${ Faqboard.f_number }">${ Faqboard.f_title }</a>
						</td>
						<!-- <td>ID</td> -->
						<td><fmt:formatDate value="${ Faqboard.f_date }"
								pattern="yy/MM/dd" /></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">등록된 게시물이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	<!--페이징 -->
	 <div id="FaqboardPage">
	 <tag:paging page="${param.page}" total="${total}"
    	list_size="${data.pageSize}" />
    </div> 
	<!--페이징end -->
</body>
</html>