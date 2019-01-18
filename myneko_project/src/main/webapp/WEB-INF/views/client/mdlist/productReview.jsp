<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	th, td {
		text-align: center;
		align: center;
	}
</style>
</head>
<body>
	<div class="table-responsive">
		<c:choose>
			<c:when test="${ not empty review }">
				<div>
					<table class="table table-bordered">
						<tr>
							<th class="tac" width="30%">
								평균평점
							</th>
							<td class="tac" width="70%">
								<c:choose>
									<c:when test="${ reviewTotal / reviewCount > 4.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/fivestar.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount == 4.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/fourhalf.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount > 3.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/fourstar.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount == 3.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/threehalf.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount > 2.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/threestar.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount == 2.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/twohalf.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount > 1.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/twostar.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount == 1.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/onehalf.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount > 0.5 }">
										${ reviewTotal / reviewCount }<img src="/resources/include/images/onestar.png" />
									</c:when>
									<c:when test="${ reviewTotal / reviewCount == 0.5 }">
										${ reviewTotal / reviewCount }<img src="/resource/include/images/half.png" />
									</c:when>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			</c:when>
		</c:choose>
		<table class="table table-bordered">
			<tr>
				<th class="tac">작성자</th>
				<th class="tac">내용</th>
				<th class="tac">별점</th>
				<th class="tac">작성일</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty review }">
					<c:forEach items="${ review }" var="review" varStatus="status">
						<tr>
							<td class="tac">${ review.m_id }</td>
							<td class="tac">${ review.r_content }</td>
							<td class="tac">
								<c:choose>
									<c:when test="${ review.r_starrate == 1 }">
										<img src="/resources/include/images/onestar.png" class="star" />						
									</c:when>
									<c:when test="${ review.r_starrate == 2 }">
										<img src="/resources/include/images/twostar.png" class="star" />
									</c:when>
									<c:when test="${ review.r_starrate == 3 }">
										<img src="/resources/include/images/threestar.png" class="star" />
									</c:when>
									<c:when test="${ review.r_starrate == 4 }">
										<img src="/resources/include/images/fourstar.png" class="star" />
									</c:when>
									<c:when test="${ review.r_starrate == 5 }">
										<img src="/resources/include/images/fivestar.png" class="star" />
									</c:when>
								</c:choose>
							</td>
							<td class="tac">${ review.r_date }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td class="tac" colspan="4" align="center">등록된 리뷰가 없습니다.</td>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>