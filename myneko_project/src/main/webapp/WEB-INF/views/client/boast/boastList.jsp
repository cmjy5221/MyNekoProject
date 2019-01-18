<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 화면</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<style>
	#btnDiv {
		text-align: center;
	}
	
	#search, #b_division {
		width: 15%;
		float: left;
	}
	
	input[type=text] {
		width: 25%;
		float: left;
	}
	
	#boastPage {
		text-align: center;
	}
	
	.on {
		font-size : 15pt;
		color : black;
	}
	
	a:visited {
		text-decoration: none;
	}
	
	a:active {
		text-decoration: none;
	}
	
	a:hover {
		text-decoration: none;
	}
	
	a:link {
		text-decoration: none;
	}
</style>
</head>
<body>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/common.js"></script>
<script type="text/javascript">
$(function() {
	//제목버튼 클릭시 상세 페이지 로 이동
	$(".goDetail").click(function() {
		var b_number = $(this).parents("tr").attr("data-num");
		$("#b_number").val(b_number);
	});
	
	$("#searchData").click(function() {
		/* 검색 from 추가 */
		if ($("#search").val() == '') {
			$("#keyword").val("");
		} else if ($("#search").val() != ''){
			if ($("#keyword").val() == '') {
				alert("검색어를 입력해주세요!");
				return false;
			} else {
			}
		}
		$("#page").val(1);
		$("#b_search").attr({
			"method":"get",
			"action":"/boast/boardList.do"
		});
		$("#b_search").submit();
	});
	//글쓰기 버튼 클릭시 글작성 이동 이벤트
	$("#boastInsertBtn").click(function() {
		location.href = "/boast/writeBoast";
	}); 
	
});
</script>
		<h3>꿀팁공유/자랑게시판</h3>		
			<form id="b_search">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<select id="b_division" name="b_division" class="form-control">
				<option value="">전체</option>
				<option value="information">꿀팁공유</option>
				<option value="lad">반려묘자랑</option>
			</select>
			<select id="search" name="search" class="form-control">
				<option value="">전체</option>
				<option value="b_title">제목</option>
				<option value="b_content">내용</option>
			</select>
			<input type="text" name="keyword" id="keyword" placeholder="검색어를입력하세요" class="form-control" /><input type="button" value="검색" id="searchData" class="btn btn-default" />
		</form>
		<table class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>등록일</th>
			<th>작성자</th>
			<th>글분류</th>
		</tr>
		<c:choose>
			<c:when test="${ not empty boastList }">
				<c:forEach var="boast" items="${ boastList }" varStatus="status">
					<tr>
						<td>
							${ boast.b_number }
						</td>
						<td>
							<a href="/boast/boastDetail.do?b_number=${ boast.b_number }">${ boast.b_title }</a>
						</td>
						<td>
							<fmt:formatDate value="${ boast.b_date }" pattern="yyyy-MM-dd" />
						</td>
						<td>
							${ boast.m_id }
						</td>
						<td>
							<c:choose>
								<c:when test="${ boast.b_division == 'information' }">
									꿀팁공유
								</c:when>
								<c:otherwise>
									반려묘 자랑
								</c:otherwise>
							</c:choose>
						</td>
					</tr>		
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5" align="center">
						등록된 게시글이 없습니다.
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
 	<!--페이징 -->
	 <div id="boastPage">    							
		<tag:paging page="${param.page}" total="${total}" list_size="${data.pageSize}" />
    </div> 
	<!--페이징end -->
	<c:choose>
		<c:when test="${ not empty m_id }">
			<div id="btnDiv">
				<input type="button" value="글작성" class="goToInsertBtn btn btn-default" id="boastInsertBtn">
			</div>
		</c:when>
		<c:otherwise>
			<div id="btnDiv">
				<a href="/member/login">로그인한 회원만 글 작성이 가능합니다!
				먼저 로그인해주세요!</a>
			</div>
		</c:otherwise>
	</c:choose>
</html>