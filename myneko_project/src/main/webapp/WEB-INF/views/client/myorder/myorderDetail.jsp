<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#goToList").click(function() {
							location.href = "/myorder/myorderList";
						});
						$("#orderCancel")
								.click(
										function() {
											location.href = "/myorder/myorderDelete?o_number=${myorderDetail.o_number}";
										});
					});
</script>
<style>
.myorderListBtn {
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="table-responsive">
		<h4>상세보기 페이지</h4>
		<p>주문/배송내역 집사님의 주문내역을 확인 하실 수 있습니다.</p>
		<form name="o_data" id="o_data" method="POST">
			<input type="hidden" name="o_number"
				value="${myorderDetail.o_number }" />
		</form>
		<div class="contentTB">
			<table class="table">
				<thead>
					<tr>
						<td>상품정보</td>
						<td>가격</td>
						<td>수량</td>
						<td>마일리지</td>
						<td>결제금액</td>
						<td>상태</td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty myorderDetail }">

							<c:forEach var="findProduct" items="${findProduct}"
								varStatus="status">
								<tr>
									<td>${findProduct.p_name}</td>
									<td>${findProduct.po_price}<input type="hidden" id="price"
										value="${findProduct.po_price}"></td>
									<td>${findProduct.po_amount }<input type="hidden"
										id="amount" value="${findProduct.po_amount }"></td>
									<td id="milage">${findProduct.po_price / 10}</td>
									<td id="totalprice">${findProduct.po_price * findProduct.po_amount }</td>
									<td><input type="hidden">
										<p>${ findOrder.o_state }</p></td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>

			</table>
			<div class="contentHeader">
				<h4>결제 금액</h4>
				<table class="table">
					<tr>
						<td>배송료</td>
						<td>3000</td>
					</tr>
					<tr>
						<td>마일리지 사용</td>
						<td>0</td>
					</tr>
					<tr>
						<td>총 주문합계 금액</td>
						<td><c:set var="total" value="0" /> <c:forEach var="result"
								items="${resultList}" varStatus="status">
								<tr>
									<td>${result.num}
									<td>
								</tr>
								<c:set var="total" value="${total + result.num}" />
							</c:forEach> <c:out value="${total}" /></td>
					</tr>
				</table>
			</div>

			<div class="contentHeader">
				<h4>주문서 정보</h4>
				<table class="table">
					<thead>
						<tr>
							<td>주문번호</td>
							<td>${findOrder.o_number}</td>
						</tr>
						<tr>
							<td>주문일</td>
							<td>${findOrder.o_date}</td>
						</tr>
						<tr>
							<td>주문상태</td>
							<td>${findOrder.o_state}</td>
						</tr>
					</thead>
				</table>
			</div>

			<div class="contentHeader">
				<h4>주문자 정보</h4>
				<table class="table">
					<thead>
						<tr>
							<td>이름</td>
							<td>${findMember.m_name}</td>
						</tr>
						<tr>
							<td>휴대폰</td>
							<td>${findMember.m_phone }</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${findMember.m_email }</td>
						</tr>
					</thead>
				</table>
			</div>
			<div class="contentHeader">
				<h4>배송지 정보</h4>
				<table class="table">
					<thead>
						<tr>
							<td>이름</td>
							<td>${findMember.m_name }</td>
						</tr>
						<tr>
							<td>휴대폰</td>
							<td>${findMember.m_phone }</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${findMember.m_email }</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>${findMember.m_address }</td>
						</tr>
				</table>
			</div>

			<div class="contentHeader">
				<h4>결제 수단</h4>
				<table class="table">
					<tr>
						<td>결제방식</td>
						<c:choose>
							<c:when test="${ myorderDetail.o_paywith == 'phone' }">
								<td>휴대전화</td>
							</c:when>
							<c:otherwise>
								<td>신용카드</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</div>
		</div>
		<div class="myorderListBtn">
			<input type="button" name="orderCancel" id="orderCancel" value="주문취소"
				class="btn btn-danger"> <input type="button"
				name="orderModify" id="orderModify" class="btn btn-info"
				value="배송지정보수정"> <input type="button" name="goToList"
				id="goToList" class="btn btn-default" value="전체내역보기" />
		</div>
	</div>
</body>
</html>