<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리 정보</title>
<script type="text/javascript">
	/* 글 등록 후 result 값을 체크후 입력된 문자열 출력 */
	if ("<c:out value='${result}'/>" == 1) {
		alert("글이 등록되었습니다.")
		location.href = "/admin/careinfo/careinfoList.do"
	}
	/* 삭제된 게시물 갯수를 체크후 출력 */
	if ("<c:out value='${deleteCount}'/>" >= 1) {
		alert(${deleteCount}+"개의 게시물이 삭제되었습니다.")
		location.href = "/admin/careinfo/careinfoList.do"
	}
	
	/* 
	날자 입력폼 컨트롤
	범위는 1990-01-01~2100-12-31
	*/
	var d = new Date();

	var s = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2);
	console.log(s);

	$(document).ready(function() {
		if ("<c:out value='${data.pageSize}' />" != "") {
			$("#pageSize").val("<c:out value='${data.pageSize}' />");
		};
		if ('${data.firstDate}' != '') {
			$("#firstDate").attr({
				"min" : "1990-01-01",
				"max" : "2100-12-31",
				"value" : "${data.firstDate}"
			});

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : "${data.lastDate}"
			});

		} else {
			$("#firstDate").attr({
				"min" : "1990-01-01",
				"max" : "2100-12-31",
				"value" : "1990-01-01"
			});

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : s
			});
		}
		
		/* firstDate 날자 입력폼 값 변경시 체크 */
		$("#firstDate").change(function() {
			if ($("#firstDate").val() > $("#lastDate").val()) {
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
					"value" : $("#firstDate").val()
				});
			} else {
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
				});
			}
		})
		/* lastDate 날자 입력폼 값 변경시 체크 */
		$("#lastDate").change(function() {
			if ($("#lastDate").val() < $("#firstDate").val()) {
				alert("이전날자의 이전시간으로 설정할 수 없습니다.");
				$("#lastDate").val($("#firstDate").val())
				$("#lastDate").attr({
					"min" : $("#firstDate").val(),
				});
			};
		});

		/* 검색버튼 클릭시 이벤트(Submit) */
		$("#searchBtn").click(function() {
			$("#searchBtn") > $("input[name='page']").val('1');
			$("#searchForm").attr({
				"method" : "GET",
				"action" : "/admin/careinfo/careinfoList.do"
			});
			$("#searchForm").submit();
		});
		/* 문자입력 검색 칸에서 엔터 입력시 이벤트 */
		$("#ci_title").keydown(function(key) {
			if (key.keyCode == 13) {
				$("#searchBtn") > $("input[name='page']").val('1');
				$("#searchForm").attr({
					"method" : "GET",
					"action" : "/admin/careinfo/careinfoList.do"
				});
				$("#searchForm").submit();
			};
		});

		/* 글 작성 버튼 입력시 이벤트 */
		$("#writeFormBtn").click(function() {
			location.href = "/admin/careinfo/careinfoWriteForm.do"
		});

		/* 하단 전체선택/해제 체크박스 상태 변경시 이벤트 */
		$("#allcheck").change(function() {

			if ($("#allcheck").prop('checked') == true) {
				$(":checkbox").each(function() {
					this.checked = true;
				});
			} else if ($("#allcheck").prop('checked') == false) {
				$(":checkbox").each(function() {
					this.checked = false;
				});
			};

		});

		/* 글목록 상단의 글번호 등록일 선택시 글 순서 재정렬 이벤트 */
		$(".order").click(function() {
			var order_by = $(this).attr("data-value");
			console.log("선택값 : " + order_by);

			$("#order_by").val(order_by);
			console.log($("#order_by").val());
			if ($("#order_sc").val() == 'DESC') {
				$("#order_sc").val('ASC');
			} else {
				$("#order_sc").val('DESC');
			};
			$("#searchBtn") > $("input[name='page']").val('1');
			$("#searchForm").attr({
				"method" : "GET",
				"action" : "/admin/careinfo/careinfoList.do"
			});
			$("#searchForm").submit();
		});

		/* 삭제 버튼 이벤트 */
		$("#deleteBtn").click(function() {
			if ($("input:checkbox[name=del_check]:checked").length == 0) {
				alert('삭제할 게시글을 체크해주시기 바랍니다.')
			} else {
				var check=confirm($("input:checkbox[name=del_check]:checked").length+"건의 게시글을 삭제하시겠습니까?");
				if(check){
				$("#listDelete").attr({
					'method' : 'post',
					'action' : '/admin/careinfo/careinfoDelete.do'
				});
				$("#listDelete").submit();
				};
			};
		});
		
		/* 개별 글 선택시 상세보기 페이지로 이동하는 이벤트 */
		$(".goDetail").click(function(){
			var ci_number=$(this).data("num")
			$("#ci_number").val(ci_number)
			$("#optionForm").attr({
				"method":"get","action":"/admin/careinfo/careinfoDetail.do"
			});
			$("#optionForm").submit();
		});
	});

	/* type:date의 초기값 설정시 (ex:1월= 01)로 표현하기 위한 함수 */
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		};
		return zero + n;
	}

	/* 페이징 처리용 함수 */
	function goPage(page) {
		$("#page").val(page);
		$("#ci_number").attr({"disabled" : "disabled"})
		$("#optionForm").attr({
			"method" : "get",
			"action" : "/admin/careinfo/careinfoList.do",
		});
		$("#optionForm").submit();
	}
	
