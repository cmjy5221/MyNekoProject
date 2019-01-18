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
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/faq/getFaqList.do"
			});
			$("#searchForm").submit();
		});
		$("#regBtn").click(function() {
			if ($("#f_title").val() == null || $("#f_title").val() == '') {
				alert("제목을 입력해주세요!");
				return;
			} else if ($("#f_content").val() == null || $("#f_content").val() == '') {
				alert("내용을 입력해주세요!");
				return;
			} else if (!chkFile($("#file"))) {
				return;
			} else {
				var form = $("form")[1];
				var formData = new FormData(form);
				$.ajax({
					url : "/admin/faq/insertFaq.do",
					processData : false,
					contentType : false,
					type: "post",
					data : formData,
					error : function() {
						alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("등록 성공!");
							location.href="/admin/faq/getFaqList.do";
						} else {
							alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						}
					}
				});
			}
		});
	});
	function chkFile(item) {
		var ext = item.val().split('.').pop().toLowerCase();
		if (jQuery.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
			alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body oncontextmenu="return false">
	<h3>FAQ 글 쓰기</h3>
	<div class="table-reponsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ param.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="${ param.pageSize }" />
		</form>
		<form id="faqForm" name="faqForm" enctype="multipart/form-data">
		<input type="hidden" id="a_id" name="a_id" value="${ adminId }" />
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%"><input type="text" id="f_title" name="f_title" size="150" class="form-control" /></td>
			</tr>
			<tr>
				<th class="tac" width="30%">내용</th>
				<td class="tac" width="70%"><textarea id="f_content" name="f_content" class="form-control" cols="100" rows="20"></textarea>
			</tr>
			<tr>
				<th class="tac" width="30%">첨부이미지</th>
				<td class="tac" width="70%"><input type="file" id="file" name="file" class="form-control" /></td>
			</tr>
		</table>
		</form>
		<div id="btnDiv">
			<button type="button" id="regBtn" name="regBtn" class="btn btn-info">글 쓰기</button>&nbsp;&nbsp;<button type="button" id="cancel" name="cancel" class="btn btn-warning">취소</button>
		</div>
	</div>
</body>
</html>