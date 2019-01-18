<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	function goForm() {
		location.href = "/admin/product/productRegForm.do"
	}
	$(function() {
		history.pushState(null, null, location.href);
		window.onpopstate = function() {
			history.go(1);
		}
		$("form").keydown(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		})

		if ("<c:out value='${data.pageSize}' />" != "") {
			$("#pageSize").val("<c:out value='${data.pageSize}' />");
		}
		$("option[value='${division}']").attr({
			"selected" : "selected"
		});
		$(".goDetail").click(function() {
			var p_number = $(this).attr("data-num");
			$("#p_number").val(p_number);
			$("#optionForm").attr({
				"method" : "get",
				"action" : "/admin/product/productDetail.do"
			})
			$("#optionForm").submit();
		})
		$("#listView").change(function() {
			$("#p_division").val($("#listView").val());
			$("#p_number").val(0);
			$("#p_name").val($("#search_p_name").val());
			$("#listView") > $("input[name='page']").val('1');
			$("#optionForm").attr({
				"method" : "get",
				"action" : "/admin/product/productList.do"
			});
			$("#optionForm").submit();
		});
		$("#searchbtn")
				.click(
						function() {
							if ($("#search_p_name").val().match(
									/^[a-zA-Z가-힣0-9 ]+$/g) == null) {
								alert("검색 키워드는 영어,한글,숫자만 사용해주세요")
							} else {
								$("#page").val('1');
								$("#searchForm").attr({
									"method" : "get",
									"action" : "/admin/product/productList.do"
								});
								$("#searchForm").submit();
							}
						});
	})
	function goPage(page) {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#searchForm").attr({
			"method" : "get",
			"action" : "/admin/product/productList.do"
		});
		$("#searchForm").submit();
	}
</script>
<style>
	.form-control {
		width: 10%;
		clear: none;
		float: left;
	}
	.search-control {
		width: 20%;
		clear: none;
		float: left;
	}
	.select-control {
		width: 20%;
		clear: none;
		float: left;
	}
	.right {
		float: right;
	}
	
	.paginate {
		text-align: center;
	}
</style>
</head>
<body oncontextmenu="return false;">
		<h3>상품관리</h3>
		<form id="optionForm">
			<input type="hidden" id="p_number" name="p_number"> <input
				type="hidden" id="p_division" name="p_division" value="${division}">
			<input type="hidden" id="p_name" name="p_name" value="${searchword}">
			<input type="hidden" name="page" value="${data.page}"> <input
				type="hidden" name="pageSize" value="${data.pageSize}">
		</form>
		<form id="searchForm">
			<input type="hidden" name="p_division" value="${division}"> <input
				type="hidden" id="page" name="page" value="${data.page}" /> <input
				type="hidden" id="pageSize" name="pageSize" value="${data.pageSize}">
			<select id="searchselect" name="searchselect" class="form-control">
				<option id="selectnameoption" value="" selected="selected">상품명</option>
			</select><input type="search" id="search_p_name" name="p_name"
				value="${searchword}" class="form-control search-control">
			<button id="searchbtn" name="searchbtn" class="btn btn-default">검색</button>
		</form>
		<br />
		<select id="listView" name="listView" class="form-control select-control">
			<option selected="selected" value="">모든 카테고리 보기</option>
			<option value="사료">사료</option>
			<option value="간식">간식</option>
			<option value="장난감">장난감</option>
			<option value="모래">모래</option>
			<option value="화장실">화장실</option>
			<option value="하우스">하우스</option>
			<option value="이동장">이동장</option>
			<option value="건강관리">건강관리</option>
			<option value="미용">미용</option>
		</select>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>상품번호</th>
					<th>품목구분</th>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>판매가격</th>
					<th>재고수량</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${not empty productList}">
					<c:forEach var="product" items="${productList}" varStatus="status">
						<tr>
							<td>${product.p_number}</td>
							<td>${product.p_division}</td>
							<td><c:choose>
									<c:when test="${not empty product.p_image }">
										<img class="goDetail" width="150px" height="150px"
											src="/uploadStorage/product/image/${product.p_image}"
											data-num="${product.p_number}">
									</c:when>
									<c:otherwise>
										<img class="goDetail" width="150px" height="150px"
											src="/uploadStorage/product/default.jpg"
											data-num="${product.p_number}">
									</c:otherwise>
								</c:choose></td>
							<td><label class="goDetail" data-num="${product.p_number}">${product.p_name}</label></td>
							<td>${product.p_price}</td>
							<td>${product.p_amount}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6" align="center">등록된 상품이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="paginate">
			<tag:paging page="${param.page}" total="${total}"
				list_size="10" />
		</div>
		<br>
		<div id="btndiv">
		<button id="goinsertform" name="goinsertform" onclick="goForm()" class="btn btn-info right">상품
			등록</button>
		</div>
</body>
</html>