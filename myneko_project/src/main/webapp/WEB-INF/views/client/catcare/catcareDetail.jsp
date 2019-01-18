<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 정보 관리 글 상세 보기</title>
<!-- <link rel="stylesheet" type="text/css" href="/resources/include/css/catcareDetail.css?ver=2" /> -->
<style>
	#btnDiv {
		text-align: center;
	}
</style>
<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(function(){
	
	var file = "<c:out value='${detail.ci_image}'/>";
	if(file!=""){
		$("#fileImage").attr({
			src:"/uploadStorage/catcareinfo/${detail.ci_image}",
			width:"750px",
			height:"450px"
		});
	}
	
	/* 목록 버튼 클릭 시 처리 이벤트 */
	$("#catcareListBtn").click(function(){
		location.href="/catcare/catcareList.do";
	});
});
</script>
</head>
<body>
	<div id="detailContainer" class="table-responsive">
		<div><h3>게시판 상세보기</h3></div>
		<form name="f_data" id="f_date" method="POST">
			<input type="hidden" name="ci_number" value="${detail.ci_number}" />
		</form>
		
		<!-- 상세 정보 보여주기 -->
		<div>
			<table class="table">
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td><strong>제목</strong></td>
						<td>${detail.ci_title}</td>
					</tr>
					<tr>
						<td>등록일&nbsp;&nbsp;</td>
						<td>${detail.ci_date}</td>
					</tr>
					<tr>
						<td>작성자&nbsp;&nbsp;</td>
						<td>${ detail.a_id }</td>
					</tr>
				</tbody>
			</table>
			<div><img id="fileImage" src="/uploadStorage/${detail.ci_image}"></div>
			<div id="content">${detail.ci_content}</div>
		</div>
		<c:if test="${detail.ci_image != ''}">
		<div id="btnDiv">
			<button id="catcareListBtn" class="btn btn-default">목록으로</button>
		</div>
		</c:if>
		<jsp:include page="careReply.jsp"></jsp:include>
	</div>
</body>
</html>