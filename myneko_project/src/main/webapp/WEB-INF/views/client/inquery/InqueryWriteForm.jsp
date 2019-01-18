<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의하기</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script>
	$(document).ready(function() {
		
		$("#cancelBtn").on("click", function() {
			if(confirm("취소하시겠습니까?")){
				window.location.href = "/inquery/InqueryList?m_number=<%=session.getAttribute("m_number")%>";				
			}
		});
		$("#writeBtn").click(function() {
			if ($("#i_title").val() == '') {
				alert("제목을 입력해주세요!");
				return;
			} else if ($("#i_content").val() == '') {
				alert("내용을 입력해주세요!");
				return;
			} else {
				var form = $("form")[0];
				var formData = new FormData(form);
				$.ajax({
					url : "/client/inquiry/CIinsert",
					processData : false,
					contentType : false,
					type : "post",
					data : formData,
					error : function() {
						alert("등록 실패!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("등록 성공!");
							location.href="/client/inquiry/getCIList?m_id=${m_id}";
						} else {
							alert("등록 실패!");
							return false;
						}
					}
				});
			}
		});
	});
</script>
<style>
	#btnDiv {
		text-align: center;
	}
</style>
</head>
<body>
	<%
		int m_number = (Integer) session.getAttribute("m_number");
	%>
	<h3>1:1문의</h3>
	<form id="insertForm" enctype="multipart/form-data">
		<%-- <input type="text" id="m_number" name="m_number" value="<%= out.print(m_number) %>"/> --%>
		<table class="table">
			<tr>
				<td class="ac">작성자</td>
				<td><%=session.getAttribute("m_id")%><input type="hidden" id="m_id" name="m_id" value="${ m_id }" /></td>

			</tr>
			<tr>
				<td class="ac">글제목</td>
				<td><input type="text" name="i_title" id="i_title" class="form-control"></td>
			</tr>
			<tr>
				<td class="ac vm">내용</td>
				<td><textarea name="i_content" id="i_content" class="form-control"></textarea></td>
			</tr>

			<tr>
				<td class="ac">파일첨부</td>
				<td><input type="file" name="file" id="file" class="form-control"></td>
			</tr>
		</table>
		<div id="btnDiv">
			<input type="button" value="취소하기" id="cancelBtn" class="btn btn-default">
			<input type="button" value="문의하기" id="writeBtn" class="btn btn-info">
		</div>
	</form>
</body>
</html>