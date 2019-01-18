<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payment page</title>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/payment.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		//address 가져오기 삭제하기 토글
		// 0 = 비우기 , 1 = 가져오기
		var toggleAddress = 0;

		//배송비 3000원
		$("#shippingfee").val("3000");

		//총 상품금액
		var tp = $("#total").val();
		tp = parseInt(tp) + 3000;
		$("#p_totalprice").val(tp);
		$("#o_totalprice").val(tp);

		//마일리지사용하기 버튼 눌렀을 때
		$("#usemilage").click(function() {
			var milage = $("#m_milage").val();
			var hopeuse = $("#u_milage").val();

			if (milage < hopeuse) {
				alert("잔여 마일리지가 부족합니다. 마일리지 잔액을 확인해주세요!");
				return false;
			} else if (milage < 1000) {
				alert("마일리지 사용은 1000점 이상부터 가능합니다");
				return false;
			} else if (hopeuse<1000 || hopeuse>milage || hopeuse > tp) {
				alert("사용할 마일리지를 정확히 입력해주세요");
				return false;
			} else {
				$("#useMilageP").val($("#u_milage").val());
				$("#m_milage").val($("#m_milage").val() - hopeuse);
				$("#o_totalprice").val($("#o_totalprice").val() - hopeuse);
				$("#u_milage").val(0);
				$("#u_milage").attr({
					"readonly" : "readonly"
				});
			}
		});

		$("#resetMilage").click(function() {
			$("#m_milage").val($("#m_milage").val() + $("#useMilageP").val());
			$("#o_totalprice").val($("#o_totalprice").val() + $("#useMilageP").val());
			$("#u_milage").removeAttr("readonly");
		});
		
		//주문자정보동일 라디오버튼 눌렀을 때
		$("#calladdress").click(function() {
			if (toggleAddress == 0) {
				var name = $("#oname").val();
				console.log(oname);
				var phone = $("#ophone").val();
				console.log(ophone);
				var zipcode = $("#ozipcode").val();
				console.log(ozipcode);
				var address = $("#oaddress").val();
				console.log(oaddress);

				$("#o_name").val(name);
				$("#o_phone").val(phone);
				$("#o_zipcode").val(zipcode);
				$("#o_address").val(address + "");

				toggleAddress = 1;
			} else if (toggleAddress == 1) {
				$("#o_name").val("");
				$("#o_phone").val("");
				$("#o_zipcode").val("");
				$("#o_address").val("");

				$("#o_name").focus();

				toggleAddress = 0;
			}
		});

		//결제하기 버튼 눌렀을때
		$("#dopay")
				.click(
						function() {
							//입력값 체크
							if (!chkData($('#o_name'), "이름을"))
								return;
							else if (!chkData($('#o_phone'), "핸드폰번호를"))
								return;
							else if (!chkData($('#o_zipcode'), "우편번호를"))
								return;
							else if (!chkData($('#o_address'), "주소를"))
								return;
							else if ($('input:radio[name="o_paywith"]').is(
									':checked')) {

								if ($("#p_number").val() == null) {
									alert("장바구니 구매입니다");
									alert($("#o_detailaddress").val());
									$
											.ajax({
												url : "/cart/orderinsertAll",
												type : "post",
												headers : {
													"Content-Type" : "application/json"
												},
												data : JSON
														.stringify({
															o_paywith : $(
																	"#o_paywith")
																	.val(),
															o_milage : ($(
																	"#o_totalprice")
																	.val() - 3000) / 10,
															o_totalprice : $(
																	"#o_totalprice")
																	.val(),
															o_count : $(
																	"#amount")
																	.val(),
															o_zipcode : $(
																	"#o_zipcode")
																	.val(),
															o_address : $(
																	"#o_address")
																	.val(),
															o_phone : $(
																	"#o_phone")
																	.val(),
															o_name : $(
																	"#o_name")
																	.val(),
															m_number : $(
																	"#m_number")
																	.val(),
															u_milage : $(
																	"#u_milage")
																	.val()
														}),
												error : function() {
													alert("오류가 발생되어 결제 실패했습니다\n관리자에게 문의하세요");
												},
												success : function(result) {
													console.log(result);
													if (result == "SUCCESS") {
														alert("결제가 완료되었습니다");
														location.href = "/myorder/myorderList";
													} else {
														alert("오류가 발생되어 결제 실패했습니다\n다시 실행하거나 관리자에게 문의하세요")
													}
												}
											});
									//장바구니 구매
								} else {
									alert("바로구매입니다");
									//바로구매
								}
							} else {
								alert("결제수단을 선택해주세요");
							}
						});

		//결제취소버튼 눌렀을 때
		$("#cancle").click(function() {
			if (confirm("결제를 취소하시겠습니까?\n결제정보는 저장되지 않습니다")) {

			} else {

			}
		});

	});

	function chkData(item, msg) {
		if ($(item).val().replace(/\s/g, "") == "") {
			alert(msg + " 입력해주세요");
			$(item).focus();
			return false;
		} else {
			return true;
		}
	}
