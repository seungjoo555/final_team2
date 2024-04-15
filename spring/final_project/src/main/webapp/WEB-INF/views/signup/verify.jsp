<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.center .container{display: flex; flex-direction: column; justify-content: center; align-items: center;
		margin: 100px auto 200px auto;}
	.sub{margin-top: 20px}
	.sub::before, .sub::after{width: 90px; height: 1px; background-color: black; margin: 5px 20px; display:inline-block; content: '';}
	
	[class$=btn]{border-radius: 5px; border: none;}
	
	/*btn-group 설정*/
		[class$=btn-group]{display:flex; justify-content: space-around;}
		[class$=btn-group] a{width: 50px; height: 50px; text-align: center; text-height: 50px; border-radius: 100%; border: 1px solid black;}
		[class$=btn-group] a::hover{text-decoration: none;}
	/*input 박스 관련 style*/
		[class$=input] label{display:block; font-weight: 800;}
		
		/*input box*/
		[class$=input] .input-bg{width: 550px; height: 50px; border-radius: 5px; background-color: #EBEBEB;
			display: flex; align-items: center;}
		[class$=input] input{float:left; width: calc(100% - 110px); height: 20px; border: none; margin: 0 0 0 20px; background-color: #EBEBEB;}
		
		/*placeholder style 관련 설정*/
		[class$=input] input::placeholder{font-size: 16px;}
		
		/*중복확인 버튼*/
		[class$=input] [class$=check]{float:right; color: black; width: 70px; margin-right: 20px; text-decoration: none;}
		[class$=input] [class$=check]::hover{text-decoration: none;}
		
		/*입력항목 정렬 관련 설정*/
		[class$=input]~[class$=input]{margin-top: 15px;}
		
		/*유효성 검사 오류 항목 관련*/
		[class$=error]{color: red; visibility: hidden;}

	/* ================================ verify.jsp에서만 쓰는 style 설정 ================================ */	
	
	
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