<%@page import="com.myneko.client.carereply.vo.CareReplyVO"%>
<%@page import="com.myneko.client.catcare.vo.CatcareVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#replycontent {
		float: left;
		width: 90%;
		height: auto;
	}
	
	#replyInsert {
		float: left;
	}
</style>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/catcareReply.css?ver=1" />
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		/* 기본 댓글 목록 불러오기 */
		var ci_number = "<c:out value='${detail.ci_number}'/>";
		listAll(ci_number);

		/* 댓글 내용 저장 */
		$("#replyInsert").click(function() {
			if (!chkData("#replycontent", "내용을"))
				return;
			else {
				var insertUrl = "/replies/replyInsert.do";
				/* 글 저장을 위한 post방식의 ajax연동 처리 */
				var rep_data = {
					"rep_content" : $("#replycontent").val(),
					"rep_id" : "<c:out value='${ m_id }' />",
					"ci_number" : "<c:out value='${ detail.ci_number }' />",
					"m_number" : $("#m_number").val()
				};
				$.ajax({
					url : insertUrl, // 전송 url
					type : "post", // 전송 시 method 방식
					data : rep_data,
					error : function() {
						alert('시스템 오류 입니다. 관리자에게 문의하세요.');
					},
					success : function(resultData) {
						if (resultData == "SUCCESS") {
							alert("댓글 등록이 완료되었습니다.");
							$("#replycontent").val("");
							listAll(ci_number);
						} else {
							alert("댓글 등록실패!");
						}
					}
				});
			}
		});

		/* 수정 클릭 시 수정 폼 출력 */
		$(document)
				.on(
						"click",
						"#update",
						function() {
							$(".reset_btn").click();
							var currLi = $(this).parents("li");
							var conText = currLi.children().eq(1).html();
							console.log("conText: " + conText);
							currLi.find("label").hide();
							var conArea = currLi.children().eq(1);

							conArea.html("");
							var data = "<textarea name='recontent' id='recontent' class='form-control' >"
									+ conText + "</textarea>";
							data += "<input type='button' class='update_btn btn btn-info' value='수정완료'>";
							data += "<input type='button' class='reset_btn btn btn-default' value='수정취소'>";
							conArea.html(data);
						});

		/* 초기화 버튼 */
		$(document).on("click", ".reset_btn", function() {
			var conText = $(this).parents("li").find("textarea").html();
			$(this).parents("li").find("label").show();
			var conArea = $(this).parents("li").children().eq(1);
			conArea.html(conText);
		});

		/* 글 수정을 위한 ajax 연동 처리 */
		$(document).on("click", ".update_btn", function() {

			var rep_number = $(this).parents("li").attr("data-num");
			var rep_content = $("#recontent").val();
			var update_data = {
				"rep_number" : rep_number,
				"rep_content" : rep_content
			};
			if (!chkData("#recontent", "댓글 내용을"))
				return;
			else {
				$.ajax({
					url : '/replies/' + rep_number + ".do",
					type : "post",
					data : update_data,
					success : function(result) {
						console.log("result: " + result);
						if (result == 'SUCCESS') {
							alert("수정 되었습니다.");
							listAll(ci_number);
						}
					}

				});
			}
		});

		/* 글 삭제를 위한 ajax 연동 처리 */
		$(document).on("click", "#delete", function() {
			var currLi = $(this).parents("li")
			replyNum = currLi.attr("data-num");

			if (confirm("선택하신 댓글을 삭제하시겠습니까?")) {
				$.ajax({
					type : 'delete',
					url : '/replies/' + replyNum + ".do",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					success : function(result) {
						console.log("result: " + result);
						if (result == 'SUCCESS') {
							alert("삭제 되었습니다.");
							listAll(ci_number);
						}
					}
				});
			} else {
				alert("삭제 되지 않았습니다.");
			}
		});
	});

	// 리스트 요청 함수
	function listAll(ci_number) {
		$("#comment_list").html("");
		var url = "/replies/all/" + ci_number + ".do";
		$.ajax({
			url : url,
			error : function() {
				return false;
			},
			success : function(data) {
				if (data != null) {
					$(data).each(function() {
						var rep_number = this.rep_number;
						var rep_content = this.rep_content;
						var rep_date = this.rep_date;
						var rep_id = this.rep_id;
						addNewItem(rep_number, rep_content, rep_date, rep_id);
					});
				} else {
					alert("댓글목록을 불러오는데 실패하였습니다!");
					return false;
				}
			}
		});
		/* $.getJSON(url, function(data) {
			console.log(data.length);

			$(data).each(function() {
				var rep_number = this.rep_number;
				var rep_content = this.rep_content;
				var rep_date = this.rep_date;
				var rep_id = this.rep_id;
				addNewItem(rep_number, rep_content, rep_date, rep_id);
			});
		}).fail(function() {
			alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
		}); */
	}
	function addNewItem(rep_number, rep_content, rep_date, rep_id) {
		// 새로운 글 추가될 li 태그 객체
		var new_li = $("<li>");
		new_li.attr("data-num", rep_number);
		new_li.addClass("comment_item");

		// 작성자 정보가 지정될 <p> 태그
		var writer_p = $("<p>");
		writer_p.addClass("writer");

		// 작성자 정보가 지정될 <p> 태그
		var name_span = $("<span>");
		name_span.addClass("name");
		name_span.html(rep_id + "님" );

		// 내용
		var content_p = $("<p>");
		content_p.addClass("con");
		content_p.html(rep_content);

		// 작성 일시
		var date_span = $("<span>");
		date_span.html(" | " + rep_date + " ");

		// 조립하기
<%
if (session.getAttribute("m_id") != null) {%> 

if($("#sessionID").val() == rep_id){
	writer_p
				.append(name_span)
				.append(date_span)
				.append('<label id="update">&nbsp;&nbsp;수정&nbsp;</label><label id="delete">|&nbsp;삭제</label>')
		new_li.append(writer_p).append(content_p);
		$("#comment_list").append(new_li);
}else{
	writer_p.append(name_span).append(date_span)
	new_li.append(writer_p).append(content_p);
	$("#comment_list").append(new_li);
}

<%} else {%>
	writer_p.append(name_span).append(date_span)
		new_li.append(writer_p).append(content_p);
		$("#comment_list").append(new_li);
<%}%>

	}

	function chkData(item, msg) {
		if ($(item).val().replace(/\s/g, "") == "") {
			alert(msg + " 입력해 주세요.");
			$(item).val("");
			$(item).focus();
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<hr width="880px" align="left" />
	<div id="replyarea">
		<%
			if (session.getAttribute("m_id") != null) {
		%>
		<table>
			<tr>
				<td><input type="hidden" id="sessionID"
					value="<%=session.getAttribute("m_id")%>">
					&nbsp;${sessionScope.m_id }님
					<input type="hidden" id="m_number" name="m_number" value="<%= session.getAttribute("m_number") %>" />
					</td>
			</tr>
			<tr>
				<td><textarea id="replycontent" rows="3" cols="110"
						placeholder="댓글 내용을 입력하세요." name="rep_content" class="form-control"></textarea>
					<button type="button" id="replyInsert" class="btn btn-default">등 록</button></td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table>
			<tr>
				<td>댓글작성은 로그인한 회원만 가능합니다.</td>
			</tr>
		</table>
		<%
			}
		%>
	</div>
	<ul id="comment_list">

	</ul>
</body>
</html>