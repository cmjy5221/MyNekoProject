<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/boostrap.min.css" />
<style>
	.btnDiv {
		text-align: center;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#reviewUpdateBtn").click(function() {
			if (!chkSubmit($('#r_title'), "제목을"))
				return;
			else if (!chkSubmit($('#r_content'), "작성할 내용을"))
				return;
			else if (!chkFile($("#file")))
				return;
			else {
				var form = $("form")[0];
				var formData = new FormData(form);
				$.ajax({
					processData : false,
					contentType : false,
					url : "/review/reviewUpdate",
					type : "post",
					data : formData,
					error : function() {
						alert("네트워크 에러!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("수정 성공!");
							location.href="/review/reviewDetail?r_number=${updateData.r_number}";
						} else {
							alert("수정 실패!");
							return false;
						}
					}
				});
			}
		});
		$("#reviewListBtn").click(function() {
			location.href = "/review/reviewList";
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="table-responsive">
			<h3>리뷰 게시판 글수정</h3>
		<div class="contentTB">
			<form id="r_writeForm" name="r_writeForm" enctype="multipart/form-data">
				<input type="hidden" id="r_number" name="r_number" value="${ updateData.r_number }" />
				<table class="table table-striped">
					<tbody>
						<tr>
							<th>상품명</th>
							<td>${ updateData.p_name }</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${updateData.r_date }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${updateData.m_id}</td>
						</tr>
						<tr>
							<th>글제목</th>
							<td><input type="text" id="r_title"
								value="${updateData.r_title }" class="form-control" readonly /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="r_content" id="r_content" class="form-control" cols="20" rows="10">${updateDta.r_content }</textarea></td>
						</tr>
						<tr>
							<th>이미지 첨부</th>
							<td><input type="file" name="file" id="file" class="form-control" />
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="btnDiv">
			<input type="button" value="수정" id="reviewUpdateBtn" class="btn btn-info">
			<input type="button" value="목록" id="reviewListBtn" class="btn btn-default">
		</div>
	</div>
</body>
</html>