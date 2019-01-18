<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 페이지</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<style>
	#btnDiv {
		text-align: center;
	}
	
	.updateContent {
		width: 65%;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#goToList").click(function() {
			location.href="/boast/boardList";
		});
		var param = "<c:out value='${detail.b_number}' />";
		listAll(param);
		$(document).on("click", ".delete", function() {
			var data = {
				br_number : $(this).parents("li").attr("data-num")	
			};
			if (confirm("정말 삭제하시겠습니까?")) {
				$.ajax({
					url : "/boast/replies/replyDelete",
					type : "get",
					data : data,
					error : function() {
						alert("삭제 실패!");
						return;
					},
					success : function(result) {
						if (result == 1) {
							alert("삭제 성공!");
							$("#replySection").children("li").remove();
							listAll("<c:out value='${detail.b_number}' />");
						} else {
							alert("삭제 실패!");
							return;
						}
					}
				});
			}
		});
		$(document).on("click", ".update", function() {
			
			$(this).hide();
			
			var updateForm = $("<div>");
			updateForm.addClass("updateForm");
			
			var updateContent = $("<textarea>");
			updateContent.addClass("form-control");
			updateContent.addClass("updateContent");
			updateContent.attr("rows", "5");
			updateContent.attr("cols", "80");
			
			var updateBtn = $("<input>");
			updateBtn.addClass("btn");
			updateBtn.addClass("btn-info");
			updateBtn.addClass("modifyBtn");
			updateBtn.attr("type", "button");
			updateBtn.attr("value", "수정");
			
			updateForm.append(updateContent).append(updateBtn);
			
			$(this).parents("li").append(updateForm);
		});
		$("#replyInsert").click(function() {
			if($("#br_content").val() == '') {
				alert("댓글 내용을 입력해주세요!");
				return;
			} else {
				var repData = {
					"br_content" : $("#br_content").val(),
					"b_number" : "<c:out value='${detail.b_number}' />",
					"m_number" : "<c:out value='${m_number}' />"
				};
				$.ajax({
					url : "/boast/replies/replyInsert",
					type : "post",
					data : repData,
					error : function() {
						alert("등록 실패!");
						return;
					},
					success : function(result) {
						if (result == "<c:out value='${detail.b_number}' />") {
							alert("등록 성공!");
							$("#replySection").children("li").remove();
							listAll("<c:out value='${detail.b_number}' />");
							$("#br_content").val("");
						} else {
							alert("등록 실패!");
							return;
						}
					}
				});
			}
		});
		$("#updateBtn").click(function() {
			location.href="/boast/boastUpdate?b_number=${detail.b_number}";
		});
		$("#deleteBtn").click(function() {
			var data = {
				"b_number" : "<c:out value='${detail.b_number}' />"	
			};
			if(confirm("정말 삭제하시겠습니까? 댓글도 모두 삭제됩니다.")) {
				$.ajax({
					url : "/boast/boastDelete",
					type : "get",
					data : data,
					error : function() {
						alert("삭제 실패!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("삭제 성공!");
							location.href="/boast/boardList";
						} else {
							alert("삭제 실패!");
							return false;
						}
					}
				});
			}
		});
		$(document).on("click", ".modifyBtn", function() {
			if ($(".updateContent").val() == '') {
				alert("수정하실 댓글 내용을 입력해주세요!");
				return false;
			} else {
				var repUpData = {
					"br_content" : $(".updateContent").val(),
					"br_number" : $(this).parents("div").parents("li").attr("data-num")
				};
				$.ajax({
					url : "/boast/replies/replyUpdate",
					type : "post",
					data : repUpData,
					error : function() {
						alert("수정 실패!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("수정 성공!");
							$("#replySection").children("li").remove();
							listAll("<c:out value='${detail.b_number}' />");
						} else {
							alert("수정 실패!");
							return false;
						}
					}
				});
			}
		});
	});
	function listAll(b_number) {
		$.ajax({
			url : "/boast/replies/replyList/${detail.b_number}",
			type : "get",
			error : function() {
				alert("댓글목록을 불러오는 데 실패하였습니다.");
				return;
			},
			success : function(result) {
				if (result != null) {
					$(result).each(function() {
						var br_number = this.br_number;
						var br_content = this.br_content;
						var br_date = this.br_date;
						var m_id = this.m_id;
						addItem(br_number, br_content, br_date, m_id);
					});
				}
			}
		});
	};
	function addItem(br_number, br_content, br_date, m_id) {
		var new_li = $("<li>");
		new_li.attr("data-num", br_number);
		new_li.addClass("comment_item");
		
		var writer_p = $("<p>");
		writer_p.addClass("writer");
		
		var name_span = $("<span>");
		name_span.addClass("name");
		name_span.html(m_id+"님");
		
		var content_p = $("<p>");
		content_p.addClass("con");
		content_p.html(br_content);
		
		var date_span = $("<span>");
		date_span.html(" | " + br_date + " ");
		
		if ("<c:out value='${m_id}' />" == m_id) {
			writer_p.append(name_span).append(date_span).append("<label class='update'>&nbsp;&nbsp;수정&nbsp;&nbsp;</label><label class='delete'>&nbsp;&nbsp;삭제&nbsp;&nbsp;</label>");
			new_li.append(writer_p).append(content_p);
			$("#replySection").append(new_li);
		} else {
			writer_p.append(name_span).append(date_span);
			new_li.append(writer_p).append(content_p);
			$("#replySection").append(new_li);
		}
		
	}
