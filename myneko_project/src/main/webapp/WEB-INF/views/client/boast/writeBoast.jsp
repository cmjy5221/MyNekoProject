<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<style>
	#btnDiv {
		text-align: center;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		//필수입력 사항입력후 저장버튼 클릭시 글목록 이동		
		$("#boastInsertBtn").click(function() {
			var form = $("form")[0];
			var formData = new FormData(form);
			$.ajax({
				url : "/boast/boastInsert",
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
						location.href = "/boast/boardList";
					} else {
						alert("등록 실패!");
						return false;
					}
				}
			});
		});
		//목록버튼 클릭시 글목록 으로 이동
		$("#boastBtn").click(function() {
			location.href = "/boast/boardList";
		});
	});
</script>
</head>
<body>
	<h3>꿀팁공유/자랑 글작성</h3>
	<div class="table-responsive">
		<form id="writeForm" name="writeForm" enctype="multipart/form-data">
			<input type="hidden" id="m_number" name="m_number"
				value="<%=session.getAttribute("m_number")%>" />
			<table id="boastWrite" class="table">
				<tr>
					<th class="er">제목</th>
					<td><input type="text" name="b_title" id="b_title"
						class="form-control"></td>
				</tr>
				<tr>
					<th class="ac">
						게시글 구분
					</th>
					<td>
						<!-- <input type="text" name="b_name" id="b_name"> --> <select
						id="b_division" name="b_division" class="form-control">
							<option value="information">꿀팁공유</option>
							<option value="lad">반려묘자랑</option>
					</select>
					</td>
				</tr>
				<tr>
					<th class="ac vm">내용</th>
					<td><textarea name="b_content" id="b_content"
							class="form-control"></textarea></td>
				</tr>
				<tr>
					<th class="ac">이미지</th>
					<td><input type="file" name="file" id="file"
						class="form-control"></td>
				</tr>
			</table>
		</form>
		<div id="btnDiv">
		<input type="button" value="목록으로" class="goToListBtn btn btn-default" id="boastBtn">
		<input type="button" value="저장" class="goToListBtn btn btn-info" id="boastInsertBtn">
		</div>
	</div>
</body>
</html>