<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<title></title>
</head>
<body>
   <%
      session.invalidate();
   %>
   <script type="text/javascript">
   $(function() {
      alert("정상적으로 로그아웃되었습니다.");
      window.location.href="/mdlist/allmdlist";
   });
   </script>
</body>
</html>