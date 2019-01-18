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
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#cancel").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/notice/getNoticeList.do"
			});
			$("#searchForm").submit();
		});
		$("#regBtn").click(function() {
			if ($("#n_title").val() == null || $("#n_title").val() == '') {
				alert("제목을 입력해주세요!");
				return;
			} else if ($("#n_content").val() == null || $("#n_content").val() == '') {
				alert("내용을 입력해주세요!");
				return;
			} else {
				var form = $("form")[1];
				var formData = new FormData(form);
				$.ajax({
					url : "/admin/notice/insertNotice.do",
					processData : false,
					contentType : false,
					type : "post",
					data : formData,
					error : function() {
						alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("등록성공!");
							location.href="/admin/notice/getNoticeList.do";
						} else {
							alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						}
					}
				});
			}
		});
	});
</script>
</head>
<body oncontextmenu="return false">
	<h3>공지사항 글 쓰기</h3>
	<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ param.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="${ param.pageSize }" />
		</form>
		<form id="noticeForm" name="noticeForm" enctype="multipart/form-data">
		<input type="hidden" id="a_id" name="a_id" value="${ adminId }" />
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%"><input type="text" id="n_title" name="n_title" size="150" class="form-control" /></td>
			</tr>
			<tr>
				<th class="tac" width="30%">내용</th>
				<td class="tac" width="70%"><textarea id="n_content" name="n_content" class="form-control" cols="100" rows="20"></textarea>
			</tr>
			<tr>
				<th class="tac" width="30%">첨부이미지</th>
				<td class="tac" width="70%"><input type="file" id="file" name="file" size="150" class="form-control" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" id="regBtn" name="regBtn" class="btn btn-info" value="글 쓰기" />&nbsp;&nbsp;<input type="button" id="cancel" name="cancel" class="btn btn-warning" value="취소" /></td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>