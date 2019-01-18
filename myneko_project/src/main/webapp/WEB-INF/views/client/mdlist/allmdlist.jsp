<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All MD List</title>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/mdlist.css" />
<style>
	.caption {
		overflow: hidden;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {

		// 썸네일 이미지파일을 보여주기 위한 속성 추가

		// 상세페이지 이동을 위한 처리이벤트
		$(".goDetail").click(function() {
			var p_number = $(this).parents("div").attr("data-num");
			$("#p_number").val(p_number);
			console.log(" --- md 번호 : " + p_number + " --- ");
			// 상세페이지로 이동하기 위해 form 추가
			$("#detailform").attr({
				"method" : "get",
				"action" : "/mdlist/mddetail"
			});
			$("#detailform").submit();
		});

		//loginplease 영역을 클릭하면 

	});
</script>

</head>
<body>

	<div class="content1">

		<!-- 상세페이지 이동을 위한 상품번호를 저장할 form -->
		<form name="detailform" id="detailform">
			<input type="hidden" name="p_number" id="p_number">
		</form>

		<!-- 리스트 시작 -->
		<div id="mdlist">
			<!-- 	
		<div class="row">
			<div class="col-sm-6 col-md-4">
				<div class="thumbnail">
					썸네일이미지
					<img src="#" alt="#">
					엠디 설명들 / 나중에 여기에 a태그나 여하튼 누르면 상세페이지로
					<div class="caption">
						엠디 타이틀, 상품 이름
						<h3 class="pname">상품 이름</h3>
						상품설명
						<p>상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명</p>
						<p class="pprice">13000원</p>
					</div>
				</div>
			</div>
		</div>
	 -->

			<!-- 추천게시판 출력 -->
			<%
				if (session.getAttribute("m_number") == null) {
					//로그인이 되어있지 않은 상태 -> forcustomerlist.jsp 보이지 않기
			%>
			<div id="loginplease">
				<a href="/member/login"> 로그인 하시면 우리집고양이의 맞춤 상품을 만나실 수 있습니다! </a>
			</div>
			<%
				} else {
					//로그인이 되어있는 상태 -> forcustomerlist.jsp 보여주기
			%>
			<%
				if (request.getParameter("p_division") == null) {
			%>
			<jsp:include page="forcustomerlist.jsp"></jsp:include>
			<%
				}
			%>

			<%
				}
			%>

			<!-- 데이터출력 -->
			<c:choose>
				<c:when test="${not empty mdlist}">
					<c:forEach var="md" items="${ mdlist }" varStatus="status">
						<div class="col-sm-6 col-md-4 mdbox" data-num="${ md.p_number }">
							<div class="thumbnail goDetail">
								<!-- 썸네일이미지 ${ md.p_thumbnail } -->
								<img src="/uploadStorage/product/image/${ md.p_image }">
								<!-- 엠디 설명들 / 나중에 여기에 a태그나 여하튼 누르면 상세페이지로 -->
								<div class="caption">
									<!-- 엠디 타이틀, 상품 이름 -->
									<pre class="pname">${ md.p_name }</pre>
									<!-- 상품설명 -->
									<p class="pdivision">${ md.p_division }</p>
									<p class="pprice">${ md.p_price }원</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h3>등록된 상품이 존재하지 않습니다</h3>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 리스트 끝 -->

	</div>

</body>
</html>