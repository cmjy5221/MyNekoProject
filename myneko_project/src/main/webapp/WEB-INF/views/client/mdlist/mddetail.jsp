<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MD DETAIL</title>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/mdlist.css" />
<link rel="stylesheet" type="text/css" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/resources/include/css/bootstrap.min.css" />
<style>
	.inqurybtn {
		text-align: center;
	}
	
	#mdimage {
		display: block;
	}
</style>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {

		// 썸네일 이미지파일을 보여주기 위한 속성 추가
		var mdimage = "<c:out value='${mddetail.p_image}' />";
		var detailimg = "<c:out value='${mddetail.p_detailimage}' />";
		if (mdimage != "") {
			$("#mdimage").attr({
				src : "/uploadStorage/product/image/${mddetail.p_image}",
				width : "600px", //썸네일 사이즈는 나중에 회의 후 수정할 것
				height : "600px"
			});
		}
		if (detailimg != "") {
			$("#detailimage").attr({
				src : "/uploadStorage/product/detail/${mddetail.p_detailimage}"
			});
		}

		//수량 변했을때마다 총가격과 적립예상마일리지 값이 변화됨
		// mddetail.p_price 곱하기 #orderamount 
		// mddetail.p_price 곱하기 #orderamount 곱하기 0.1
		$("#orderamount")
				.change(
						function() {

							var amount = $("#orderamount").val();
							var price = "<c:out value='${mddetail.p_price}' />";

							var totalprice = amount * price;
							//$("#totalprice").val(totalprice);

							var maybesavemileage = totalprice * 0.1;
							//$("#maybesavemileage").val(maybesavemileage);

							document.getElementById("totalprice").innerHTML = totalprice;
							document.getElementById("maybesavemileage").innerHTML = maybesavemileage;
						});

		// 바로구매하기 버튼
		$("#buynow").click(
				function() {

					if ($("#m_number").val() == '') {
						alert("로그인이 필요합니다");
						location.href = "/member/login";
						return false;
					} else if ($("#orderamount").val().replace(/\s/g, "") == ""
							|| $("#orderamount").val() == 0) {
						alert("구매개수를 확인해주세요");
						$("#orderamount").focus();
						return false;
					} else {
						$("#ct_amount").val($("#orderamount").val());
						$("#p_price").val('${mddetail.p_price}');
						$("#p_name").val('${mddetail.p_name}');
						$("#nowbuyForm").attr({
							action : "/cart/onePayment",
							method : "get"
						});
						$("#nowbuyForm").submit();

					}
				});

		// 장바구니담기 버튼
		$("#inshoppingcart").click(function() {
			var ctamount = $("#orderamount").val();
			console.log(ctamount);
			var pnumber = $("#p_number").val();
			console.log(pnumber);
			var mnumber =
<%=session.getAttribute("m_number")%>
	;

			if (mnumber == null) {
				//로그인이 되어있지 않으면
				alert("장바구니를 이용하려면 로그인 해야합니다\n로그인 페이지로 이동합니다");
				location.href = "/member/login";
			} else if (!chkAmount("#orderamount", "구매 수량을")) {
				//ct_amount 의 값이 0가 아닌지 확인한다
				return;
			} else {
				$.ajax({
					url : "/cart/insert.do",
					type : "post",
					headers : {
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						p_number : pnumber,
						ct_amount : ctamount,
						m_number : mnumber
					}),
					error : function() {
						alert("오류가 발생되어 장바구니에 해당상품을 담지 못했습니다\n관리자에게 문의하세요");
					},
					success : function(result) {
						console.log(result);
						if (result == "SUCCESS") {
							alert("장바구니에 해당 상품을 담았습니다");
						} else {
							alert("이미 장바구니에 들어있는 상품입니다\n장바구니를 확인해주세요")
						}
					}
				});
			}
		});

		//ct_amount의 값이 0인지 아닌지 확인하는 함수 chkAmount
		function chkAmount(item, msg) {
			if ($(item).val().replace(/\s/g, "") == "") {
				alert(msg + " 확인해주세요");
				$(item).val("");
				$(item).focus();
				return false;
			} else if ($(item).val() == 0) {
				alert(msg + " 확인해주세요");
				$(item).focus();
			} else {
				return true;
			}
		}

		//1:1문의 버튼
		$(".btninquryatmd").click(function() {
			location.href = "/client/inquiry/CIinsert";
		});

	});
