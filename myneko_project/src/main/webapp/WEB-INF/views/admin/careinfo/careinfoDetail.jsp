<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리 정보</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#goToList").click(function() {
			location.href="/admin/careinfo/careinfoList.do";
		});
		$("#modifyBtn").click(function() {
			$("#optionForm").attr({
				"method" : "get",
				"action" : "/admin/careinfo/careinfoModifyForm.do"
			})
			$("#optionForm").submit();
		})
		$("#deleteBtn").click(function() {
			var check = confirm('게시물을 삭제하시겠습니까?')
			if (check) {
				var ci_number = "<c:out value='${data.ci_number}' />";
				var data = {
					"ci_number" : ci_number
				};
				$.ajax({
					url : "/admin/careinfo/careinfoOneDelete.do",
					data : data,
					type : "post",
					error : function() {
						alert("네트워크 문제로 삭제하지 못했습니다. 잠시후에 다시 시도해주세요!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("삭제 성공!");
							location.href="/admin/careinfo/careinfoList.do";
						} else {
							alert("네트워크 문제로 삭제하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						}
					}
				});
			}
		})
	})
</script>
<style>
	#btnDiv {
		text-align: center;
	}
</style>
</head>
<body>
	<h3>고양이 관리 정보 상세보기</h3>
	<div class="table-responsive">
	<form id="optionForm" name="optionForm">
		<input type="hidden" id="page" name="page" value="${data.page}" /> <input
			type="hidden" id="pageSize" name="pageSize" value="${data.pageSize}">
		<input type="hidden" id="ci_number" name="ci_number"
			value="${ careinfo.ci_number }">
	</form>
	<table class="table table-striped">
		<tr>
			<th class="tac" width="30%">제목</th>
			<th class="tac" width="70%">${careinfo.ci_title }</th>
		</tr>
		<tr>
			<td class="tac" width="30%">작성자</td>
			<td class="tac" width="70%">${careinfo.a_id }</td>
		</tr>
		<tr>
			<td class="tac" width="30%">내용</td>
			<td class="tac" width="70%">${careinfo.ci_content }</td>
		</tr>
		<tr>
			<td class="tac" width="30%">첨부 이미지</td>
			<td class="tac" width="70%"><img width="30%" height="auto" alt="첨부 이미지"
				src="/uploadStorage/catcareinfo/${careinfo.ci_image }" class="thumbnail"></td>
		</tr>
		<tr>
			<td class="tac" width="30%">등록일</td>
			<td class="tac" width="70%"><fmt:formatDate value="${ careinfo.ci_date }" pattern="yyyy/MM/dd" /></td>
		</tr>
	</table>
	<div id="btnDiv">
	<input type="button" value="수정" id="modifyBtn" name="modifyBtn" class="btn btn-info">
	<input type="button" value="삭제" id="deleteBtn" name="deleteBtn" class="btn btn-danger">
	<input type="button" value="목록으로" id="goToList" name="goToList" class="btn btn-default" />
	</div>
	</div>
</body>
</html>