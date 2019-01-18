<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>
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
<script>
	$(document).ready(function() {
		history.pushState(null, null, location.href);
		window.onpopstate = function(event) {
			history.go(1);
		}
		var adminId = "<c:out value='adminId' />";
		if (adminId == null || adminId == '') {
			location.href="/admin/adminLogin.do";
		}
		checkCode("<c:out value='code' />");
		$(".goDetail").click(function() {
			var o_number = $(this).attr("data-num");
			location.href="/admin/order/orderDetail?o_number="+o_number;
		});
		$("#searchBtn").click(function() {
			$("#searchForm").attr({
				"action" : "/admin/order/getOrderList.do",
				"method" : "get"
			});
			$("#searchForm").submit();
		});
		$(".update").click(function() {
			if (confirm("주문상태를 수정하시겠습니까?") == true) {
				var o_state = $("#od_state").val();
				var o_number = $(this).parents("td").attr("data-num");
				var o_amount = $("#oAmountMod").val();
				var page = "<c:out value='${param.page}' />";
				var pageSize = "<c:out value='${param.pageSize}' />";
				var p_number = $("#p_number").val();
				var data = {
					"o_state" : o_state,
					"o_number" : o_number,
					"o_amount" : o_amount,
					"p_number" : p_number,
					"page" : page,
					"pageSize" : pageSize
				};
				$.ajax({
					url : "/admin/order/orderStateMod.do",
					type : "post",
					data : data,
					error : function() {
						alert("수정 실패하였습니다. 다시 시도해주세요!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("수정 성공!");
							location.href="/admin/order/getOrderList.do";
						} else {
							alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						}
					} 
				});
				/* $("#o_state").val($("#od_state").val());
				$("#o_number").val($("#oStateMod").attr("data-num"));
				
				$("#orderForm").attr({
					"method" : "POST",
					"action" : "/admin/order/orderStateMod.do"
				});
				
				$("#orderForm").submit(); */
			}
		});
	});
	
	function checkCode(code) {
		if (code == 1) {
			alert("주문상태 수정 실패! 잠시후에 다시 시도해주세요..");
		};
	};
	
	function goPage(page) {
		$("#page").val(page);
		$("#searchForm").attr({
			"method" : "get",
			"action" : "/admin/order/getOrderList.do"
		});
		$("#searchForm").submit();
	}
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
</script>
<style>
	.form-control {
		width: 25%;
		float: left;
	}
	
	label {
		float: left;
	}
</style>
</head>
<body oncontextmenu="return false">
	<h3>주문관리</h3>
	<div class="table-responsive">
		<form id="searchForm" name="searchForm">
			<input type="hidden" id="page" name="page" value="${ data.page }" />
			<input type="hidden" id="pageSize" name="pageSize" value="10" />
			<input type="text" id="keyword" name="keyword" value="${ data.keyword }" class="form-control" />
			<input type="date" id="firstDate" name="firstDate" value="${ data.firstDate }" class="form-control" />
			<label>~</label>
			<input type="date" id="lastDate" name="lastDate" value="${ data.lastDate }" class="form-control" />
			<input type="button" id="searchBtn" value="검색" class="btn btn-default" />
		</form>
		<form id="orderForm" name="orderForm">
			<input type="hidden" id="o_state" name="o_state" />
			<input type="hidden" id="o_number" name="o_number" />
		<table class="table table-striped">
			<thead>
				<tr>
					<th class="tac">주문번호</th>
					<th class="tac">주문자</th>
					<th class="tac">주문일자</th>
					<th class="tac">주문총액</th>
					<th class="tac">결제수단</th>
					<th class="tac">주문상태</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ not empty orderList }">
						<c:forEach var="order" items="${ orderList }" varStatus="status">
							<tr class="tac">
								<td class="goDetail" data-num="${ order.o_number }">${ order.o_number }</td>
								<td>${ order.o_name }</td>
								<td><fmt:formatDate value="${ order.o_date }" pattern="yyyy-MM-dd" /></td>
								<td>${ order.o_totalprice }</td>
								<c:choose>
									<c:when test="${ order.o_paywith == 'phone' }">
										<td>휴대전화</td>
									</c:when>
									<c:otherwise>
										<td>신용카드</td>
									</c:otherwise>
								</c:choose>
								<td data-num="${ order.o_number }">
									<font>${ order.o_state }</font>
									<c:choose>
										<c:when test="${ order.o_state == '주문취소' }">
										</c:when>
										<c:when test="${ order.o_state == '결제완료' }">
											<select id="od_state" class="form-control">
												<option value="주문취소">주문취소</option>
												<option value="배송준비중">배송준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
											</select>
											<input type="button" class="btn btn-info update" value="수정" />
										</c:when>
										<c:when test="${ order.o_state == '배송준비중' }">
											<select id="od_state" class="form-control">
												<option value="주문취소">주문취소</option>
												<option value="배송준비중">배송준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
											</select>
											<input type="button" class="btn btn-info" value="수정" />
										</c:when>
										<c:when test="${ order.o_state == '배송중' }">
											<select id="od_state" class="form-control">
												<option value="배송준비중">배송준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
											</select>
											<input type="button" class="btn btn-info" value="수정" />
										</c:when>
										<c:when test="${ order.o_state == '배송완료' }">
											<sub>배송완료 시점부터 주문상태 변경은 고객만 가능함</sub>
										</c:when>
										<c:when test="${ order.o_state == '구매확정' }">
											<sub>구매확정 시 주문상태 변경은 고객만 가능함</sub>
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="8" class="tac" align="center">
								등록된 주문정보가 존재하지 않습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</form>
		<div id="orderPage">
			<tag:paging page="${ param.page }" total="${ total }" list_size="10" />
		</div>
	</div>
</body>
</html>