</script>
</head>
<body>

	<div class="content1 detail">

		<div id="detailheader" class="detailheader">

			<!-- 상품이름 -->
			<h3>${ mddetail.p_name }</h3>
			<form name="f_data" id="f_data" method="post">
				<input type="hidden" id="m_number" name="m_number"
					value="${ m_number }" />
			</form>

			<form id="nowbuyForm">
				<input type="hidden" id="ct_amount" name="ct_amount"> <input
					type="hidden" id="p_name" name="p_name"
					value="${ mddetail.p_name }"> <input type="hidden"
					id="p_price" name="p_price" value="${ mddetail.p_price }">
				<input type="hidden" id="p_number" name="p_number"
					value="${mddetail.p_number}" />
			</form>

			<!-- 디테일의 헤더부분 -->
			<div class="headersession">

				<!-- 상품 사진 -->
				<div class="mdimagesession">
					<img id="mdimage">
				</div>

				<!-- 상품 설명과 구매버튼들 -->
				<div class="mdinfosession">
					<!-- 상품 인포 -->
					<table class="mdinfo">
						<colgroup>
							<col width="30%" />
							<col width="70%" />
						</colgroup>
						<tbody>
							<tr>
								<td class="stitle">카테고리</td>
								<td class="scontent">${ mddetail.p_division }</td>
							</tr>
							<tr>
								<td class="stitle">상품명</td>
								<td class="scontent">${mddetail.p_name}</td>
							</tr>
							<tr>
								<td class="stitle">제조사</td>
								<td class="scontent">${ mddetail.p_brand }</td>
							</tr>
							<tr>
								<td class="stitle">소비자가격</td>
								<td class="scontent">${ mddetail.p_price }</td>
							</tr>
							<tr>
								<td class="stitle">권장사용연령</td>
								<td class="scontent">${ mddetail.p_usableage }</td>
							</tr>
							<c:if test="${ mddetail.p_volume !='' }">
								<tr>
									<td class="stitle">용량</td>
									<td class="scontent">${ mddetail.p_volume }</td>
								</tr>
							</c:if>
							<c:if test="${ mddetail.p_size !='' }">
								<tr>
									<td class="stitle">사이즈</td>
									<td class="scontent">${ mddetail.p_size }</td>
								</tr>
							</c:if>
							<tr>
								<td class="stitle">기능</td>
								<td class="scontent">${ mddetail.p_function }</td>
							</tr>
							<c:if test="${ mddetail.p_color !='' }">
								<tr>
									<td class="stitle">컬러</td>
									<td class="scontent">${ mddetail.p_color }</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<!-- 상품 인포끝 -->

					<!-- 구매 구역 -->
					<table class="doorder">
						<colgroup>
							<col width="50%" />
							<col width="50%" />
						</colgroup>
						<tbody>
							<c:choose>
								<c:when test="${ mddetail.p_amount > 0 }">
									<tr>
										<td colspan="2">수량을 선택해주세요!</td>
									</tr>
									<tr>
										<td class="scontent">${ mddetail.p_name }</td>
										<td class="scontent"><input type="number"
											id="orderamount" value="0" min="0" class='form-control'
											max="${ mddetail.p_amount }" /></td>
									</tr>
									<tr>
										<td class="stitle">총 상품금액 (소비자가격*수량)</td>
										<td class="scontent"><label id="totalprice">0</label></td>
									</tr>
									<tr>
										<td class="stitle">구매시 적립예상 마일리지</td>
										<td class="scontent"><label id="maybesavemileage">0</label></td>
									</tr>
									<tr>
										<td colspan="2" class="scontent"><input type="button"
											value="바로구매하기" id="buynow" class="btn btn-info" /> <input type="button"
											value="장바구니담기" id="inshoppingcart" class="btn btn-default" /></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="2" class="scontent"><p id="soldout">해당상품은
												일시품절 되었습니다!</p></td>
									</tr>
									<tr>
										<td colspan="2" class="scontent"><div class="inqurybtn">
												<input type="button" value="해당상품 1:1 문의하기"
													class="btninquryatmd">
											</div></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

			</div>

			<!-- 디테일의 바디부분 -->
			<div class="bodysession">

				<!-- 원료구성 -->
				<div class="bodymdinfo">
					<p class="stitle">원료 구성</p>
					<p>${ mddetail.p_material }</p>
				</div>

				<!-- 디테일이미지 -->
				<div class="detailimage">
					<img id="detailimage">
				</div>

				<!-- 리뷰게시판 -->
				<div>
					<jsp:include page="productReview.jsp"></jsp:include>
				</div>
				<!-- 문의하기버튼 -->
				<div class="inqurybtn">
					<input type="button" value="해당상품 1:1 문의하기" class="btninquryatmd btn btn-default">
				</div>

			</div>
		</div>
	</div>
</body>
</html>