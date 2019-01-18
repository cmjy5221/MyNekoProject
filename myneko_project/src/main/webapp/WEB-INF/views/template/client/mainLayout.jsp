<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<link rel="stylesheet" href="/resources/include/css/header.css" />
<style>
	#footer {
		margin: 0px auto;
	}
</style>
<!-- <link rel="stylesheet" href="/resources/include/css/bootstrap.css" /> -->
<!-- <link rel="stylesheet" href="/resources/include/css/bootstrap.min.css" /> -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/include/js/bootstrap.js"></script>
<script src="/resources/include/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="wrapper"></div>
	<header id="header">
		<tiles:insertAttribute name="header" />
	</header>
	<div id="content" class="container container-fluid">
		<tiles:insertAttribute name="body" />
	</div>
	<footer id="footer">
		<tiles:insertAttribute name="footer" />
	</footer>
</body>
</html>