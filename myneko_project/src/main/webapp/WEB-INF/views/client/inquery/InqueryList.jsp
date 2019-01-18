<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의1:1문의내역</title>
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<style>
	.form-control {
		width: 25%;
		float: left;
	}
	
	label {
		float: left;
	}
	
	#btnDiv {
		text-align: center;
	}
	
	#inqueryPage {
		text-align: center;
	}
	
	.on {
		font-size : 15pt;
		color: black;
	}
	
	a:active {
		text-decoration: none;
		color: black;
	}
	
	a:visited {
		text-decoration: none;
		color: black;
	}
	
	a:link {
		text-decoration: none;
		color: black;
	}
	
	a:hover {
		text-decoration: none;
		color: black;
	}
</style>
</head>
<body>
	<%
		if (session.getAttribute("m_id") != null) {
	%>
	<script type="text/javascript">
	/* 문의하기 버튼 클릭시 처리 이벤트 */
	$(document)
			.ready(
					function() {
						$("#qnaBtn").click(function() {
							location.href = "/client/inquiry/CIinsert";
						});

						/* 검색 후 검색 대상과 검색 단어 출력 */
						var word = "<c:out value='${data.keyword}' />";
						var value = "";
						if (word != "") {
							$("#keyword").val(
									"<c:out value='${data.keyword}' />");
							$("#search")
									.val("<c:out value='${data.search}' />");

							if ($("#search").val() != 'i_content') {
								//:contains()는 특정 텍스트를 포함한 요소반환 	
								if ($("#search").val() == 'i_title')
									value = "#list tr td.goDetail";
								$(value + ":contains('" + word + "')")
										.each(
												function() {
													var regex = new RegExp(
															word, 'gi');
													$(this)
															.html(
																	$(this)
																			.text()
																			.replace(
																					regex,
																					"<span class='required'>"
																							+ word
																							+ "</span>"));
												});
							}
						}

						//한페이지에 보여줄 레코드 수 조회 후 선택한 값 그대로 유지하기 위한 설정
						if ("<c:out value='${data.pageSize}'/>" != "") {
							$("#pageSize").val(
									"<c:out value='${data.pageSize}'/>");
						}
						/* 검색 대상이 변경될 때마다 처리 이벤트 */
						$("#search").change(function() {
							if ($("#search").val() == "all") {
								$("#keyword").val("전체 데이터 조회합니다.");
							} else if ($("#search").val() != "all") {
								$("#keyword").val("");
								$("#keyword").focus();
							}
						});

						/*검색 버튼 클릭 시 처리 이벤트*/
						$("#searchData").click(function() {
							alert($("#keyword").val())
							if ($("#search").val() != "all") {
								if (!chkSubmit($('#keyword'), "검색어를"))
									return;
							}
							goPage(1);
						});

						$(".order").click(function() {
							var order_by = $(this).attr("data-value");
							console.log("선택값:" + order_by);
							$("#order_by").val(order_by);
							if ($("#order_sc").val() == 'DESC') {
								$("#order_sc").val('ASC');
							} else {
								$("#order_sc").val('DESC');
							}
							goPage(1);
						});

						//한페이지에 보여줄 레코드 수 변경될 때마다 처리 이벤트
						$("#pageSize").change(function() {
							goPage(1);
						});

						/*검색과 한 페이지에 보여줄 레코드 수 페이징을 위한 실질적인 처리함수*/
					});
	function goPage(page) {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#f_search").attr({
			"method" : "get",
			"action" : "/client/inquiry/getCIList"
		});
		$("#f_search").submit();
	}
</script>
	<div class="table-responsive">
		<form id="f_search" name="f_search">
			<input type="hidden" id="m_id" name="m_id" value="${ m_id }" />
			<input type="hidden" id="page" name="page" value="${data.page }"> <input
				type="hidden" id="order_by" name="order_by" value="${data.order_by}" />
			<input type="hidden" id="order_sc" name="order_sc"
				value="${data.order_sc}" />
			<table class="table">
				<colgroup>
					<col width="70%"></col>
					<col width="30"></col>
				</colgroup>
				<tr>
					<td id="tac"><select id="search"
						name="search" class="form-control">
							<option value="">전체</option>
							<option value="i_title">제목</option>
							<option value="i_content">내용</option>
					</select><input type="text" name="keyword" id="keyword"
						placeholder="검색어를입력하세요" class="form-control" /><input type="button" value="검색"
						id="searchData" class="btn btn-default" /></td>
						<%--검색기능 종료 --%>
				</tr>
			</table>
		</form>
	</div>
	<form id="detailForm">
		<input type="hidden" name="page" value="${data.page }"> <input
			type="hidden" name="pageSize" value="${data.pageSize }">
		<table class="table table-striped">
			<tr>
				<th class="tac">글번호</th>
				<th class="tac">글제목</th>
				<th class="tac">작성일</th>
				<th class="tac">답변여부</th>
			</tr>

			<%-- 데이터 출력 --%>
			<c:choose>
				<c:when test="${ not empty inquiryList }">
					<c:forEach items="${ inquiryList }" var="inquiry" varStatus="status">
						<tr>
							<td>${ inquiry.i_number }</td>
							<td><a
								href="/client/inquiry/inquiryDetail?i_number=${ inquiry.i_number }">${ inquiry.i_title }</a>
							</td>
							<td>${inquiry.i_date }</td>
							<td>${ inquiry.i_repwhether }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" align="center">작성하신 문의내역이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</form>
	<div id="btnDiv">
		<input type="button" value="문의하기" id="qnaBtn" class="btn btn-info">
	</div>
	<%--페이지 네비게이션 --%>
	<div id="inqueryPage">
	<tag:paging page="${param.page }" total="${total }" 
	list_size="${ data.pageSize }"/>
	</div>
	<%-- 페이지 네비게이션 종료 --%>
	<%
		} else if(session.getAttribute("m_id")==null) {
	%>
	<script type="text/javascript">
		alert("로그인 후 이용 할 수 있습니다.");
		window.location.href = "/member/login";
	</script>
	<%
		}
	%>
	
</body>
</html>