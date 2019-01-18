<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>리뷰 작성 페이지</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<style>
.star-input>.input, .star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	display: inline-block;
	vertical-align: middle;
	background: url('/resources/include/images/grade_img.png') no-repeat;
}

.star-input {
	display: inline-block;
	white-space: nowrap;
	width: 225px;
	height: 40px;
	padding: 25px;
	line-height: 30px;
}

.star-input>.input {
	display: inline-block;
	width: 150px;
	background-size: 150px;
	height: 28px;
	white-space: nowrap;
	overflow: hidden;
	position: relative;
}

.star-input>.input>input {
	position: absolute;
	width: 1px;
	height: 1px;
	opacity: 0;
}

star-input>.input.focus {
	outline: 1px dotted #ddd;
}

.star-input>.input>label {
	width: 30px;
	height: 0;
	padding: 28px 0 0 0;
	overflow: hidden;
	float: left;
	cursor: pointer;
	position: absolute;
	top: 0;
	left: 0;
}

.star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	background-size: 150px;
	background-position: 0 bottom;
}

.star-input>.input>label:hover ~label{
	background-image: none;
}

.star-input>.input>label[for="p1"] {
	width: 30px;
	z-index: 5;
}

.star-input>.input>label[for="p2"] {
	width: 60px;
	z-index: 4;
}

.star-input>.input>label[for="p3"] {
	width: 90px;
	z-index: 3;
}

.star-input>.input>label[for="p4"] {
	width: 120px;
	z-index: 2;
}

.star-input>.input>label[for="p5"] {
	width: 150px;
	z-index: 1;
}

.star-input>output {
	display: inline-block;
	width: 60px;
	font-size: 18px;
	text-align: right;
	vertical-align: middle;
}
.contentBtn {
	text-align: center;
}
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript" src="/resources/include/js/star.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".product").click(function() {
			if ($(this).is(":checked")) {
				$("#p_number").val($(this).val());
				$("#o_number").val($(this).parents("td").attr("data-num"));
				$("#o_state").val($(this).parents("td").attr("data-value"));
				alert($("#p_number").val());
			} else {
			}
		})
		$("#r_insertBtn").click(function() {
			if (!chkSubmit($('#r_title'), "제목을"))
				return;
			else if (!chkSubmit($('#r_content'), "내용을"))
				return;
			else {
				if ($('#file').val() != "") {
					if (!chkFile($('#file')))
						return;
					else {
						var form = $("form")[0];
						var formData = new FormData(form);
						$.ajax({
							url : "/review/reviewInsert",
							processData : false,
							contentType : false,
							type : "post",
							data : formData,
							error : function() {
								alert("네트워크 오류! 관리자에게 문의해주세요!");
								return false;
							},
							success : function(result) {
								if (result == 1) {
									alert("리뷰작성 성공 300마일리지가 적립되었습니다.");
									location.href="/mdlist/allmdlist";
								} else {
									alert("리뷰작성 실패! 관리자에게 문의해주세요!");
									return false;
								}
							}
						});
					}
				} else {
					alert($("input[type=radio][name=r_starrate]:checked").val());
					var data = {
						"o_state" : $("#o_state").val(),
						"p_number" : $("#p_number").val(),
						"o_number" : $("#o_number").val(),
						"r_title" : $("#r_title").val(),
						"r_content" : $("#r_content").val(),
						"r_starrate" : $("input[type=radio][name=r_starrate]:checked").val()
					};
					$.ajax({
						url : "/review/reviewInsert",
						type : "post",
						data : data,
						error : function() {
							alert("네트워크 오류! 관리자에게 문의해주세요!");
							return false;
						},
						success : function(result) {
							if (result == 1) {
								alert("리뷰작성 성공! 300 마일리지 적립되었습니다.");
								location.href="/mdlist/allmdlist";
							} else {
								alert("리뷰작성 실패! 관리자에게 문의해주세요!");
								return false;
							}
						}
					});
				}
			}
		});

		$("#r_cancelBtn").click(function() {
			window.location.href = "/review/reviewList";
		});

		$('.starRev span').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			return false;
		});

		var starRating = function() {
			var $star = $(".star-input"), $result = $star.find("output>b");
			$(document).on("focusin", ".star-input>.input", function() {
				$(this).addClass("focus");
			}).on("focusout", ".star-input>.input", function() {
				var $this = $(this);
				setTimeout(function() {
					if ($this.find(":focus").length === 0) {
						$this.removeClass("focus");
					}
				}, 1000);
			}).on("change", ".star-input :radio", function() {
				$result.text($(this).next().text());
			}).on("mouseover", ".star-input label", function() {
				var $checked = $star.find(":checked");
				if ($checked.length === 0) {
					$result.text("0");
				} else {
					$result.text($checked.next().text());
				}
			});
		};
		starRating();
	});
</script>
</head>
<body>
	<%
		int p_number = (Integer) session.getAttribute("p_number");
	%>
	<div class="contentContainer">
		<div class="contentTit">
			<h3>리뷰 작성 페이지</h3>
		</div>
		<div class="contentTB">
			<form id="r_writeForm" name="r_writeForm"
				enctype="multipart/form-data">
				<input type="hidden" id="p_number" name="p_number" />
				<input type="hidden" id="o_number" name="o_number" />
				<input type="hidden" id="o_state" name="o_state" />
				<table id="reviewWrite" class="table">
					<tr>
						<td colspan="2">*적립혜택 : 리뷰 등록 시 마일리지 300점이 지급됩니다.</td>
					<tr>
						<td>대상 상품목록</td>
						<td>
							<c:choose>
								<c:when test="${ not empty partiorderList }">
									<c:forEach items="${ partiorderList }" var="list" varStatus="status">
										<table class="table">
											<tr>
												<th>상품명</th>
											</tr>
											<tr>
												<td data-num="${ list.o_number }" data-value="구매확정(리뷰작성완료)">${ list.p_name }<input type="radio" id="product" class="product" value="${ list.p_number }" />
											</tr>
										</table>
									</c:forEach>
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="product_starrate">평점</td>
						<td><div class="star-input">
								<span class="input"> <input type="radio"
									name="r_starrate" id="p1" value="1"> <label for="p1">1</label>
									<input type="radio" name="r_starrate" id="p2" value="2">
									<label for="p2">2</label> <input type="radio" name="r_starrate"
									id="p3" value="3"> <label for="p3">3</label> <input
									type="radio" name="r_starrate" id="p4" value="4"> <label
									for="p4">4</label> <input type="radio" name="r_starrate"
									id="p5" value="5"> <label for="p5">5</label>
								</span>
								<output for="star-input">
									<b>0</b>점
								</output>
							</div></td>
					</tr>
					<tr>
						<td class="title">제목</td>
						<td><input type="text" name="r_title" id="r_title" class="form-control"></td>
					</tr>
					<tr>
						<td class="content">내용</td>
						<td><input type="text" name="r_content" id="r_content" class="form-control"></td>
					</tr>
					<tr>
						<td class="fileupload">첨부파일</td>
						<td><input type="file" name="file" id="file" class="form-control"></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="contentBtn">
			<input type="button" value="등록" id="r_insertBtn" class="btn btn-info"> <input
				type="button" value="취소" id="r_cancelBtn" class="btn btn-default">
		</div>
	</div>
</body>
</html>