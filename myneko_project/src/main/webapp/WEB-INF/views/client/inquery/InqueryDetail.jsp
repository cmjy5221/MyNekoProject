<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 상세보기</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="/resources/include/js/bootstrap.js">
</script>
<script src="/resources/include/js/bootstrap.min.js"></script>
<style>
	#btnDiv {
		text-align: center;
	}
</style>
</head>
<body>
	<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var i_number = "<c:out value='${ inquiryDetail.i_number }' />";
			listAll(i_number);
			$("#back").click(function() {
				location.href = "/client/inquiry/getCIList?m_id=${m_id}";
			});
		});
		function listAll(i_number) {
			var data = {
				"i_number" : i_number	
			};
			$.ajax({
				url : "/client/inquiry/getCIReply",
				type : "get",
				data : data,
				error : function() {
					alert("댓글 목록을 불러오는 것에 실패하였습니다");
					return;
				},
				success : function(result) {
					if (result != null) {
						$(result).each(function() {
							var rep_number = this.rep_number;
							var rep_content = this.rep_content;
							var rep_regdate = this.rep_regdate;
							var i_number = this.i_number;
							var a_id = this.a_id;
							addNew(rep_number, rep_content, rep_regdate, i_number, a_id);
						});
					} else {
						alert("댓글 목록을 불러오는 것에 실패하였습니다.");
						return;
					}
				}
			});
		};
		function addNew(rep_number, rep_content, rep_regdate, i_number, a_id) {
			var new_li = $("<li>");
			new_li.addClass("newLi");
			new_li.attr("data-num", rep_number);
			
			var writer_p = $("<p>");
			writer_p.addClass("writer");
			writer_p.html(a_id);
			
			var date_p = $("<p>");
			date_p.addClass("date");
			date_p.html(rep_regdate);
			
			var content_p = $("<p>");
			content_p.addClass("content");
			content_p.html(rep_content);
			
			new_li.append(writer_p).append(date_p).append(content_p);
			$("#replySection").append(new_li);
		};
	</script>
	<h3>1:1문의 상세보기</h3>
	<hr />
	<table class="table">
		<tr>
			<td>작성자</td>
			<td>${ inquiryDetail.m_id }</td>
			<td>작성일</td>
			<td>${ inquiryDetail.i_date }</td>
		</tr>

		<tr>
			<td>글 제목</td>
			<td colspan="3">${ inquiryDetail.i_title }</td>
		</tr>

		<tr>
			<td>글 내용</td>
			<td colspan="3">${ inquiryDetail.i_content }
				<c:choose>
					<c:when test="${ not empty inquiryDetail.i_image }">
						<img src="/uploadStorage/inquiry/${ inquiryDetail.i_image }" />
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="4" id="btn1">
		</tr>
	</table>
	<div id="replySection">
		
	</div>
	<div id="btnDiv">
	<input type="button" id="back" value="목록" class="btn btn-default" />
	</div>
</body>
</html>