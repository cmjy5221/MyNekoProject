<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
	<style type="text/css">
	#content{
	width:100%;
	background-color: f63;
	}
	#join{
	width: 40%;
	margin: auto;
	margin-bottom: 20px;
	}
	</style>
<script type="text/javascript" src="/resources/include/js/join.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body id="content">
<div >
<div class="center-block" id="join">
		<form class="form-horizontal" id="joinForm" action="/member/join" method="post">
			<div>
				<div><label class="control-label">아이디</label></div>
				<div>
					<input class="form-control" id="m_id" name="m_id" placeholder="소문자영어+숫자 6~15자리"
						maxlength="15" required="required" min="6">
				</div>
				<div></div>
				<input type="button" value="중복확인" id="idCheck" onclick="idCheck">
			</div>
			<div>
				<div><label class="control-label">패스워드</label></div>
				<div>
					<input class="form-control" name="m_password" id="m_password" type="password"
						required="required">
				</div>
			</div>
			<div>
				<div><label class="control-label">패스워드중복확인</label></div>
				<div>
					<input class="form-control" id="passwordChk" type="password" required="required">
					<div id="password"></div>
				</div>
			</div>
			<div>
				<div><label class="control-label">이름</label></div>
				<div>
					<input class="form-control" id="m_name" name="m_name" type="text" required="required"
						maxlength="10">
				</div>
			</div>
			<div>
				<div><label class="control-label">핸드폰 번호</label></div>
				<div>
					<input class="form-control" id="m_phone" name="m_phone" type="tel" required="required"
						maxlength="11">
				</div>
			</div>
			<div>
				<div><label class="control-label">이메일</label></div>
				<div>
					<input class="form-control" id="m_email" name="m_email" type="email" required="required">
				</div>
			</div>
			<div>
				<div><label class="control-label">주소</label></div>
				<div>
					<input class="form-control" type="text" name="m_postcode" id="m_postcode" placeholder="우편번호"
						required="required" readonly="readonly">
						
						 <input 
						type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					
					<input type="text" id="m_address" name="m_address" placeholder="주소" class="form-control"
						required="required" readonly="readonly"> 
						
						<input class="form-control"
						type="text" id="m_detailaddress" name="m_detailaddress" placeholder="상세주소" required="required">
				</div>
			</div>
			<div>
				<div>
					<button type="submit" id="joinBtn" class="btn btn-secondary btn-lg btn-block" disabled="disabled">회원가입 완료하기</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>