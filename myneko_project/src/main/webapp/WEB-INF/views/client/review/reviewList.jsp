<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="../../../tld/custom_tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<style>
.starR {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 30px;
	height: 30px;
	display: inline-block;
	text-indent: -9999px;
	cursor: pointer;
}

.starR.on {
	background-position: 0 0;
}

#reviewPage {
	text-align: center;
}

.on {
	font-size: 15pt;
	font-weight: bold;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
	color: black;
}

a:active {
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
</style>
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#insertReviewBtn").click(function() {
			location.href = "/review/reviewWriteForm";
		});

		//제목 클릭시 상세페이지 이동 처리 이벤트
		$(".goDetail").click(function() {
			var r_number = $(this).parents("tr").attr("data-num");
			$("#r_number").val(r_number);
			console.log("글번호 : " + r_number);
			//상세페이지 이동하기 위해 form 추가
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/review/reviewDetail"
			});
			$("#detailForm").submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>리뷰목록</title>
</head>
<body>
	<%
		if (session.getAttribute("m_id") != null) {
	%>
	<%
		int m_number = (Integer) session.getAttribute("m_number");
	%>
	<div class="contentContainer table-responsive">
		<h3>리뷰게시판</h3>
		<%--상세 페이지 이동 Form --%>
		<form name="detailForm" id="detailForm">
			<input type="hidden" name="r_number" id="r_number">
		</form>
		<div id="reviewList">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>상품명</th>
						<th class="writer">작성자</th>
						<th class="product_starrate">평점</th>
						<th>리뷰이미지</th>
						<th>리뷰내용</th>
						<th data-value="r_date" class="order">작성일</th>
					</tr>
				</thead>
				<tbody id="list">
					<c:choose>
						<c:when test="${not empty reviewList }">
							<c:forEach var="review" items="${reviewList }" varStatus="status">
								<tr class="tac" data-num="${review.r_number}">
									<td class="goDetail tal">${review.p_name }</td>
									<td class="name"><%=session.getAttribute("m_id")%><input
										type="hidden" name="m_number" value="<%=m_number%>"></td>
									<td><c:if test="${ review.r_starrate == 1 }">
											<img src="/resources/include/images/onestar.png" />
										</c:if> <c:if test="${ review.r_starrate == 2 }">
											<img src="/resources/include/images/twostar.png" />
										</c:if> <c:if test="${ review.r_starrate == 3 }">
											<img src="/resources/include/images/threestar.png" />
										</c:if> <c:if test="${ review.r_starrate == 4 }">
											<img src="/resources/include/images/fourstar.png" />
										</c:if> <c:if test="${ review.r_starrate == 5 }">
											<img src="/resources/include/images/fivestar.png" />
										</c:if>
									<td><c:if test="${ not empty review.r_image }">
											<img src="/uploadStorage/review/${ review.r_image }" width="100px" height="auto" />
										</c:if>
										<c:if test="${ empty review.r_image }">리뷰이미지가 없는 리뷰입니다.</c:if></td>
									<td>${ review.r_content }</td>
									<td>${review.r_date}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="tac" align="center">등록 된 게시물이 존재하지
									않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<%
		} else if (session.getAttribute("m_id") == null) {
	%>
	<script type="text/javascript">
		alert("로그인 후 이용 할 수 있습니다.");
		window.location.href = "/member/login";
	</script>
	<%
		}
	%>
	<div id="reviewPage">
		<tag:paging page="${ param.page }" total="${ total }" list_size="10" />
	</div>
</body>
</html>