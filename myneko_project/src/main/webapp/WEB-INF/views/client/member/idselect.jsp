<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
	<table>
		<tr>
			<td>이름</td>
			<td colspan="2"><input type="text"></td>
		</tr>
		<tr>
			<td>이메일 주소</td>
			<td colspan="2"><input type="email"></td>
		</tr>
		<tr>
			<td colspan="3"><button>메일로 인증번호 보내기</button></td>
		</tr>
		<tr>
			<td>인증번호</td>
			<td><input type="text"></td>
			<td><button>인증</button></td>
		</tr>

	</table>
	<div id="getId"></div>
</body>
</html>