<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/lectureregister.css"/>">
<title>Insert title here</title>
</head>
<body>
	<h1>강의를 구매해 주셔서 감사합니다.</h1>
	<h2>구매한 강의는 내가 구매한 강의에서 볼 수 있습니다.</h2>
	<p>결제한 강의는 환불 불가. 고객센터는 없습니다.</p>
	<div class="1-container">
		<h3>주문자 정보</h3>
		<div class="container1">
			<div>아이디: ${user.me_id}</div>
			<div>전화번호: ${user.me_phone}</div>
		</div>
	</div>
	<div class="2-container">
		<h3>결제한 강의 정보</h3>
		<div class="container2">
			<div>강의 제목: ${lecture.lect_name}</div>
			<div>멘토 아이디:${lecture.lect_mentIf_me_id}</div>
		</div>
		<div>
			<div>결제 금액:${lecture.lect_price}</div>
		</div>
	</div>
</body>
</html>