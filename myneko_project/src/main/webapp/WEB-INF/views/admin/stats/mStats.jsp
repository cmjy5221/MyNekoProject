<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.left {
		float: left;
		width: 15%;
	}
	#myChart {
		width: 100px;
		height: 100px;
	}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/Chart.min.js"></script>
<script src="/resources/include/js/Chart.bundle.js"></script>
<script src="/resources/include/js/Chart.bundle.min.js"></script>
<script src="/resources/include/js/Chart.js"></script>
<script src="/resources/include/js/utils.js"></script>
<script>
	$(document).ready(function() {
		$("#excel").click(function() {
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/memberExcel"
			});
			$("#searchForm").submit();
		});
		var d = new Date();
		var s = leadingZeros(d.getFullYear(), 4) + '-'
		+ leadingZeros(d.getMonth() + 1, 2) + '-'
		+ leadingZeros(d.getDate(), 2);
		if ('${data.firstDate}' != '') {
			$("#firstDate").attr({
				"min" : "2019-01-01",
				"max" : "2100-12-31",
				"value" : "${data.firstDate}"
			})

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : "${data.lastDate}"
			})

		} else {
			$("#firstDate").attr({
				"min" : "2019-01-01",
				"max" : "2100-12-31",
				"value" : "2019-01-01"
			})

			$("#lastDate").attr({
				"min" : $("#firstDate").val(),
				"max" : "2100-12-31",
				"value" : s
			})
		}
		$("#searchBtn").click(function() {
			if ($("#firstDate").val() > $("#lastDate").val()) {
				alert("조회 시작날짜는 종료날짜를 초과할 수 없습니다.");
				return false;
			} else {
				alert($("#firstDate").val());
				$("#searchForm").attr({
					"method" : "get",
					"action" : "/admin/memberStatus"
				});
				$("#searchForm").submit();
			}
		});
		$("#totalSearch").click(function() {
			$("#firstDate").val("");
			$("#lastDate").val("");
			$("#searchForm").attr({
				"method" : "get",
				"action" : "/admin/memberStatus"
			});
			$("#searchForm").submit();
		});
		var ctx = document.getElementById("myChart");
		var myChart = new Chart(ctx, {
			type : "bar",
			data : {
				labels : ["가입자 수", "탈퇴회원 수"],
				datasets : [{
					label : "",
					data : ["<c:out value='${joinCount}' />", "<c:out value='${leaveCount}' />"],
					backgroundColor : [
						"MediumTurquoise",
						"MediumVioletRed"
					],
					borderColor : [
						"Blue",
						"Red"
					],
					borderWidth : 1
				}]
			},
			options : {
				scales : {
					yAxes : [{
						ticks : {
							beginAtZero : true
						}
					}]
				}
			}
		});
	});
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}
</script>
</head>
<body>
	<div class="table-responsive">
	<h3>회원통계</h3>
		<form id="searchForm" name="searchForm">
			<input type="date" id="firstDate" name="firstDate" class="form-control left" />
			<input type="date" id="lastDate" name="lastDate" class="form-control left" />
		</form>
		<input type="button" id="searchBtn" class="btn btn-default" value="검색" />
		<input type="button" id="totalSearch" class="btn btn-default" value="전체" />
		<input type="button" id="excel" class="btn btn-info" value="엑셀저장" />
		<table class="table table-striped">
			<tr>
				<th class="tac">날짜</th>
				<th class="tac">가입회원 수</th>
				<th class="tac">탈퇴회원 수</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty stats }">
					<c:forEach items="${ stats }" var="stats" varStatus="status">
						<tr>
							<td class='tac'>
								${ stats.register }
							</td>
							<td class="tac">
								${ stats.joinCount }
							</td>
							<td class="tac">
								${ stats.leaveCount }
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="tac" colspan="3">
							조회된 데이터가 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<canvas id="myChart"></canvas>
	</div>
</body>
</html>