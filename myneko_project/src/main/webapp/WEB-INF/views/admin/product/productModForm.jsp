<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#modBtn")
								.click(
										function() {
											var val1 = $("#p_price").val()
											var val2 = $("#p_amount").val()
											console.log(val1.match(/\D+/g));
											if (val1.match(/\D+/g) != null
													|| val2.match(/\D+/g) != null) {
												alert("숫자만 입력해주세요.")
												return false;
											}
											if ($("#p_price").val() == null
													|| $("#p_price").val() == '') {
												alert("가격을 입력해 주세요")
											} else if ($("#p_amount").val() == null
													|| $("#p_amount").val() == '') {
												alert("재고수량을 입력해 주세요")

											} else {
												var check = confirm("수정하시겠습니까?")

												if (check == true) {
													var form = $("form")[0];
													var formData = new FormData(form);
													$.ajax({
														url : "/admin/product/productMod.do",
														processData : false,
														contentType : false,
														type : "post",
														data : formData,
														error : function() {
															alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
															return false;
														},
														success : function(result) {
															if (result == 1) {
																alert("수정 성공!");
																location.href="/admin/product/productDetail.do?p_number=${product.p_number}";
															} else {
																alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
																return false;
															}
														}
													});
												}
											}
										})
						$("#returnBtn")
								.click(
										function() {
											location.href = "productDetail.do?p_number=${product.p_number}"
										})
					});
</script>
<style>
	.form-control {
		width: 25%;
		float: left;
	}
	.label {
		float: left;
		color: black;
		font-weight: bold;
		font-size: 10pt;
	}
	#btnDiv {
		text-align: center;
	}
</style>
</head>
<body>
	<h3>상품 정보 수정</h3>
	<div class="table-responsive">
	<form id="modForm" name="modForm" enctype="multipart/form-data">
		<input type="hidden" id="p_number" name="p_number"
			value="${product.p_number}">
		<table class="table table-striped">
			<tr>
				<td><label>품목구분</label></td>
				<td><label>${product.p_division}</label>
			</tr>
			<tr>
				<td><label>상품명</label></td>
				<td><label>${product.p_name }</label></td>
			</tr>
			<tr>
				<td><label>상품이미지</label></td>
				<td><img src="/uploadStorage/product/image/${product.p_image}"
					alt="상품 이미지" width="30%" height="auto" class="thumbnail"></td>
			</tr>
			<tr>
				<td><label>상품 상세 설명 이미지</label></td>
				<td><img src="/uploadStorage/product/detail/${product.p_detailimage}"
					alt="상품 설명 이미지" width="30%" height="auto" class="thumbnail">
			<tr>
				<td><label>판매가격</label></td>
				<td><input type="text" id="p_price" name="p_price"
					value="${product.p_price}" maxlength="10" class="form-control">원</td>
			</tr>
			<tr>
				<td><label>제조사명</label></td>
				<td><label>${product.p_brand}</label></td>
			</tr>
			<tr>
				<td><label>주원료</label></td>
				<td><label>${product.p_material}</label></td>
			</tr>
			<tr>
				<td><label>재고량</label>
				<td><label class='label'>${product.p_amount}개 +</label>
				<input type="text"
						id="p_amount" name="p_amount" value="0" maxlength="10" class="form-control">
			</tr>
			<tr>
				<td><label>사용연령</label></td>
				<td><label>${product.p_usableage}</label></td>
			</tr>
			<tr>
				<td><label>사용모종</label></td>
				<td><label>${product.p_usablehair}</label></td>
			</tr>
			<tr>
				<td><label>상품타입</label></td>
				<td><label>${product.p_type}</label></td>
			</tr>
			<tr>
				<td><label>상품기능</label></td>
				<td><label>${product.p_function}</label></td>
			</tr>
			<tr>
				<td><label>상품용량</label></td>
				<td><label>${product.p_volume}</label></td>
			</tr>
			<tr>
				<td><label>상품크기</label></td>
				<td>${product.p_size}</td>
			</tr>
			<tr>
				<td><label>상품색상</label></td>
				<td>${product.p_color}</td>
			</tr>
			<tr>
				<td><label>추천성별</label></td>
				<td>${product.p_recgender}</td>
			</tr>
			<tr>
				<td><label>추천성격</label></td>
				<td>${product.p_recchar}</td>
			</tr>
			<tr>
				<td><label>추천식성</label></td>
				<td>${product.p_rectaste}</td>
			</tr>
		</table>
		<div id="btnDiv">
		<input type="button" id="modBtn" name="modBtn" class="btn btn-info"
			value="수정"> <input type="button" id="returnBtn"
			name="returnBtn" class="btn btn-warning" value="취소">
		</div>
	</form>
	</div>
</body>
</html>