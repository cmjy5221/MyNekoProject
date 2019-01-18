<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리 정보</title>
<script type="text/javascript">
	var msg;
	$(document)
			.ready(
					function() {

						byteCheck("#ci_content", 2000)
						byteCheck("#ci_title", 150)
						/* 현재 선택되어있는 파일명 표시 */
						$("#ci_file")
								.change(
										function() {
											$("#fileName")
													.html(
															$("#ci_file")
																	.val()
																	.substring(
																			$(
																					"#ci_file")
																					.val()
																					.indexOf(
																							'h') + 2,
																			$(
																					'#ci_file')
																					.val().length))
										})

						/* 목록보기 버튼 이벤트 */
						$("#returnBtn")
								.click(
										function() {
											location.href = "/admin/careinfo/careinfoDetail.do?ci_number=${careinfo.ci_number}";
										})

						$("#imageShowTr").hide();

						$("#ci_file")
								.change(
										function() {
											var file = $(this)[0].files
											if ($("#ci_file").val().substring(
													$("#ci_file").val()
															.indexOf(".") + 1,
													$("#ci_file").val()
															.toString().length)
													.match(/jpg|png|jpeg|gif/) == null
													&& $("#ci_file").val()
															.toString() != '') {
												alert("상품 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다")
												$("#ci_file").val('');

											} else {
												if (file.length > 0) {
													$("#imageShowTr").show();
												} else {
													$("#imageShowTr").hide();
												}
											}
										})

						/* 
						수정 버튼 이벤트 
						수정 여부 확인 후 제출
						 */
						$("#updateBtn")
								.click(
										function() {

											var check2 = confirm('수정하시겠습니까?')
											var check1 = careinfoDataCheck()
											if (check1 != true) {
												alert(msg);
											} else {
												if (check2) {
													var form = $("form")[0];
													var formData = new FormData(
															form);
													$
															.ajax({
																url : "/admin/careinfo/careinfoModify.do",
																processData : false,
																contentType : false,
																type : "post",
																data : formData,
																error : function() {
																	alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
																	return false;
																},
																success : function(
																		result) {
																	if (result == 1) {
																		alert("수정 성공!");
																		location.href = "/admin/careinfo/careinfoDetail.do?ci_number=${careinfo.ci_number}";
																	} else {
																		alert("네트워크 문제로 수정하지 못했습니다. 잠시후에 다시 시도해주세요!");
																		return false;
																	}
																}
															});
												}
											}
										})
					})
	function byteCheck(writeSpace, size) {
		$(writeSpace).keyup(
				function() {

					var string = $(writeSpace).val(); //테스트할 문자열

					var stringLength = string.length;
					var stringByteLength = 0;

					stringByteLength = (function(s, b, i, c) {
						for (b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3
								: c >> 7 ? 2 : 1)
							;
						return b
					})(string);
					if (stringByteLength > size) {
						alert(size + "byte를 초과할 수 없습니다.")
						return false;
					} else {
						console.log(stringByteLength + " Bytes");
					}
				})

	}
	function readURL(input, showView) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$(showView).attr('src', e.target.result);

			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	/* 입력된 데이터 유효성 체크 함수*/
	function careinfoDataCheck() {
		if ($("#ci_title").val().toString().match(/^[a-zA-Z0-9가-힣\s]+$/g) == null
				|| $("#ci_content").val().toString().match(
						/^[a-zA-Z0-9가-힣\s]+$/g) == null) {
			msg = '한글,영어,숫자만 입력'
			return msg
		}
		if ($("#ci_file").val().substring($("#ci_file").val().indexOf(".") + 1,
				$("#ci_file").val().toString().length)
				.match(/jpg|png|jpeg|gif/) == null
				&& $("#ci_file").val().toString() != '') {
			msg = "정보 관련 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다"
			return msg;
		}
		return true;
	}
</script>
<style>
#btnDiv {
	text-align: center;
}
</style>
</head>
<body>
	<h3>고양이 관리 정보 수정</h3>
	<div class="table-responsive">
		<form enctype="multipart/form-data" id="updateForm" name="updateForm">
			<input type="hidden" id="page" name="page" value="${data.page}" /> <input
				type="hidden" id="pageSize" name="pageSize" value="${data.pageSize}">
			<table class="table table-striped">
				<tr>
					<th>글 번호</th>
					<td><input type="hidden" id="ci_number" name="ci_number"
						value="${careinfo.ci_number }">${careinfo.ci_number }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${careinfo.a_id}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" id="ci_title" name="ci_title"
						maxlength="75" required="required" value="${careinfo.ci_title }"
						readonly class="form-control"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea id="ci_content" name="ci_content"
							maxlength="1000" required="required" class="form-control"
							cols="100" rows="20">${careinfo.ci_content }</textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" id="ci_file" name="ci_file"
						class="form-control"><br>
						<p id="fileName">저장되어있는 파일명 ${careinfo.ci_image }</p></td>
				</tr>
				<tr id="imageShowTr">
					<th class="tac">선택한 첨부 파일</th>
					<td class="tac"><img id="imageShow"></td>
				</tr>
			</table>
		</form>
		<div id="btnDiv">
			<button type="button" id="updateBtn" name="updateBtn"
				class="btn btn-info">수정</button>
			<button type="button" id="returnBtn" name="returnBtn"
				class='btn btn-warning'>취소</button>
		</div>
	</div>
</body>
</html>