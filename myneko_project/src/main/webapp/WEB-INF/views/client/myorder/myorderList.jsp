<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" uri="../../../tld/custom_tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<meta charset="UTF-8">
<title>나의 주문내역</title>
<style>
	#myorderPage {
		text-align: center;
	}
	
	.on {
		text-decoration: none;
		color: black;
		font-size: 15pt;
	}
	
	a:hover {
		text-decoration: none;
		color: black;
	}
	
	a:link {
		text-decoration: none;
		color: black;
	}
	
	a:visited {
		text-decoration: none;
		color: black;
	}
	
	a:active {
		text-decoration: none;
		color: black;
	}
</style>
</head>
<body>
	<script type="text/javascript">
		//한페이지에 보여줄 레코드 수 페이징을 위한 실질적인 처리 함수
		function goPage(page) {
			$("#page").val(page);
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/myorder/myorderList"
			});
			$("#detailForm").submit();
		}
		$(document).ready(function() {
			$(".review").click(function(){
				var o_number = $(this).attr("data-num");
				location.href="/review/reviewWriteForm?o_number="+o_number;
			});
			$(".ok").click(function() {
				if ($(this).parents("td").children("select").val() == '반품') {
					if (confirm("반품처리 하시겠습니까?")) {
						var data = {
								"o_state" : "반품",
								"o_number" : $(this).attr("data-num")
							};
						$.ajax({
							url : "/myorder/orderCancel",
							type : "post",
							data : data,
							error : function() {
								alert("반품처리 실패했습니다.");
								return false;
							},
							success : function(result) {
								if (result == 1) {
									alert("반품처리 완료되었습니다.");
									location.reload();
								} else {
									alert("반품처리 실패했습니다.");
									return false;
								}
							}
						});
					} else {
						return false;
					}
				} else if ($(this).parents("td").children("select").val() == '구매확정') {
					if (confirm("구매확정 하시겠습니까? 구매확정 시 결제금액의 10%를 마일리지로 환급해드립니다.")) {
						var o_milage = ($(this).parents("td").attr("data-num") - 3000) / 10;
						var o_number = $(this).attr("data-num");
						var data = {
							"o_milage" : o_milage,
							"o_state" : "구매확정",
							"o_number" : o_number
						};
						$.ajax({
							url : "/myorder/oStateChange",
							type : "post",
							data : data,
							error : function() {
								alert("네트워크 에러! 관리자에게 문의해주세요!");
								return false;
							},
							success : function(result) {
								if (result == 1) {
									alert("구매확정 성공!" + o_milage + "마일리지가 적립되었습니다.");
									location.reload();
								} else {
									alert("구매확정 실패! 관리자에게 문의해주세요!");
									return false;
								}
							}
						});
					} else {
						return false;
					}
				}
			});
			$(".orderCancel").click(function() {
				if (confirm("주문을 취소하시겠습니까?")) {
					var data = {
							"o_state" : "주문취소",
							"o_number" : $(this).attr("data-num")
						};
						$.ajax({
							url : "/myorder/orderCancel",
							type : "post",
							data : data,
							error : function() {
								alert("주문취소에 실패하였습니다.");
								return false;
							},
							success : function(result) {
								if (result == 1) {
									alert("주문취소가 완료되었습니다.");
									location.reload();
								} else {
									alert("주문취소에 실패하였습니다.");
									return false;
								}
							}
						});					
				} else {
					return false;
				}
			});
		});
	</script>
	<div class="contentContainer">
		<div class="contentTit">
			<h2>나의 주문내역</h2>
			<p>주문/배송내역 집사님의 주문내역을 확인 하실 수 있습니다.</p>
			<p>-상세보기 버튼을 클릭하시면, 주문 상세내역을 확인 할 수 있습니다.</p>
			<p>-간략내역보기 에서 상품 후기를 작성 하실 수 있습니다.</p>
		</div>


		<form name="detailForm" id="detailForm">
			<input type="hidden" name="m_number" id="m_number"
				value="<%=session.getAttribute("m_number")%>"> <input
				type="hidden" id="page" name="page" value="${data.page }">
		</form>
		<div id="myorderList">
			<table summary="나의 주문 내역" class="table">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th data-value="o_date">주문일자</th>
						<th>주문번호</th>
						<th>결제금액</th>
						<th>배송료</th>
						<th>배송현황</th>
					</tr>
				</thead>
				<tbody id="list">
					<c:choose>
						<c:when test="${not empty myorderList }">
							<c:forEach items="${myorderList}" var="myorder"
								varStatus="status">
								<tr>
									<td>${myorder.o_date}</td>
									<td>${myorder.o_number }<br> <a
										href="/myorder/myorderDetail?o_number=${myorder.o_number}">[상세보기]</a>
									</td>
									<td>${myorder.o_totalprice}</td>
									<td><input type="hidden" value="3000">
										<p>3000</p></td>
									<c:choose>
										<c:when test="${ myorder.o_state == '결제완료' }">
											<td>${myorder.o_state }<input type="button" data-num="${ myorder.o_number }" value="주문취소" class="btn btn-danger orderCancel" /></td>
										</c:when>
										<c:when test="${ myorder.o_state == '배송준비중' }">
											<td>${myorder.o_state }<input type="button" data-num="${ myorder.o_number }" value="주문취소" class="btn btn-danger orderCancel" /></td>
										</c:when>
										<c:when test="${ myorder.o_state == '배송완료' }">
											<td data-num=${ myorder.o_totalprice }>${myorder.o_state }
												<select class="od_state">
													<option value="반품">반품</option>
													<option value="구매확정">구매확정</option>
												</select>
												<input type="button" class="btn btn-info ok" data-num="${ myorder.o_number }" value="확인" />
											</td>
										</c:when>
										<c:when test="${ myorder.o_state == '구매확정' }">
											<td>${ myorder.o_state }
											<input type="button" class="btn btn-info review" data-num="${ myorder.o_number }" value="리뷰작성" /></td>
										</c:when>
										<c:otherwise>
											<td>${ myorder.o_state }</td>
										</c:otherwise>
									</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td>등록 된 주문이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div id="myorderPage">
			<tag:paging page="${param.page}" total="${total}" list_size="5" />
		</div>
	</div>
</body>
</html>