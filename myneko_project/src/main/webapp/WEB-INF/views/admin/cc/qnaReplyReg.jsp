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
	table {
		width: 70%;
	}
	td, th {
		text-align: center;
	}
	
	.btn {
		padding-top: 0px;
		font-size: 10pt;
		height: 20px;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#repRegBtn").click(function() {
			if ($("#rep_content").val() == '' || $("#rep_content").val() == null) {
				alert("답변내용을 입력해주세요!");
				return false;
			} else {
				var rep_content = $("#rep_content").val();
				var i_number = "<c:out value='${ param.i_number }' />";
				var a_id = $("#a_id").val();
				var data = {
					"rep_content" : rep_content,
					"i_number" : i_number,
					"a_id" : a_id
				};
				$.ajax({
					url : "/admin/reply/insertReply.do",
					type : "post",
					data : data,
					error : function() {
						alert("네트워크 에러로 등록하지못했습니다. 잠시후에 다시 시도해주세요!");
					},
					success : function(result) {
						if (result == 1) {
							alert("성공적으로 등록되었습니다!");
							location.href="/admin/qna/getQnaDetail.do?i_number=${ param.i_number }";
						} else {
							alert("네트워크 에러로 등록하지못했습니다. 잠시후에 다시 시도해주세요!");
						}
					}
				});
			}
		});
		$("#cancel").click(function() {
			location.href="/admin/qna/getQnaDetail.do?page=${param.page}&pageSize=10&i_number=${param.i_number}";
		});
	});
</script>
</head>
<body oncontextmenu="return false">
	<h3>1 : 1 문의 답변등록</h3>
	<div class="table-reponsive">
		<table class="table table-bordered">
			<tr>
				<th class="tac" width="30%">문의자</th>
				<td class="tac" width="70">${ qnaDetail.m_id }</td>
			</tr>
			<tr>
				<th class="tac" width="30%">문의일자</th>
				<td class="tac" width="70%"><fmt:formatDate value="${ qnaDetail.i_date }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
			</tr>
			<tr>
				<th class="tac" width="30%">문의내용</th>
				<td class="tac" width="70%">${ qnaDetail.i_content }</td>
			</tr>
		</table>
	</div>
	<div class="table-reponsive">
		<input type="hidden" id="i_number" name="i_number" value="${ param.i_number }" />
		<table class="table table-bordered">
				<tr>
					<th class="tac" width="30%">답변자</th>
					<td class="tac" width="70%"><input type="text" id="a_id" name="a_id" value="<%= session.getAttribute("adminId") %>" readonly="readonly" class="form-control" />
				</tr>
				<tr>
					<th class="tac" width="30%">답변내용</th>
					<td class="tac" width="70%"><textarea id="rep_content" name="rep_content" cols="100" rows="20" class="form-control"></textarea></td>				
				</tr>
				<tr>
					<td colspan="2" class="tac" align="center">
						<input type="button" id="repRegBtn" name="repRegBtn" value="답변등록" class="btn btn-info" />
						<input type="button" id="cancel" name="cancel" value="취소" class="btn btn-info" />
					</td>
				</tr>
		</table>
	</div>
</body>
</html>