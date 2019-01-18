<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html oncontextmenu="return false;" ondragstart="return false;">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/header.css" />

<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/javascript"
	src="http://code.jquery.com/jquery.js"></script>

<title>헤더</title>
</head>
<body id="header">
	<div>
		<div id="logo">
			<a href="/mdlist/allmdlist"><img alt="logo" width="300px"
				height="130px" src="/resources/include/images/logo.png"></a>
		</div>
		<%
			if (session.getAttribute("m_id") == null) {
		%>
		<div id="member">
			<div>
				<a href="/member/terms">회원가입 </a>
			</div>
			<div>
				<a href="/member/login"> 로그인</a>
			</div>
		</div>
		<nav>
			<ul>
				<li onclick="location.href='/catcare/catcareList?m_number='">고양이정보</li>
				<li onclick="location.href='/mdlist/allmdlist'">전체상품
					<ul class="drop-menu menu-1">
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=사료">사료</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=간식">간식</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=모래">모래</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=화장실">화장실</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=하우스">하우스</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=이동장">이동장</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=건강관리">건강관리</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=미용">미용</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=장난감">장난감</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=기타">기타</a></li>
					</ul>
				</li>
				<li>고객센터
					<ul class="drop-menu menu-1">
						<li onclick="location.href='/faqboard/faqboardlist'">FAQ</li>
						<li onclick="location.href='/client/notice/noticeList'">공지사항</li>
						<li
							onclick="location.href='/client/inquiry/getCIList?m_id=<%=session.getAttribute("m_id")%>'">1:1문의하기</li>
					</ul>
				</li>
				<li>커뮤니티
					<ul class="drop-menu menu-1">
						<li onclick="location.href='/boast/boardList'">꿀팁/자랑게시판</li>
						<li onclick="location.href='/review/reviewList'">리뷰게시판</li>
					</ul>
				</li>
			</ul>
		</nav>

		<%
			} else {
		%>
		<div id="member">
			<div>
				<strong><%=session.getAttribute("m_name")%>님</strong> 안녕하세요 <strong id="m_mileage">가용 마일리지:<%=session.getAttribute("m_mileage") %></strong>
			</div>

			<div>
				<a
					href="/cart/cartList.do?m_number=<%=session.getAttribute("m_number")%>">장바구니 
				</a>
			</div>
			<div>
				<a href="/member/modifi"> 회원정보수정 </a><a
					href="/myorder/myorderList">나의결제내역 </a>
			</div>
			<div>
				<a
					href="/cat/catList?m_number=<%=session.getAttribute("m_number")%>">내고양이정보
				</a>
			</div>
			<div>
				<a href="/member/logout">로그아웃</a>
			</div>
		</div>
		<br>
		<nav>
			<ul>
				<li onclick="location.href='/catcare/catcareList?m_number='">고양이정보</li>
				<li onclick="location.href='/mdlist/allmdlist'">전체상품
					<ul class="drop-menu menu-1">
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=사료">사료</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=간식">간식</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=모래">모래</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=화장실">화장실</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=하우스">하우스</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=이동장">이동장</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=건강관리">건강관리</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=미용">미용</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=장난감">장난감</a></li>
						<li><a class="menu" href="/mdlist/mdlistcate?p_division=기타">기타</a></li>
					</ul>
				</li>
				<li>고객센터
					<ul class="drop-menu menu-1">
						<li onclick="location.href='/faqboard/faqboardlist'">FAQ</li>
						<li onclick="location.href='/client/notice/noticeList'">공지사항</li>
						<li
							onclick="location.href='/client/inquiry/getCIList?m_id=<%=session.getAttribute("m_id")%>'">1:1문의하기</li>
					</ul>
				</li>
				<li>커뮤니티
					<ul class="drop-menu menu-1">
						<li onclick="location.href='/boast/boardList'">꿀팁/자랑게시판</li>
						<li onclick="location.href='/review/reviewList'">리뷰게시판</li>
					</ul>
				</li>
			</ul>
		</nav>
		<%
			}
		%>

	</div>
	<hr class="style1">
</body>

</html>