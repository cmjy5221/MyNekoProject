<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<style>
	#btnDiv {
		text-align: center;
	}
</style>
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#reviewListBtn").click(function() {
			location.href="/review/reviewList";
		});
		$("#updateFormBtn").click(function() {
			location.href="/review/updateForm?r_number=${reviewDetail.r_number}";
		});
		$("#reviewDeleteBtn").click(function() {
			if (confirm("정말 삭제하시겠습니까?")) {
				var r_number = {
					"r_number" : "<c:out value='${ reviewDetail.r_number}' />"	
				};
				var r_image = {
					"r_image" : "<c:out value='${ reviewDetail.r_image }' />"
				}
				$.ajax({
					url : "/review/reviewDelete",
					data : r_number,
					type : "get",
					error : function() {
						alert("네트워크 에러");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("삭제 성공!");
							location.href="/review/reviewList";
						} else {
							alert("삭제 실패!");
							return false;
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="contentContainer">
			<h3>리뷰 상세보기</h3>
		<form name="r_data" id="r_data" method="POST">
			<input type="hidden" id="r_number" name="r_number" value="${ reviewDetail.r_number }" />
		</form>

		<%-- review 상세정보 보여주기 --%>
		<div class="table-responsive">
			<table class="table table-striped">
				<tbody>
					<tr>
						<th>작성자</th>
						<td class="name"><%=session.getAttribute("m_id")%>
						<th>작성일</th>
						<td>${reviewDetail.r_date }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${reviewDetail.r_title}</td>
						<th>상품명</th>
						<td>${reviewDetail.p_name }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">${reviewDetail.r_content}<c:if test="${ not empty reviewDetail.r_image }"><img src="/uploadStorage/review/${ reviewDetail.r_image }" /></c:if></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="btnDiv">
			<input type="button" value="수정" id="updateFormBtn" class="btn btn-info">
			<input type="button" value="삭제" id="reviewDeleteBtn" class="btn btn-danger" >
			<input type="button" value="목록" id="reviewListBtn" class='btn btn-default'>
		</div>
	</div>
</body>
</html>