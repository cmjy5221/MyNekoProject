<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>for customer list</title>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/mdlist.css" />

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		//상세페이지 이동을 ㅜ이한 처리이벤트
		$(".goDetail").click(function() {
			var p_number = $(this).parents("div").attr("data-num");
			$("#p_number").val(p_number);

			//상세페이지로 이동하기 위해 form 추가
			$("#detailform").attr({
				"method" : "get",
				"action" : "/mdlist/mddetail"
			});
			$("#detailform").submit();
		});
	});

	//
</script>

</head>
<body>

	<div class="content1 forclistcontent">

		<!-- 현재 페이지를 설명할 컨텐츠타이틀 -->
		<div class="contentTitle">
			<h3><%=session.getAttribute("m_name")%>
				집사님을 위한 맞춤 상품입니다
			</h3>
		</div>

		<!-- 상세페이지 이동을 위한 상품번호를 저장할 form -->
		<form name="detailform" id="detailform">
			<input type="hidden" name="p_number" id="p_number">
		</form>

		<!-- 리스트 시작 -->
		<div id="mdlist">

			<!-- 데이터출력 엠디리스트 -->
			<c:choose>
				<c:when test="${ not empty customlist }">
					<c:forEach var="md" items="${ customlist }" varStatus="status">

						<div class="col-sm-6 col-md-4 mdbox" data-num="${ md.p_number }">
							<div class="thumbnail goDetail">
								<!-- 썸네일이미지 ${ md.p_thumbnail } -->
								<img src="/uploadStorage/product/image/${ md.p_image }">
								<!-- 엠디 설명들 -->
								<div class="caption">
									<!-- 엠디 타이틀=이름 -->
									<p class="pname">${ md.p_name }</p>
									<!-- 엠디 설명 -->
									<p class="pdivision">${ md.p_division }</p>
									<p class="pprice">${ md.p_price }원</p>
								</div>
							</div>
						</div>

					</c:forEach>
					<div id="changecatinfo">
						<p>
							추천 상품이 맘에들지 않으신다면, 대장 고양이 정보를 수정해주세요! <a href="/cat/catList">고양이
								정보 수정하기</a>
						</p>
					</div>
				</c:when>
				<c:otherwise>
					<div id="nohavecat">
						<h3>대장 고양이가 설정되지 않았습니다</h3>
						<h5>우리집 고양이를 등록해보세요!</h5>
						<p>
							<a href="/cat/catList">고양이 정보 등록하기</a>
						</p>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
		<!-- 리스트 끝 -->

	</div>


</body>
</html>