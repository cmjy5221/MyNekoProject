<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">

body {
	width: 100%;
}

#catTable {
	text-align: center;
	margin-bottom: 50px;
}
#btnDiv {
	text-align: center;
}
</style>
</head>
<body>
	<div class="center-block table-responsive">
		<h3>반려묘 정보 상세보기</h3>
		<table id="catTable" class="table table-dark">
			<tr class="table-success">
				<td>이름</td>
				<td><strong>${cvo.c_name}</strong></td>
				<td rowspan="2"><img alt="프로필사진" class="img-thumbnail"
					src="/uploadStorage/cat/${cvo.c_profile}" width="365px"
					height="365px"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><strong>${cvo.c_gender}</strong></td>
			</tr>
			<tr>
				<td>품종</td>
				<td colspan="2"><strong>${cvo.c_division }</strong></td>
			</tr>
			<tr>
				<td>생일</td>
				<td colspan="2"><strong>${cvo.c_birth }</strong></td>
			</tr>
			<tr>
				<td>식성</td>
				<td colspan="2"><strong>${cvo.c_taste }</strong></td>
			</tr>
			<tr>
				<td>질병</td>
				<td colspan="2"><strong>${cvo.c_disease }</strong></td>
			</tr>
			<tr>
				<td>중성화여부</td>
				<td colspan="2"><strong>${cvo.c_neutralization }</strong></td>
			</tr>
		</table>
		<div id="btnDiv"><button class="btn btn-secondary" onclick="history.go(-1)">목록보기</button></div>
	</div>
</body>
</html>