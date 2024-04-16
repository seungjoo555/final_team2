<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- signup.css -->
<link rel="stylesheet" href="<c:url value="/resources/css/signupcss.css"/>">

<style>
	/* verify-sub */
	.verify-sub{margin: 50px 0 100px 0;}
	
	/*verify-input*/
	.verify-input::after{content:''; display: block; clear:both;}
	.verify-input .input-bg{width: calc(550px - 95px); float:left;}
	
	/*verify-submit 버튼 style*/
	.verify-submit-btn{float:right; width: 80px; height: 50px; background-color: #E6F5E5; margin: 0;}
	
	/* verify-retry */
	.verify-retry{margin-top: 20px;}
	
</style>

</head>


<body class="center">

<div class="container">
	<h1>이메일 인증</h1>
	<h5 class="verify-sub">가입하신 이메일로 인증코드가 전달되었습니다. <br>제한시간 이내에 전송된 인증코드를 입력하세요.</h5>
	
	<form action="<c:url value="/signup/verify"/>" method="post" class="signup-form">
		<div class="email-input">
			<label for="email">가입한 이메일</label>
			<div class="input-bg">
				<input type="text" name="email" id="email" placeholder="이메일" readonly>
			</div>
		</div>
		<div class="verify-input">
			<div class="input-bg">
				<input type="text" name="verify" id="verify" placeholder="인증코드 입력">
				<div class="verify-check">유효시간</div>
			</div>
			<button class="verify-submit-btn">인증</button>
		</div>
		<div class="verify-retry">
			<div>인증코드가 오지 않았나요? 인증코드 <a href="#">다시 받기</a></div>
			<div class="verify-error">*올바른 인증코드를 입력하세요.</div>
		</div>
	</form>

</div>


</body>
</html>