</script>
</head>
<body>
<h3>정보공유/자랑 글 상세보기</h3>
<div class="table-responsive">
	<table class="table">
		<tr>
			<th class="tac">제목</th>
			<td class="tac">${ detail.b_title }</td>
		</tr>
		<tr>
			<th class="tac">작성자</th>
			<td class="tac">${ detail.m_id }</td>
		</tr>
		<tr>
			<th class="tac">작성일</th>
			<td class="tac"><fmt:formatDate value="${ detail.b_date }" pattern="yyyy-mm-dd" /></td>
		</tr>
		<tr>
			<th class="tac">내용</th>
			<td class="tac">${ detail.b_content }
				<c:choose>
					<c:when test="${ not empty detail.b_image }">
						<br />
						<img src="/uploadStorage/boast/${ detail.b_image }" />
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	<c:choose>
		<c:when test="${ m_id == detail.m_id }">
			<div id="btnDiv">
				<input type="button" id="updateBtn" value="수정" class="btn btn-info" />
				<input type="button" id="deleteBtn" value="삭제" class="btn btn-danger" />
			</div>
		</c:when>
		<c:otherwise>
			<div id="btnDiv">
				작성자 본인만 수정 / 삭제가 가능합니다.
			</div>
		</c:otherwise>
	</c:choose>
	<div id="btnDiv">
		<input type="button" id="goToList" value="목록으로" class="btn btn-default" />	
	</div>
	<br />
	<c:choose>
		<c:when test="${ not empty m_id }">
			<div class="table-responsive" id="reply">
				<table class="table">
					<tr>
						<th class="tac">${ m_id }님</th>
					</tr>
					<tr>
						<td class="tac"><input type="button" id="replyInsert" value="댓글등록" class="btn btn-default" /><textarea cols="80" rows="5" id="br_content" name="br_content" class="form-control"></textarea></td>
					</tr>
				</table>
			</div>		
		</c:when>
		<c:otherwise>
			<tr>
				<th align="center">
				<a href="/member/login">로그인 한 회원만 댓글을 작성할 수 있습니다.
				먼저 로그인 해 주세요!</a>
				</th>
			</tr>
		</c:otherwise>
	</c:choose>
	<div class="table-responsive" id="replySection">
		
	</div>
</div>
</body>
</html>