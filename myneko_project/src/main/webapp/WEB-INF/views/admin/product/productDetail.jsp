<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<script type="text/javascript">
	$(function() {

		var msg = '${msg}';
		var origin = '${origin}';
		if (msg != '') {
			alert(msg);
		}

		$("#backBtn")
				.click(
						function() {
							location.href = "productDetail.do?p_number=${product.p_number - 1}&origin=${product.p_number}";
						})
		$("#nextBtn")
				.click(
						function() {
							location.href = "productDetail.do?p_number=${product.p_number + 1}&origin=${product.p_number}";
						})
		$("#listBtn")
				.click(
						function() {
							location.href = "productList.do?page=${param.page}&pageSize=${param.pageSize}&p_name=${param.p_name}&p_division=${param.p_division}";
						})
		$("#modForm").click(function() {
			location.href = "productModForm.do?p_number=${product.p_number}"
		})

	})
</script>
<style type="text/css">
 #btndiv {
 	text-align: center;
 }
 th, td {
 	text-align: center;
 }
</style>
</head>
<body>
	<h3>상품 상세정보</h3>
	<div class="table-responsive">
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
				alt="상품 이미지" width="50%" height="auto"></td>
		</tr>
		<tr>
			<td><label>상품 상세 설명 이미지</label></td>
			<td><img
				src="/uploadStorage/product/detail/${product.p_detailimage}"
				alt="상품 설명 이미지" width="50%" height="auto">
		<tr>
			<td><label>판매가격</label></td>
			<td><label>${product.p_price}</label></td>
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
			<td><label>${product.p_amount}</label>
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
	<div id="btndiv">
		<c:choose>
			<c:when test="${ product.p_number == 1 }">
			</c:when>
			<c:otherwise>
				<button id="backBtn" name="backBtn" class="btn btn-default">이전상품</button>				
			</c:otherwise>
		</c:choose>
		<button id="nextBtn" name="nextBtn" class="btn btn-default">다음상품</button>
		<button id=listBtn name=listBtn class="btn btn-info">상품목록</button>
		<button id="modForm" name="modForm" class="btn btn-info">상품 정보수정</button>
	</div>
	</div>
</html>