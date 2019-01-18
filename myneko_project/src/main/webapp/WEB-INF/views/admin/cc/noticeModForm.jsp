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
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#cancel").click(function() {
			if (confirm("수정을 취소하고 이전페이지로 돌아가시겠습니까?") == true) {
				location.href="/admin/notice/getNoticeDetail.do?page=${param.page}&pageSize=10&n_number=${noticeDetail.n_number}";
			} else {
				return false;
			}
		});
		/* $("#modBtn").click(function() {
			if ($("#n_content").val() == null || $("#n_content").val() == '') {
				alert("수정하실 내용을 입력해주세요!");
				return false;
			} else {
				$("#modForm").attr({
					"method" : "post",
					"action" : "/admin/notice/noticeModify.do"
				});
				$("#modForm").submit();
			}
			}); */
			$("#modBtn").click(function() {
				if ($("#n_content").val() == null || $("#n_content").val() == '') {
					alert("수정하실 내용을 입력해주세요!");
					return false;
				} else {
					/* var n_image = "<c:out value='${noticeDetail.n_image}' />";
					var file = $("#file").val().split("\\").pop();
					var n_number = $("#n_number").val();
					var n_content = $("#n_content").val();
					var data = {
						"n_image" : n_image,
						"file" : file,
						"n_number" : n_number,
						"n_content" : n_content
					}; */
					var form = $("form")[0];
					var formData = new FormData(form);
					$.ajax({
						url : "/admin/notice/noticeModify.do",
						processData : false,
						contentType: false,
						type : "post",
						data : formData,
						error : function() {
							alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						},
						success : function(result) {
							if (result == 1) {
								alert("성공적으로 수정되었습니다.");
								location.href="/admin/notice/getNoticeDetail.do?n_number=${noticeDetail.n_number}";
							} else {
								alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
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
	<h3>공지사항 글 수정</h3>
	<div class="table-reponsive">
		<form id="modForm" name="modForm" enctype="multipart/form-data">
		<input type="hidden" id="n_number" name="n_number" value="${ noticeDetail.n_number }" />
		<input type="hidden" id="n_image" name="n_image" value="${ noticeDetail.n_image }" />
		<table class="table table-striped">
			<tr>
				<th class="tac" width="30%">제목</th>
				<td class="tac" width="70%"><input type="text" size="150" class="form-control" value="${ noticeDetail.n_title }" readonly /></td>
			</tr>
			<c:if test="${ not empty noticeDetail.n_image }">
				<tr>
					<th class="tac" width="30%">이미지</th>
					<td class="tac" width="70%"><img src="/uploadStorage/notice/${ noticeDetail.n_image }" alt="첨부이미지" />
				</tr>			
			</c:if>
			<tr>
				<th class="tac" width="30%">내용</th>
				<td class="tac" width="70%"><textarea id="n_content" name="n_content" class="form-control" cols="100" rows="20">${ noticeDetail.n_content }</textarea>
			</tr>
			<tr>
				<th class="tac" width="30%">첨부이미지</th>
				<td class="tac" width="70%"><input type="file" id="file" name="file" class="form-control" />
			</tr>
		</table>
		</form>
	</div>
	<div id="btnDiv">
		<input type="button" id="modBtn" name="modBtn" class="btn btn-info" value="수정하기" />&nbsp;&nbsp;<input type="button" id="cancel" name="cancel" class="btn btn-warning" value="취소" />
	</div>
</body>
</html>