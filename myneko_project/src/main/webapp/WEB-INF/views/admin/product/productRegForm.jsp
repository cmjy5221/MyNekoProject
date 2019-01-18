<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	if ('${msg}' != null && '${msg}' != '') {
		alert('${msg}')
	}
	$(function() {
		$("#goToList").click(function(){
			location.href="/admin/product/productList.do"
		})
		$("#reg").click(
				function() {
					console.log($("#p_imageFile").val().substring(
							$("#p_imageFile").val().indexOf(".") + 1,
							$("#p_imageFile").val().toString().length).match(
							/jpg|png|jpeg|gif/))
					var msg = data_check();
					if (msg != true) {
						alert(msg);
					} else {
						var form = $("form")[0];
						var formData = new FormData(form);
						$.ajax({
							url : "/admin/product/productReg.do",
							processData : false,
							contentType : false,
							type : "post",
							data : formData,
							error : function() {
								alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
								return false;
							},
							success : function(result) {
								if (result == 1) {
									alert("등록 성공!");
									location.href="/admin/product/productList.do";
								} else {
									alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
									return false;
								}
							}
						});
					}
				});

	})
	function data_check() {
		var msg = "";
		if ($("#p_division").val() == '선택' || $("#p_division").val() == '') {
			msg = "품목구분을 지정해주세요";
			return msg;
		}
		if ($("#p_name").val() == null || $("#p_name").val() == '') {
			msg = "상품명을 입력해주세요";
			return msg;
		}
		if ($("#p_name").val().toString().match(/^[0-9a-zA-Z가-힣\s]+$/g) == null) {
			msg = "영어와 한글, 숫자만 입력해주세요";
			return msg;
		}
		if ($("#p_imageFile").val().substring(
				$("#p_imageFile").val().indexOf(".") + 1,
				$("#p_imageFile").val().toString().length).match(
				/jpg|png|jpeg|gif/) == null
				&& $("#p_imageFile").val().toString() != '') {
			msg = "상품 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다"
			return msg;
		}
		if ($("#p_detailimageFile").val().substring(
				$("#p_detailimageFile").val().indexOf(".") + 1,
				$("#p_detailimageFile").val().toString().length).match(
				/jpg|png|jpeg|gif/) == null
				&& $("#p_detailimageFile").val().toString() != '') {
			msg = "상품 상세 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다"
			return msg;
		}
		if ($("#p_price").val() == null || $("#p_price").val() == '') {
			msg = "가격을 입력해주세요";
			return msg;
		}
		if ($("#p_price").val().toString().match(/^[\d]+$/) == null) {
			msg = "숫자만 입력해주세요"
			return msg;
		}
		if ($("#p_brand").val() == null || $("#p_brand").val() == '') {
			msg = "회사명 또는 브랜드명을 입력해주세요.";
			return msg;
		}
		if ($("#p_brand").val().toString().match(/^[0-9a-zA-Z가-힣\s]+$/g) == null) {
			msg = "영어와 한글, 숫자만 입력해주세요!";
			return msg;
		}
		if (!$("#p_material").val() == '') {
			if ($("#p_material").val().toString()
					.match(/^[0-9a-zA-Z가-힣,\s]+$/g) == null) {
				alert($("#p_material").val().toString());
				msg = "영어와 한글, 숫자만 입력해주세요!!";
				return msg;
			}

		}
		if (!$("#p_type").val() == '') {
			if ($("#p_type").val().toString().match(/^[a-zA-Z가-힣\s]+$/g) == null) {
				msg = "영어와 한글만 입력해주세요!";
				return msg;
			}
		}
		if (!$("#p_function").val() == '') {
			if ($("#p_function").val().toString().match(/^[a-zA-Z가-힣\s]+$/g) == null) {
				msg = "영어와 한글만 입력해주세요!!";
				return msg;
			}
		}
		if (!$("#p_volume").val() == '') {
			if ($("#p_volume").val().toString().match(/^[0-9]+$/g) == null) {
				msg = "영어와 한글만 입력해주세요!!!";
				return msg;
			}
		}
		if (!$("#p_size").val() == '') {
			if ($("#p_size").val().toString().match(/^[0-9a-zA-Z]+$/g) == null) {
				msg = "영어와 한글만 입력해주세요!!!!";
				return msg;
			}
		}
		if (!$("#p_color").val() == '') {
			if ($("#p_color").val().toString().match(/^[a-zA-Z가-힣\s]+$/g) == null) {
				msg = "영어와 한글만 입력해주세요!!!!!";
				return msg;
			}
		}
		return true;
	}
