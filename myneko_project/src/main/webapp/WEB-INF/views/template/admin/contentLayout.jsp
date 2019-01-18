<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><tiles:getAsString name="title" /></title>
<link rel="icon" href="/resources/images/common/icon.png" />
<link href="/resources/include/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="/resources/include/css/bootstrap.css" />
<link href="/resources/include/css/dashboard.css" rel="stylesheet" />
<script src="/resources/include/js/ie-emulation-modes-warning.js"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/bootstrap.js"></script>
<script src="/resources/include/js/bootstrap.min.js"></script>
<script>
	var adminId = "<c:out value='${ adminId }' />";
	if (adminId == null || adminId == "") {
		location.href="/admin/adminLogin.do";
	}
	$(document).ready(function() {
		history.pushState(null, null, location.href);
		window.onpopstate = function() {
			history.go(1);
		}
		$("form").keydown(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		})
	});
	$(document).keydown(function(e) {
		key = (e) ? e.keyCode : event.keyCode;
		
		if ((key < 91 && key > 64) || key == 123) {
			return true;
		}
		
		if (key >= 48 && key <=57) {
			return true;
		}
		
		if (key >= 96 && key <= 109) {
			return true;
		}
		
		var t = document.activeElement.tagName;
		if (key == 8 || key == 116 || key || 17 || key == 82 || key == 32) {
			if (key == 8 || key == 32) {
				if (t != "INPUT" && t != "input" && t != "textarea" && t != "TEXTAREA") {
					if (e) {
						e.preventDefault();
					} else {
						event.keyCode = 0;
						event.returnValue = false;
					}
				}
			} else {
				if (e) {
					e.preventDefault();
				} else {
					event.keyCode = 0;
					event.returnValue = false;
				}
			}
		}
	});
</script>
<style>
	#wrapper {
		height: expression( this.scrollHeight > 834 ? "835px" : "auto" );
		max-height: 835px;
		overflow-y: auto;
	}
	
	font {
		font-weight: bold;
	}
	
	.dropdown:hover .dropdown-menu {
		display: inline;
	}
	
	#orderPage {
		text-align: center;
	}
	
	.on {
		font-size: 15pt;
	}
	
	a:link {
		text-decoration: none;
		color: black;
	}
	
	a:hover {
		text-decoration: none;
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
	
	select {
		width: 50%;
	}
</style>
</head>
<body>
	<div id="wrapper">
	<tiles:insertAttribute name="header" />
	<div class="container container-fluid">
		<tiles:insertAttribute name="main" />
	</div>
	<nav class="navbar navbar-inverse navbar-fixed-bottom">
		<tiles:insertAttribute name="footer" />
	</nav>
	</div>
</body>
</html>