</script>
<style>
.buttons {
	text-align: center;
}
</style>
</head>
<body>
	<input type="hidden" id="useMilageP" />
	<div class="paycontent">

		<div class="cartlist">

			<%
				if (session.getAttribute("rnp_pnumber") != null) {
					//바로구매하기 일 때
			%>
			<p>--- 장바구니 페이지 오류입니다 ---</p>
			<%
				session.removeAttribute("rnp_pnumber");
					session.removeAttribute("rnp_pname");
					session.removeAttribute("rnp_pprice");
					session.removeAttribute("rnp_pcount");
				} else {
					//바로구매하기가 아닐 때 - 장바구니 구매하기일때
			%>

			<table summary="장바구니 구매하기" class="table">
				<colgroup>
					<col width="60%" />
					<col width="15%" />
					<col width="10%" />
					<col width="15%" />
				</colgroup>
				<thead>
					<tr>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>주문금액</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty cartList}">
							<c:set var="total" value="0" />
							<c:set var="amount" value="0" />
							<c:forEach var="cart" items="${cartList}" varStatus="status">
								<tr data-num="${cart.ct_number}">
									<td id="pname">${cart.p_name}</td>
									<td align="center">${cart.p_price}원</td>
									<td id="editinput">${cart.ct_amount}</td>
									<td align="center">${cart.money}원</td>
								</tr>
								<c:set var="total" value="${ total+cart.money }" />
								<c:set var="amount" value="${ amount+1 }" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" align="center">장바구니오류입니다\n다시한번 확인해주세요</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<input type="hidden" id="total" name="total" value="${total}">
			<input type="hidden" id="amount" name="amount" value="${amount}">
			<%
				}
			%>
		</div>

		<input type="hidden" id="m_number" name="m_number"
			value='<%=session.getAttribute("m_number")%>' />
		<div class="addresseeinfo">
			<div class="contitle">배송정보</div>

			<input type="hidden" id="oname" name="oname"
				value='<%=session.getAttribute("m_name")%>' /> <input type="hidden"
				id="ophone" name="ophone"
				value='<%=session.getAttribute("m_phone")%>' /> <input
				type="hidden" id="ozipcode" name="ozipcode"
				value='<%=session.getAttribute("m_postcode")%>' /> <input
				type="hidden" id="oaddress" name="oaddress"
				value='<%=session.getAttribute("m_address")%>' /> <input
				type="hidden" id="odetailaddress" name="odetailaddress"
				value="${ m_detailaddress }" />

			<div class="contents">
				<table class="table">
					<tr>
						<td colspan="2"><input type="checkbox" name="calladdress"
							id="calladdress"><label for="calladdress">주문자정보와
								동일합니다.</label></td>
					</tr>
					<tr>
						<td><label>받으시는 분</label></td>
						<td><input type="text" id="o_name" name="o_name"
							class="form-control"></td>
					</tr>
					<tr>
						<td><label>핸드폰 번호</label></td>
						<td><input type="tel" id="o_phone" name="o_phone"
							class="form-control"></td>
					</tr>
					<tr>
						<td><label>주소</label>
						<td><input type="text" id="o_zipcode" name="o_zipcode"
							class="form-control"><input type="button"
							onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
							class="btn btn-default">
							<p>
								<input type="text" id="o_address" name="o_address"
									class="form-control">
							<p>
								<input type="text" id="o_detailaddress" name="o_detailaddress"
									class="form-control" /></td>
					</tr>
				</table>
			</div>
		</div>

		<div class="payinfo">
			<div class="contitle">결제정보</div>
			<div class="contents">
				<table class="table">
					<tr>
						<td><label>배송비</label></td>
						<td><input type="text" id="shippingfee" name="shippingfee"
							readonly="readonly" class="form-control"></td>
						<td><label>총 상품금액</label></td>
						<td><input type="text" id="p_totalprice" name="p_totalprice"
							readonly="readonly" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="4"><label>마일리지는 1000점 이상부터 사용 가능합니다</label>
					</tr>
					<tr>
						<td><label>잔여 마일리지</label></td>
						<td><c:choose>
								<c:when test="${ not empty m_mileage }">
									<input type="text" id="m_milage" name="m_milage"
										value='${ m_mileage }' readonly="readonly"
										class="form-control">
								</c:when>
								<c:otherwise>
									<input type="text" id="m_milage" name="m_milage" value="0"
										readonly class="form-control" />
								</c:otherwise>
							</c:choose></td>
						<td><label>사용할 마일리지</label></td>
						<td><input type="text" id="u_milage" name="u_milage"
							value="0" class="form-control"><input type="button"
							id="usemilage" value="마일리지사용하기" class="btn btn-default">
							<input type="button" id="resetMilage" class="btn btn-default" value="마일리지 사용 초기화"	/>
						</td>
					</tr>
					<tr>
						<td><label>최종 결제금액</label></td>
						<td colspan="3"><input type="text" id="o_totalprice"
							name="o_totalprice" readonly="readonly" class="form-control"></td>
					</tr>
				</table>
			</div>
		</div>
		<table class="table">
			<tr>
				<td>결제수단</td>
			</tr>
			<tr>
				<td><input type="radio" id="o_paywith" name="o_paywith"
					value="phone"><label for="phone">휴대폰결제</label> <input
					type="radio" id="o_paywith" name="o_paywith" value="card"><label
					for="card">신용카드</label></td>
			</tr>
		</table>
		<div class="buttons">
			<input type="button" id="dopay" value="결제하기" class="btn btn-info" />
			<input type="button" id="cancle" value="결제취소" class="btn btn-default" />
		</div>
	</div>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("o_address").value = extraAddr;

							} else {
								document.getElementById("o_address").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('o_zipcode').value = data.zonecode;
							document.getElementById("o_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("o_address").focus();
						}
					}).open();
		}
	</script>
</body>
</html>