</script>
<style>
	#btndiv {
		text-align: center;
	}
</style>
</head>
<body>
	<h3>상품등록</h3>
		<form id="reg_form" name="reg_form" enctype="multipart/form-data">
			<table class="table table-striped">
				<tr>
					<td><label>품목구분(필수)</label></td>
					<td colspan="5"><select class="form-control" id="p_division"
						name="p_division">
							<option selected="selected" value="">선택</option>
							<option value="사료">사료</option>
							<option value="간식">간식</option>
							<option value="장난감">장난감</option>
							<option value="모래">모래</option>
							<option value="화장실">화장실</option>
							<option value="하우스">하우스</option>
							<option value="이동장">이동장</option>
							<option value="건강관리">건강관리</option>
							<option value="미용">미용</option>
					</select></td>
				</tr>
				<tr>
					<td><label for="p_name">상품명(필수)</label></td>
					<td colspan="5"><input class="form-control" type="text"
						maxlength="75" id="p_name" name="p_name"
						placeholder="한글이나 영어, 숫자로 75자 이내로 입력"></td>
				</tr>
				<tr>
					<td><label>상품이미지</label></td>
					<td colspan="5"><input class="form-control" type="file"
						id="p_imageFile" name="p_imageFile"></td>
				</tr>
				<tr>
					<td><label>상품 상세 설명 이미지</label></td>
					<td colspan="5"><input class="form-control" type="file"
						id="p_detailimageFile" name="p_detailimageFile">
				<tr>
					<td><label for="p_price">판매가격(필수)</label></td>
					<td colspan="5"><input class="form-control" type="text"
						placeholder="숫자만 입력, 단위는 원입니다." id="p_price" name="p_price"></td>
				</tr>
				<tr>
					<td><label for="p_brand">제조사명(필수)</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="한글이나 영어, 숫자로 75자 이내로 입력" maxlength="75" type="text"
						id="p_brand" name="p_brand"></td>
				</tr>
				<tr>
					<td><label for="p_material">주원료</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="한글이나 영어, 숫자로 75자 이내로 입력" maxlength="75" type="text"
						id="p_material" name="p_material"></td>
				</tr>
				<tr>
					<td><label for="p_usableage">사용연령</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="개월 수로 입력해주세요." maxlength="50" type="text"
						id="p_usableage" name="p_usableage"></td>
				</tr>
				<tr>
					<td><label>사용모종</label></td>
					<td colspan="5"><select class="form-control" id="p_usablehair"
						name="p_usablehair">
							<option value="공용" selected="selected">공용</option>
							<option value="단모종">단모종</option>
							<option value="중장모종">중장모종</option>
							<option value="장모종">장모종</option>
					</select></td>
				</tr>
				<tr>
					<td><label for="p_type">상품타입</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="한글이나 영어로 75자이내로 입력" maxlength="75" type="text"
						id="p_type" name="p_type"></td>
				</tr>
				<tr>
					<td><label for="p_function">상품기능</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="한글이나 영어로 150자 이내로 입력" maxlength="150" type="text"
						id="p_function" name="p_function"></td>
				</tr>
				<tr>
					<td><label for="p_volume">상품용량</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="숫자로만 입력" maxlength="150" type="text" id="p_volume"
						name="p_volume"></td>
				</tr>
				<tr>
					<td><label for="p_size">상품크기</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="숫자와 단위로 150자 이내로 입력" maxlength="150" type="text"
						id="p_size" name="p_size"></td>
				</tr>
				<tr>
					<td><label for="p_color">상품색상</label></td>
					<td colspan="5"><input class="form-control"
						placeholder="한글이나 영어로만 75자 이내로 입력" type="text" id="p_color"
						name="p_color"></td>
				</tr>
				<tr>
					<td><label>추천성별</label></td>
					<td colspan="5"><select class="form-control" id="p_recgender"
						name="p_recgender">
							<option value="공용" selected="selected">공용</option>
							<option value="남아">남아</option>
							<option value="여아">여아</option>
					</select></td>
				</tr>
				<tr>
					<td><label>추천성격</label></td>
					<td><label class="form-control">활발함<input
							type="checkbox" id="p_recchar" name="p_recchar" value="활발함"></label></td>
					<td><label class="form-control">호기심 많음<input
							type="checkbox" id="p_recchar" name="p_recchar" value="호기심 많음"></label></td>
					<td><label class="form-control">소극적<input
							type="checkbox" id="p_recchar" name="p_recchar" value="소극적"></label></td>
					<td><label class="form-control">식탐 많음<input
							type="checkbox" id="p_recchar" name="p_recchar" value="식탐많음"></label></td>
					<td><label class="form-control">ETC<input
							type="checkbox" id="p_recchar" name="p_recchar" value="ETC"></label></td>
				</tr>
				<tr>
					<td><label>추천식성</label></td>
					<td colspan="5"><select class="form-control" id="p_rectaste"
						name="p_rectaste">
							<option value="공용" selected="selected">공용</option>
							<option value="건식선호">건식선호</option>
							<option value="습식선호">습식선호</option>
							<option value="생식선호">생식선호</option>
					</select></td>
				</tr>
				<tr>
					<td><label>검색 키워드</label></td>
					<td colspan="5">

						<p>
							<strong>식성</strong>
						</p>
						<div class="form-control">
							<input type="radio" name="foodChr" value="습식선호">습식식품 <input
								type="radio" name="foodChr" value="건식선호">건식식품 <input
								type="radio" name="foodChr" value="생식선호">생식식품
							<p>
						</div>

						<p>
							<strong>털길이</strong>
						</p>
						<div class="form-control">
							<input type="radio" name="furLength" value="장모">장모묘추천 <input
								type="radio" name="furLength" value="중간모">중모묘추천 <input
								type="radio" name="furLength" value="단모">단모묘추천
						</div>

						<p>
							<strong>질병</strong>
						</p>
						<div class="form-control">
							<input type="checkbox" name="disease" value="비만">비만개선 <input
								type="checkbox" name="disease" value="피부질환">피부질환개선 <input
								type="checkbox" name="disease" value="안구질환">안구질환개선
						</div>
						<div class="form-control">
							<input type="checkbox" name="disease" value="위장질환">위장질환개선
							<input type="checkbox" name="disease" value="호흡기질환">호흡기질환개선
							<input type="checkbox" name="disease" value="관절질환">관절질환개선
						</div>


						<p>
							<strong>연령</strong>
						</p>
						<div class="form-control">
							<input type="radio" name="age" value="자묘">1살이하 자묘용 <input
								type="radio" name="age" value="성묘">일반 성묘용 <input
								type="radio" name="age" value="노묘">노묘용
						</div>
					</td>
				</tr>
			</table>
			<div id="btndiv">
			<input type="button" id="reg" name="reg" class="btn btn-info" value="저장" />
			<input type="button" id="goToList" name="goToList" class="btn btn-default" value="목록으로" />
			<input type="reset" id="reset" name="reset" class="btn btn-warning" value="다시쓰기" />
			</div>
		</form>
</body>
</html>