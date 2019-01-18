<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<%-- <%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String adminId = (String) session.getAttribute("adminId");
	if (adminId == null || adminId == "") {
%>
<script>
	location.href="/admin/adminLogin.do";
</script>
<%
	}
%>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/common.js"></script>
<script>
	$(document).ready(function() {
		history.pushState(null, null, location.href);
		window.onpopstate = function(event) {
			history.go(1);
		}
		var adminId = "<c:out value='${adminId}' />";
		if (adminId == null || adminId == '') {
			location.href="/admin/adminLogin.do";
		}
		$("#goList").click(function() {
			location.href="/admin/order/getOrderList.do";	
		});
		$(document).keydown(function(e) {
			key = (e) ? e.keyCode : event.keyCode;
			
			var t = $(document).activeElement;
			if (key == 8 || key == 116 || key == 17 || key == 82) {
				if (key == 8) {
					if (t.tagName != "INPUT" || t.tagName != "input") {
						if (e) {
							e.preventDefault();
						} else {
							event.keyCode = 0;
							event.returnValue = false;
						}
					}
				} else {
					if (e) {
						e.preventDefault();
					} else {
						event.keyCode = 0;
						event.returnValue = false;
					}
				}
			}
		});
	});
</script>
<style>
.form-control {
	width: 15%;
	float: left;
}

label {
	float: left;
}
#btnDiv {
	text-align: center;
}
</style>
</head>
<body oncontextmenu="return false">
	<h3>주문관리</h3>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th class="tac">상품명</th>
					<th class="tac">상품개별가격</th>
					<th class="tac">주문수량</th>
					<th class="tac">결제금액</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="detail" items="${ orderDetail }" varStatus="status">
					<tr>
						<td>${ detail.p_name }</td>
						<td>${ detail.po_price }</td>
						<td>${ detail.po_amount }</td>
						<td>${ detail.po_price * detail.po_amount }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table class="table">
			<tr>
				<th>수취인 성명</th>
				<td>${ oDetail.o_name }</td>
			</tr>
			<tr>
				<th>수취인 연락처</th>
				<td>${ oDetail.o_phone }</td>
			</tr>
			<tr>
				<th>수취인 우편번호</th>
				<td>${ oDetail.o_zipcode }</td>
			</tr>
			<tr>
				<th>수취인 주소</th>
				<td>${ oDetail.o_address }</td>
			</tr>
		</table>
	</div>
	<div id="btnDiv">
		<input type="button" id="goList" value="목록으로" class="btn btn-default" />
	</div>
</body>
</html>