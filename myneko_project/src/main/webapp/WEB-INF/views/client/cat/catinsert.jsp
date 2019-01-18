<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 등록</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
</head>
<body>
	<div class="table-responsive">
		<form action="/cat/insert" method="POST" encType="multipart/form-data">
			<table class="table table-striped">
				<caption>반려묘 정보 등록</caption>
				<tr>
					<td>이름</td>
					<td><input type="hidden" name="m_number"
						id="m_number" value="<%=session.getAttribute("m_number")%>"><input
						type="text" id="c_name" name="c_name" required="required" class="form-control"></td>
				<tr>
					<td>프로필</td>
					<td><input type="file" name="file" class="form-control"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="radio" name="c_gender" value="남"
						required="required" checked="checked">남아<input
						type="radio" name="c_gender" value="여" required="required">여아</td>
				</tr>
				<tr>
					<td>품종 EX)코리안 숏 헤어</td>
					<td><select id="c_division" name="c_division"
						required="required" class="form-control">
							<option>-----</option>
							<option value="--------">단모종</option>
							<option value="코리안 숏 헤어">코리안 숏 헤어</option>
							<option value="데본렉스">데본렉스</option>
							<option value="러시안 블루">러시안 블루</option>
							<option value="맹크스">맹크스</option>
							<option value="발리네즈">발리네즈</option>
							<option value="뱅갈">뱅갈</option>
							<option value="버미즈">버미즈</option>
							<option value="봄베이">봄베이</option>
							<option value="브리티시 숏헤어">브리티시 숏헤어</option>
							<option value="샤르트뢰">샤르트뢰</option>
							<option value="샤트룩스">샤트룩스</option>
							<option value="스코티쉬폴드">스코티쉬폴드</option>
							<option value="시암고양이">시암고양이</option>
							<option value="싱가퓨라">싱가퓨라</option>
							<option value="아메리카 숏헤어">아메리카 숏헤어</option>
							<option value="아비시니안">아비시니안</option>
							<option value="오리엔탈">오리엔탈</option>
							<option value="오시캣">오시캣</option>
							<option value="유로피안버미즈">유로피안버미즈</option>
							<option value="이집션 마우">이집션 마우</option>
							<option value="자바니즈">자바니즈</option>
							<option value="캘리포니안 스팽글드">캘리포니안 스팽글드</option>
							<option value="컬러포인트 숏헤어">컬러포인트 숏헤어</option>
							<option value="코니시렉스">코니시렉스</option>
							<option value="코렛">코렛</option>
							<option value="통키니즈">통키니즈</option>
							<option value="피터볼드">피터볼드</option>
							<option value="픽시밤">픽시밤</option>
							<option value="하바나브라운">하바나브라운</option>
							<option value="스핑크스">스핑크스</option>
							<option value="--------">장모종</option>
							<option value="네벨룽">네벨룽</option>
							<option value="노르웨이지언포레스트">노르웨이지언포레스트</option>
							<option value="라가머핀">라가머핀</option>
							<option value="라판">라판</option>
							<option value="렉돌">렉돌</option>
							<option value="먼치킨">먼치킨</option>
							<option value="메인쿤">메인쿤</option>
							<option value="버만">버만</option>
							<option value="셀커크렉스">셀커크렉스</option>
							<option value="소말리">소말리</option>
							<option value="시베리안">시베리안</option>
							<option value="아메리칸 밥테일">아메리칸 밥테일</option>
							<option value="아메리칸와이어헤어">아메리칸와이어헤어</option>
							<option value="이그저틱">이그저틱</option>
							<option value="터키쉬 앙고라">터키쉬 앙고라</option>
							<option value="터키시반">터키시반</option>
							<option value="페르시안">페르시안</option>
							<option value="히말라얀">히말라얀</option>
							<option value="기타">기타</option>
					</select></td>
				</tr>
				<tr>
					<td>생일 Ex)2018-01-01</td>
					<td><input type="date" id="c_birth" name="c_birth"
						min="1975-12-30" max="2019-1-1" class="form-control"></td>
				</tr>
				<tr>
					<td>식성</td>
					<td><select id="c_taste" name="c_taste" required="required" class="form-control">
							<option value="공통">아무거나 잘 먹어요</option>
							<option value="습식선호">습식선호</option>
							<option value="건식선호">건식선호</option>
							<option value="생식선호">생식선호</option>
					</select></td>
				</tr>
				<tr>
					<td>중성화 여부</td>
					<td><input type="radio" checked="checked"
						name="c_neutralization" value="O" required="required">O <input
						type="radio" name="c_neutralization" value="X">X</td>
				</tr>
				<tr>
					<td>보유질병 Ex)비만</td>
					<td><select id="c_disease" name="c_disease"
						required="required" class="form-control">
							<option value="비만">비만</option>
							<option value="피부질환">피부질환</option>
							<option value="안구질환">안구질환</option>
							<option value="호흡기질환">호흡기질환</option>
							<option value="위장질환">위장질환</option>
							<option value="관절질환">관절질환</option>
					</select></td>
				</tr>
			</table>
			<div>
				<input type="button" onclick="location.href='/cat/catList'"
					value="돌아가기" class="btn btn-default">
				<button id="catInsertBtn" class="btn btn-info">등록</button>
			</div>
		</form>
	</div>
</body>

</html>
