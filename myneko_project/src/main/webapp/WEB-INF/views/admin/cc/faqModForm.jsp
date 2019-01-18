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
	td, th {
		text-align: center;
	}
	
	#btnDiv {
		text-align: center;
	}
	
	input {
		width: 80%;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#cancel").click(function() {
			if (confirm("수정을 취소하고 이전페이지로 돌아가시겠습니까?") == true) {
				location.href="/admin/faq/faqDetail.do?page=${param.page}&pageSize=10&f_number=${param.f_number}";
			} else {
				return false;
			}
		});
		$("#modBtn").click(function() {
			if ($("#f_content").val() == null || $("#f_content").val() == '') {
				alert("수정하실 내용을 입력해주세요!");
				return false;
			} else {
				var form = $("form")[0];
				var formData = new FormData(form);
				$.ajax({
					url : "/admin/faq/faqModify.do",
					processData : false,
					contentType : false,
					type : "post",
					data : formData,
					error : function() {
						alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
					},
					success : function(result) {
						if (result == 1) {
							alert("수정성공!");
							location.href="/admin/faq/faqDetail.do?f_number=${faqDetail.f_number}";
						} else {
							alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
						}
					}
				});
			}
		});
	});
</script>
</head>
<body oncontextmenu="return false">
	<h3>FAQ 글 수정</h3>
		<div class="table-responsive">
		<form id="modForm" name="modForm" enctype="multipart/form-data">
		<input type="hidden" id="f_number" name="f_number" value="${ param.f_number }" />
		<input type="hidden" id="f_image" name="f_image" value="${ faqDetail.f_image }" />
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%"><input type="text" class="form-control" value="${ faqDetail.f_title }" readonly /></td>
			</tr>
			<c:if test="${ not empty faqDetail.f_image }">
				<tr>
					<th class="tac" width="30%">이미지</th>
					<td class="tac" width="70%"><img src="/uploadStorage/faq/${ faqDetail.f_image }" width="50%" height="auto" alt="첨부이미지" />
				</tr>			
			</c:if>
			<tr>
				<th class="tac" width="30%">내용</th>
				<td class="tac" width="70%"><textarea id="f_content" name="f_content" class="form-control" cols="100" rows="20">${ faqDetail.f_content }</textarea>
			</tr>
			<tr>
				<th class="tac" width="30%">이미지첨부</th>
				<td class="tac" width="70%"><input type="file" id="file" name="file" class="form-control" /></td>
			</tr>
		</table>
		</form>
	<div id="btnDiv">
		<button type="button" id="modBtn" name="modBtn" class="btn btn-info">수정</button>&nbsp;&nbsp;<button type="button" id="cancel" name="cancel" class="btn btn-warning">취소</button>
	</div>
	</div>
</body>
</html>