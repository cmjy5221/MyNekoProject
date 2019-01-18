<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리 정보 등록</title>
<script type="text/javascript">
	var msg;
	$(document).ready(function() {
		byteCheck("#ci_content", 2000)
		byteCheck("#ci_title", 150)

		/* 등록 버튼 클릭시 이벤트 */
		$("#insertBtn").click(function() {
			careinfoDataCheck();
			if (msg != null && msg != '') {
				alert(msg)
			} else {
				var form = $("form")[0];
				var formData = new FormData(form);
				$.ajax({
					url : "/admin/careinfo/careinfoWrite.do",
					processData : false,
					contentType : false,
					type : "post",
					data : formData,
					error : function() {
						alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
						return false;
					},
					success : function(result) {
						if (result == 1) {
							alert("등록 성공!");
							location.href = "/admin/careinfo/careinfoList.do";
						} else {
							alert("네트워크 문제로 등록하지 못했습니다. 잠시후에 다시 시도해주세요!");
							return false;
						}
					}
				});
			}
		})

		/* 목록보기 버튼 클릭시 이벤트 */
		$("#returnBtn").click(function() {
			location.href = "/admin/careinfo/careinfoList.do"
		})
		
		$("#imageShowTr").hide();
		
		$("#ci_file").change(
			function() {
				var file = $(this)[0].files
				if ($("#ci_file").val().substring(
						$("#ci_file").val().indexOf(".") + 1,
						$("#ci_file").val().toString().length)
						.match(/jpg|png|jpeg|gif/) == null
						&& $("#ci_file").val().toString() != '') {
					alert("상품 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다")
					$("#ci_file").val('');

				} else {
					if (file.length > 0) {
						readURL(this, "#imageShow");
						$("#imageShowTr").show();
					} else {
						$("#imageShowTr").hide();
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

	/* 입력한 데이터 유효성 검사 함수 */
	function careinfoDataCheck() {
		if ($("#ci_title").val().toString().match(/^[a-zA-Z0-9가-힣\s]+$/g) == null) {
			msg = '제목은 한글,영어,숫자만 입력'
			$("#ci_title").focus()

		} else if ($("#ci_content").val().toString().match(
				/^[a-zA-Z0-9가-힣\s]+$/g) == null) {
			msg = '내용은 한글,영어,숫자만 입력'
			$("#ci_content").focus()
		} else if ($("#ci_file").val().toLowerCase().substring(
				$("#ci_file").val().indexOf(".") + 1,
				$("#ci_file").val().toString().length)
				.match(/jpg|png|jpeg|gif/) == null
				&& $("#ci_file").val().toString() != '') {
			msg = "정보 관련 이미지는 jpg, jpeg, gif, png 형식 파일만 가능합니다"
			return msg;
		}
	}
</script>
<style>
.form-control {
	width: 99%;
}

.tac {
	text-align: center;
	align: center;
}

#btnDiv {
	text-align: center;
}
</style>
</head>
<body>
	<h3>고양이 관리 정보 등록</h3>
	<div class="table-responsive">
		<form enctype="multipart/form-data" id="insertForm" name="insertForm">
			<span id="byteCheck"></span>
			<table class="table table-striped">
				<tr>
					<th class="tac">작성자</th>
					<td class="tac"><input type="hidden" id="a_number"
						name="a_number" value="${ a_number }"><input type="text"
						value="${ adminId }" class="form-control" readonly /></td>
				</tr>
				<tr>
					<th class="tac">제목</th>
					<td class="tac"><input type="text" id="ci_title"
						name="ci_title"  required="required"
						class='form-control'></td>
				</tr>
				<tr>
					<th class="tac">내용</th>
					<td class="tac"><textarea id="ci_content" name="ci_content"
							required="required" cols="100" rows="20" class="form-control"></textarea></td>
				</tr>
				<tr>
					<th class="tac">첨부이미지</th>
					<td class="tac"><input type="file" id="ci_file" name="ci_file"
						class="form-control"></td>
				</tr>
				<tr id="imageShowTr">
					<th class="tac">선택한 첨부 파일</th>
					<td class="tac"><img id="imageShow"></td>
				</tr>
			</table>
		</form>
		<div id="btnDiv">
			<button type="button" id="insertBtn" name="insertBtn"
				class="btn btn-info">등록</button>
			<button type="button" id="returnBtn" name="returnBtn"
				class="btn btn-warning">취소</button>
		</div>
	</div>
</body>
</html>