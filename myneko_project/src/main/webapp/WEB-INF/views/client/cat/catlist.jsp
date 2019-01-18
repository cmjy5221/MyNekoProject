<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 고양이목록</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>


<script type="text/javascript">
	function checkAll() {
		if ($("#allCheck").is(':checked')) {

			$("input[id=number]").prop("checked", true);
		} else {
			$("input[id=number]").prop("checked", false);
		}
	}

	function check() {
		$("#number").on("click", function() {
			checkRow = checkRow + $(this).val() + ",";
			checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); //맨끝 콤마 지우기
			$("#c_number").val(checkRow);
		});
	}

	function deleteAction() {
		var checkRow = "";
		$("input[id='number']:checked").each(function() {
			checkRow = checkRow + $(this).val() + ",";
		});

		checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); //맨끝 콤마 지우기
		$("#c_number").val(checkRow);
		if (checkRow == '') {
			alert("삭제할 대상을 선택하세요.");
		} else {

			if (confirm("정보를 삭제 하시겠습니까?")) {
				$.ajax({
					url : "/cat/delete",
					type : "post",
					data : {
						"c_number" : $("#c_number").val()
					},
					success : function(result) {
						if (result == 1) {
							location.reload();
						} else {
							alert("삭제 실패");
						}
					},
					error : function() {
						alert($("#c_number").val());
					}

				});

			}
		}//if/else end
	}

	function represent() {
		if (confirm("대표고양이로 지정하시겠습니까?"))
			$("input[name=c_represent]:checked").each(function() {
				$("#c_represent").val("O");
				var cat = $(this).val();
				var member = $("#m_number").val();
				var represent = $("#c_represent").val();
				$.ajax({
					url : "/cat/represent",
					type : "post",
					data : {
						"c_number" : cat,
						"m_number" : member,
						"c_represent" : represent
					},
					success : function(result) {
						if (result == 1) {
							alert("대표고양이로 설정되었습니다.");
							window.location.reload();
						} else {
							alert("등록실패");
						}
					}
				});
			});
	}
</script>
<style type="text/css">
body {
	width: 100%;
}

#wapper {
	width: 80%;
	margin: auto;
}

.container {
	clear: both;
}

#cat {
	width: 30%;
	float: left;
	margin: 50px;
	text-align: center;
}

#footer {
	clear: both;
}
</style>

</head>
<body>
	<div id="wapper">
		<c:choose>
			<c:when test="${not empty catList}">
				<a href="/cat/catInsert">추가하기</a>
				<br>
				<div>사진클릭 시 상세보기 화면으로 이동합니다.</div>
				<input type="checkbox" id="allCheck" onclick="checkAll()">전체선택
				<br>
				<c:forEach items="${catList}" var="cat">
					<c:if test="${cat.c_represent == 'O' }">
						<div id="cat" class="border border-secondary">
							<div>대표</div>
							<div>
								<a href="/cat/detail?c_number=${cat.c_number }"><img
									class="thumbnail" src="/uploadStorage/cat/${cat.c_profile}"
									width="300px" height="250px"></a>
							</div>
							<div>${cat.c_name}</div>
							<div>${cat.c_birth}세</div>
							<div>
								<input type="hidden" id="m_number" value="${cat.m_number }">
								<input type="hidden" id="c_represent" />
							</div>
							<div>
								<input type="hidden" id="c_represent"
									value="${cat.c_represent }">
							</div>
							<div>
								<input type="checkbox" id="number" value="${cat.c_number}"
									onclick="check()">
							</div>
						</div>
					</c:if>
					<c:if test="${cat.c_represent == 'X' }">
						<div id="cat" class="border border-secondary">
							<div>
								대표고양이 지정하기<input type="radio" name="c_represent"
									value="${cat.c_number}" onclick="represent()">
							</div>
							<div>
								<a href="/cat/detail?c_number=${cat.c_number }"><img
									class="thumbnail" src="/uploadStorage/cat/${cat.c_profile}"
									width="300px" height="250px"></a>
							</div>
							<div>${cat.c_name}</div>
							<div>${cat.c_birth}세</div>
							<div>
								<input type="hidden" id="m_number" value="${cat.m_number }">
							</div>
							<div>
								<input type="hidden" id="c_represent"
									value="${cat.c_represent }">
							</div>
							<div>
								<input type="checkbox" id="number" value="${cat.c_number}"
									onclick="check()">
							</div>
						</div>
					</c:if>
				</c:forEach>
				<br>
				<div>
					<input type="hidden" id="c_number" name="c_number">
					<button onclick="deleteAction()">선택 삭제</button>
				</div>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					if (confirm("등록된 고양이가 없습니다 등록 하시겠습니까?")) {
						location.href = '/cat/catInsert';
					} else {
						history.back();
					}
				</script>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>