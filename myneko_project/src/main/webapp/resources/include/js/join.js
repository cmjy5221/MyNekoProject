function sample6_execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullAddr = ''; // 최종 주소 변수
			var extraAddr = ''; // 조합형 주소 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				fullAddr = data.roadAddress;

			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				fullAddr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('m_postcode').value = data.zonecode; // 5자리
			// 새우편번호
			// 사용
			document.getElementById('m_address').value = fullAddr;

			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('m_detailaddress').focus();
		}
	}).open();
}

$(function() {
	// 정규표현식
	var reg_uid = /^[a-z0-9]{6,16}$/; // 5~16자 영문소문자, 숫자 사용가능
	var reg_upw = /^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{6,24}$/;
	// 이름 정규식
	var reg_name = /^[가-힣]{2,5}$/; // 2~5글자 한글

	// 6~16자 영문소문자, 숫자, 특수문자 혼합하여 사용

	$("#idCheck").on("click", function() {
		var id = $("#m_id").val();

		if (reg_uid.test($("#m_id").val())) {
			$.ajax({
				url : "/member/idCheck",
				type : "post",
				data : "m_id=" + id,
				success : function(data) {
					if (data == 0) {
						alert("사용가능한 아이디 입니다.");
						$("#m_id").attr("readonly", true);

					} else {
						alert("이미 사용중인 아이디 입니다.");
						$("#m_id").val("").focus();
					}
				},
				error : function() {
					alert("ERROR 관리자에게 문의하세요");
					$("#m_id").val("").focus();
				}
			});

		} else {
			alert("아이디가 형식에 맞지 않습니다 다시 입력 해 주세요");
			$("#m_id").val("").focus();
		}

	});

	$("#m_name").change(function() {
		if (!reg_name.test($("#m_name").val())) {
			alert("이름이 형식에 맞지 않습니다.");
			$("#m_name").val("").focus();
		}
	});

	$("#passwordChk").change(
			function() {
				if (reg_upw.test($("#m_password").val())) {
					if ($("#passwordChk").val() == $("#m_password").val()) {
						$("#password").empty().append("<p>비밀번호 일치").css(
								"color", "blue");
						$("#joinBtn").attr("disabled", false);
					} else {
						$("#password").empty().append("<p>비밀번호 불일치").css(
								"color", "red");
						$("#joinBtn").attr("disabled", true);
					}
				} else {
					alert("비밀번호가 형식에 맞지 않습니다 다시 입력 해 주세요");
					$("#passwordChk").val("");
					$("#m_password").val("").focus();
				}
			});

	
});