<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#inqueryListBtn").on("click", function() {
			location.href = "/inquery/InqueryList?m_number=<%=session.getAttribute("m_number")%>";		
			});
		
		$("#inqueryUpdateBtn").click(function(){
			$("#f_writeForm").attr({
				"method":"post",
				"action":"/inquery/inqueryUpdate"
				});
			$("#f_writeForm").submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="contentContainer">
		<div class="contentTit">
			<h3>1:1문의내역 게시판 글 수정</h3>
		</div>

		<div class="contentTB">
			<form id="f_writeForm" name="f_writeForm">
				<input type="hidden" id="i_number" name="i_number"
					value="${updateData.i_number }" />
				<table>
					<colgroup>
						<col width="17%" />
						<col width="33%" />
						<col width="17%" />
						<col width="33%" />
					</colgroup>
					<tbody>
						<tr>
							<td class="ac">글번호</td>
							<td>${updateData.i_number }</td>
							<td class="ac">작성일</td>
							<td>${updateData.i_date }</td>
						</tr>
						<tr>
							<td class="ac">작성자</td>
							<td colspan="3">${updateData.m_number }</td>
						</tr>
						<tr>
							<td class="ac">글 제목</td>
							<td colspan="3"><input type="text" name="i_title"
								id="i_title" value="${updateData.i_title }" /></td>
						</tr>
						<tr>
							<td class="ac vm">내용</td>
							<td colspan="3"><textarea name="i_content" id="i_content">${updateData.i_content}
</textarea></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="contentBtn">
			<input type="button" value="수정" id="inqueryUpdateBtn"> <input
				type="button" value="목록" id="inqueryListBtn">
		</div>
	</div>
</body>
</html>