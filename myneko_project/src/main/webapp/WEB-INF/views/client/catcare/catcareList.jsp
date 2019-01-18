<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 관리정보 글 목록</title>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/catcareList.css?ver=6" />
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#gocart").click(function(){
			$("#toCart").attr({
				"method" : "get",
				"action" : "/cart/cartList.do"
			});
			$("#toCart").submit();
		});
		/* 검색 후 검색 대상과 검색 단어 출력 */
		var word="<c:out value='${data.keyword}'/>";
		var value="";
		if(word!=""){
			$("#keyword").val("<c:out value='${data.keyword}'/>");
			$("#search").val("<c:out value='${data.search}'/>");
			
			if($("#search").val()!='ci_content'){
				if($("#search").val()=='ci_title')
					value = "#list tr td.goDatail";
				else if($("#search").val()=='ci_writer')
					value="#list tr td.name"
				$(value+":contains('"+word+"')").each(function(){
					var regex = new RegExp(word,'gi');
					$(this).html($(this).text().replace(regex,
						"<span class='required'>"+word+"</span>"));
				});
				
			}
		}
		
		/* 한페이지에 보여줄 레코드 수 조회 후 선택한 값 그대로 유지하기 위한 설정*/
		if("<c:out value='${data.pageSize}'/>"!=""){
			$("#pageSize").val("<c:out value='${data.pageSize}'/>");
		}
		
		/* 검색 대상이 변경 될 때 마다 처리 이벤트 */
		$("#search").change(function() {
			if($("#search").val()=="all"){
				$("#keyword").val("전체 데이터 조회");
			}else if($("#search").val()!="all"){
				$("#keyword").val("");
				$("#keyword").focus();
			}
		});
		
		/* 검색 버튼 클릭 시 처리 이벤트 */
		$("#searchData").click(function(){
			if($("#search").val()!="all"){
				if(!chkSubmit($('#keyword'),"검색어를")) return;
			}
			goPage(1);
		});
		
		$(".order").click(function(){
			var order_by = $(this).attr("data-value");
			console.log("선택값: " + order_by);
			
			$("#order_by").val(order_by);
			if($("#order_sc").val()=='DESC'){
				$("#order_sc").val('ASC');
			}else{
				$("#order_sc").val('DESC');
			}
			goPage(1);
		});
		
		/* 한 페이지에 보여줄 레코드 수 변경될 때마다 처리 이벤트 */
		$("#pageSize").change(function(){
			goPage(1);
		});
		
		/* 제목 클릭 시 상세 페이지 이동 */
		$(".goDetail").click(function() {
			var ci_number = $(this).parents("tr").attr("data-num");
			$("#ci_number").val(ci_number);
			console.log("글 번호 : " + ci_number);
			// 상세 페이지로 이동하기 위해 Form추가 (id : detailForm)
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/catcare/catcareDetail.do"
			});
			$("#detailForm").submit();
		});

	});
	
	
	function chkSubmit(item, msg){
		if(item.val().replace(/\s/g,"")==""){
			alert(msg+"입력해 주세요");
			item.val("");
			item.focus();
			return false;
		} else {
			return true;
		}
	}
	
	/* 검색과 한 페이지에 보여줄 레코드 수 처리 및 페이징을 위한 실질적인 처리 함수 */
	function goPage(page){
		if($("#search").val()=="all"){
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#f_search").attr({
			"method":"get",
			"action":"/catcare/catcareList.do"
		});
		$("#f_search").submit();
	}
	

</script>
</head>
<body>
	<div id="listContainer">
		<div>
			<div id="right">
				<%-- 
					테스트 입니다.
				<c:if test="${empty sessionScope.m_id }">
					<!-- sessionScopre.id가 없으면 -->
					<a href="" id="login">로그인</a>
				</c:if>
				<c:if test="${not empty sessionScope.m_id }">
					<!-- sessionScopre.id가 있으면 -->
					${sessionScope.m_id }님&nbsp;&nbsp;<strong>|</strong>&nbsp;
					<a href="" id="logout">로그아웃</a>
					<br />
				</c:if> --%>
			</div>
			<form id="toCart">
				<input type="hidden" name="m_number" id="m_number" value="<%= session.getAttribute("m_number") %>" /> 
			</form>
			
			<!-- 장바구니 a태그 테스트용 -->
			<!-- <a href="#" id="gocart">장바구니</a> -->
			<br>
			
			<h2 id="topname">고양이 관리정보</h2>

			<!-- 상세 페이지 이동을 위한 form -->
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="ci_number" id="ci_number">
				<input type="hidden" name="page" value="${data.page}">
				<input type="hidden" name="pageSize" value="${data.pageSize}">
			</form>
			
			<!-- 검색 기능 -->
			<div id="catcareSearch">
				<form id="f_search" name="f_search">
					<input type="hidden" id="page" name="page" value="${data.page}" />
					<input type="hidden" id="order_by" name="order_by" value="${data.order_by}" />
					<input type="hidden" id="order_sc" name="order_sc" value="${data.order_sc}" />
						<table summary="검색">
							<tr>
								<td>
									<select id="search" name="search" style="width: 100px; height: 23px">
										<option value="all">전체</option>
										<option value="ci_title">제목</option>
										<option value="ci_writer">작성자</option>
										<option value="ci_content">내용</option>
									</select>
									<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요" />
									<input type="button" value="검색" id="searchData" />
								</td>
							</tr>
						</table>
				</form>
			</div>

			<!-- 고양이 관리 정보 게시판 리스트 -->
			<div id="catcareList">
				<table summary="고양이 관리 정보 게시판 리스트">
					<colgroup>
						<col width="10%" />
						<col width="56%" />
						<col width="15%">
						<col width="15%" />
					</colgroup>
					<thead id="top">
						<tr>
							<th data-value="ci_number" class="order">번호
							<c:choose>
								<c:when test="${data.order_by=='ci_number'
								and data.order_sc=='ASC'}">▲</c:when>
								<c:when test="${data.order_by=='ci_number'
								and data.order_sc=='DESC'}">▼ </c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose>
							</th>
							<th>제목</th>
							<th>작성자</th>
							<th data-value="ci_date" class="order">등록일
								<c:choose>
									<c:when test="${data.order_by=='ci_date'
									and data.order_sc=='ASC'}">▲</c:when>
									<c:when test="${data.order_by=='ci_date'
									and data.order_sc=='DESC'}">▼</c:when>
									<c:otherwise>▲</c:otherwise>
								</c:choose>
							</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty catcareList}">
								<c:forEach var="catcare" items="${catcareList}"
									varStatus="status">
									<tr data-num="${catcare.ci_number}">
										<td>${count - status.index}</td>
										<td class="goDetail tal" id="qwe">${catcare.ci_title}</td>
										<td class="name">${catcare.ci_writer}</td>
										<td>${catcare.ci_date}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<br>
			<div id="catcarePage">
				<tag:paging page="${param.page}" total="${total}" list_size="${data.pageSize}" />
			</div>
		</div>
	</div>
</body>
</html>

















