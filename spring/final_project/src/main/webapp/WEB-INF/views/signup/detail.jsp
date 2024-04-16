<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>

</head>

<!-- signup.css -->
<link rel="stylesheet" href="<c:url value="/resources/css/signupcss.css"/>">

<body class="center">
<div class="container">
	<h1>상세 정보</h1>
	
	<form action="<c:url value="/signup/detail"/>" method="post" class="signup-form">
		<button class="submit">가입하기</button>
	</form>

</div>


</body>
</html>