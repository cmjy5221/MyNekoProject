<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#year {
	width: 25%;
}

.select {
	float: left;
}
</style>
<script src="/resources/include/js/Chart.min.js"></script>
<script src="/resources/include/js/Chart.bundle.js"></script>
<script src="/resources/include/js/Chart.bundle.min.js"></script>
<script src="/resources/include/js/Chart.js"></script>
<script src="/resources/include/js/utils.js"></script>
<script>
	$(document).ready(
			function() {
				$("#excelBtn").click(function() {
					$("#searchForm").attr({
						"method" : "get",
						"action" : "/admin/order/salesExcel"
					});
					$("#searchForm").submit();
				});

				$("#searchBtn").click(function() {
					$("#searchForm").attr({
						"method" : "get",
						"action" : "/admin/order/salesStats.do"
					});
					$("#searchForm").submit();
				});
				var maxYear = "<c:out value='${ maxYear }' />";
				var minYear = "<c:out value='${ minYear }' />";
				var jan = "<c:out value='${jan}' />";
				var feb = "<c:out value='${feb}' />";
				var mar = "<c:out value='${mar}' />";
				var apr = "<c:out value='${apr}' />";
				var may = "<c:out value='${may}' />";
				var jun = "<c:out value='${jun}' />";
				var jul = "<c:out value='${jul}' />";
				var aug = "<c:out value='${aug}' />";
				var sep = "<c:out value='${sep}' />";
				var oct = "<c:out value='${oct}' />";
				var nov = "<c:out value='${nov}' />";
				var dec = "<c:out value='${dec}' />";

				if (minYear == maxYear) {
					var option = "<option value='" + maxYear + "'>" + maxYear
							+ "</option>";
					$("#year").append(option);
				} else {
					for (var count = minYear; count <= maxYear; count++) {
						var option = "<option value='" + count + "'>" + count
								+ "</option>";
						$("#year").append(option);
					}
				}
				var ctx = document.getElementById("myChart");
				var myChart = new Chart(ctx, {
					type : "bar",
					data : {
						labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
								"8월", "9월", "10월", "11월", "12월" ],
						datasets : [ {
							label : "",
							data : [ jan, feb, mar, apr, may, jun, jul, aug,
									sep, oct, nov, dec ],
							backgroundColor : [ "#00FFFF", "#5AD2FF",
									"#64AAFF", "#9BC3FF", "#5ABEF5", "#D2D2FF",
									"#D5C2EE", "#A0A0FF", "#B4B4DC", "#A2978D",
									"#6482B9", "#9BC3FF" ],
							borderColor : [ "Blue", "red", "green", "yellow",
									"orange", "Blue", "red", "green", "yellow",
									"orange", "blue", "red" ],
							borderWidth : 1
						} ]
					},
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
				var ctx2 = document.getElementById("myChart");
				var myChart2 = new Chart(ctx2, {
					type : "bar",
					data : {
						labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
								"8월", "9월", "10월", "11월", "12월" ],
						datasets : [ {
							label : "",
							data : [],
							backgroundColor : [ "MediumVioletRed" ],
							borderColor : [ "Red" ],
							borderWidth : 1
						} ]
					},
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
			});
</script>
</head>
<body>
	<div class="table-responsive">
		<h3>매출통계</h3>
		<form id="searchForm">
			<select id="year" name="year" class="form-control select">
			</select> <input type="hidden" id="o_state" name="o_state" value="구매확정" /> <input
				type="button" id="searchBtn" value="검색" class="btn btn-default" />
			<input type="button" id="excelBtn" value="엑셀저장" class="btn btn-info" />
		</form>
		<br />
		<table class="table table-striped">
			<tr>
				<th class="tac">월별구분</th>
				<th class="tac">매출액</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty monthlyStats }">
					<c:forEach items="${ monthlyStats }" var="month" varStatus="status">
						<tr>
							<td class="tac">${ month.month }</td>
							<td class="tac">${ month.sales }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="tac" colspan="2" align="center">통계 데이터가 존재하지 않습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<c:choose>
			<c:when test="${ not empty yearSales }">
				<div>
					<canvas id="myChart"></canvas>
				</div>
			</c:when>
		</c:choose>
	</div>
</body>
</html>