</script>
<style type="text/css">
.class:hover {
	cursor: pointer;
}

.form-control {
	width: 25%;
	float: left;
}

.label {
	float: left;
	color: black;
}

th, td {
	text-align: center;
}

#btnDiv {
	text-align: center;
}

#careinfoPage {
	text-align: center;
}
</style>
</head>
<body>
	<h3>고양이 관리 정보</h3>

	<div class="table-responsive" >
		<form id="optionForm">
			<input type="hidden" id="page" name="page" value="${data.page}" /> <input
				type="hidden" id="pageSize" name="pageSize" value="${data.pageSize}">
			<input type="hidden" id="ci_number" name="ci_number" value="0">
		</form>
		<form id="searchForm">
			<input type="date" id="firstDate" name="firstDate"
				class="form-control"><label class="label">~</label><input
				type="date" id="lastDate" name="lastDate" class="form-control"><input
				type="search" id="ci_title" name="ci_title"
				value="${data.ci_title }" class="form-control"> <input
				type="hidden" id="page_search" name="page" value="${data.page}" />
			<input type="hidden" id="order_by" name="order_by"
				value="${data.order_by}" /> <input type="hidden" id="order_sc"
				name="order_sc" value="${data.order_sc}" /> <input type="hidden"
				id="pageSize_search" name="pageSize" value="${data.pageSize}">
			<button type="button" id="searchBtn" name="searchBth"
				class="btn btn-default">검색</button>
		</form>
	</div>
	<div>
		<form id="listDelete" name="listDelete">
			<table class="table table-striped">
				<thead>
					<tr>
						<th data-value="ci_number" class="order">글번호<c:choose>
								<c:when
									test="${data.order_by=='ci_number' and  data.order_sc=='ASC'}">▲</c:when>
								<c:when
									test="${data.order_by=='ci_number' and  data.order_sc=='DESC'}">▼</c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose></th>
						<th>제목</th>
						<th data-value="ci_date" class="order">등록일 <c:choose>
								<c:when
									test="${data.order_by=='ci_date' and  data.order_sc=='ASC'}">▲</c:when>
								<c:when
									test="${data.order_by=='ci_date' and  data.order_sc=='DESC'}">▼</c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose>
						</th>
						<th>선택</th>
					</tr>
					<c:choose>
						<c:when test="${not empty boardList }">
							<c:forEach var="list" items="${boardList}" varStatus="status">
								<tr>
									<td class="tac">${count - status.index}</td>
									<td class="tac"><label class="goDetail"
										data-num="${list.ci_number }">${list.ci_title }</label></td>
									<td class="tac"><fmt:formatDate value="${ list.ci_date }"
											pattern="yyyy/MM/dd hh:mm:ss" /></td>
									<td class="tac"><input type="checkbox"
										value="${list.ci_number }" id="del_check" name="del_check"></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="tac" colspan="4"><font color="black">게시글이
										없습니다.</font></td>
							</tr>
						</c:otherwise>
					</c:choose>
			</table>
		</form>
		<div id="careinfoPage">
			<tag:paging page="${param.page}" total="${total}"
				list_size="${data.pageSize}" />
		</div>
		<div id="btnDiv">
			<input type="button" id="writeFormBtn" name="writeFormBtn"
				value="글쓰기" class="btn btn-info"> <input type="button"
				id="deleteBtn" name="deleteBtn" value="선택삭제" class="btn btn-danger">
			<label for="allcheck">전체선택/해제</label><input type="checkbox"
				id="allcheck" name="allcheck">
		</div>

	</div>
</body>
</html>