<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<style type="text/css">
.form-control {
	width: 25%;
	float: left;
}

.label {
	float: left;
	color: black;
}

.paginate {
	text-align: center;
}
</style>
<script type="text/javascript">
	var d = new Date();

	var s = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2);
	console.log(s);

	$(document).ready(function() {
		if ("<c:out value='${data.pageSize}' />" != "") {
			$("#pageSize").val("<c:out value='${data.pageSize}' />");
		}

		if ('${data.firstDate}' != '') {
			$("#firstDate").attr({
				"min" : "1990-01-01",
				"max" : "2100-12-31",
				"value" : "${data.firstDate}"
			})

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : "${data.lastDate}"
			})

		} else {
			$("#firstDate").attr({
				"min" : "1990-01-01",
				"max" : "2100-12-31",
				"value" : "1990-01-01"
			})

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : s
			})
		}
		$("#firstDate").change(function() {
			if ($("#firstDate").val() > $("#lastDate").val()) {
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
					"value" : $("#firstDate").val()
				})
			} else {
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
				})
			}
		})

		$("#lastDate").change(function() {
			if ($("#lastDate").val() < $("#firstDate").val()) {
				alert("이전날자의 이전시간으로 설정할 수 없습니다.");
				$("#lastDate").val($("#firstDate").val())
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
				})
			}
		})

		$("#searchBtn").click(function() {
			$("#searchBtn") > $("input[name='page']").val('1');
			$("#searchForm").attr({
				"method" : "GET",
				"action" : "/admin/memberList.do"
			})
			$("#searchForm").submit();
		})
		$("#searchAll").click(function() {
			$("#firstDate").val("");
			$("#lastDate").val("");
			$("#searchForm").attr({
				"method" : "GET",
				"action" : "/admin/memberList.do"
			});
			$("#searchForm").submit();
		});
	})

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}

	function goPage(page) {
		$("#page").val(page);
		$("#optionForm").attr({
			"method" : "get",
			"action" : "/admin/memberList.do"
		});
		$("#optionForm").submit();
	}
</script>
</head>
<body>
	<h3>회원관리</h3>

	<div id="memberManage">
		<form id="optionForm">
			<input type="hidden" id="page" name="page" value="${data.page}" /> <input
				type="hidden" id="pageSize" name="pageSize" value="${data.pageSize}">
		</form>
		<form id="searchForm">
			<input type="date" id="firstDate" name="firstDate" class="form-control"><label class="label">~</label><input
				type="date" id="lastDate" name="lastDate" class="form-control"> <input
				type="hidden" id="page_search" name="page" value="${data.page}" />
			<input type="hidden" id="pageSize_search" name="pageSize"
				value="${data.pageSize}">
			<button type="button" id="searchBtn" name="searchBth" class="btn btn-default">검색</button>
			<button type="button" id="searchAll" name="searchAll" class="btn btn-default">전체</button>
		</form>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>가입일</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>연락처</th>
					<th>상태</th>
				</tr>
				<c:choose>
					<c:when test="${not empty memberList}">
						<c:forEach var="list" items="${memberList}">
							<tr>
								<td>${list.m_number }</td>
								<td><fmt:formatDate value="${ list.m_register }" pattern="yyyy/MM/dd" /></td>
								<td>${list.m_id }</td>
								<td>${list.m_email }</td>
								<td>${list.m_phone }</td>
								<td>${list.m_state }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">회원 정보가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
		</table>
		<div class="paginate">
			<tag:paging page="${param.page}" total="${total}"
				list_size="${data.pageSize}" />
		</div>
	</div>
</body>
</html>