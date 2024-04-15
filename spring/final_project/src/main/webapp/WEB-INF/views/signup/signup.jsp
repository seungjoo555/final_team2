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
	
	/* btn style */
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
		[class$=error]{visibility: hidden; color: red;}
			
		/*submit 버튼 style*/
		[class$=form] .submit{width: 550px; height: 60px; text-height: 60px; text-align: center; border: none; border-radius: 5px;
			background-color: #E6F5E5; font-weight: bold; margin: 70px 0 50px 0;}

	/* ================================ signup.jsp에서만 쓰는 style 설정 ================================ */	
	
	.signup-form{margin-top: 50px;}
	
	/*상세주소 margin-top 설정*/
	[class$=input] .add2{margin-top: 10px;}
		
			
	/*simple-login-btn-group margin-top*/
		.simple-login-btn-group{margin-top: 50px;}
</style>

</head>
<body class="center">

<div class="container">
	<h1>회원가입</h1>
	<h5 class="sub">어쩌고저쩌고</h5>
	
	<form action="<c:url value="/signup"/>" method="post" class="signup-form">
		<div class="id-input">
			<label for="id">아이디</label>
			<div class="input-bg">
				<input type="text" name="id" id="id" placeholder="이메일 형식으로 입력하세요.">
				<a class="id-dup-check" href="#">중복확인</a>
			</div>
			<div class="id-error">아이디 오류</div>
		</div>
		<div class="nickname-input">
			<label for="nickname">닉네임</label>
			<div class="input-bg">
				<input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력하세요.">
				<a class="nickname-dup-check" href="#">중복확인</a>
			</div>
			<div class="nickname-error">닉네임 오류</div>
		</div>
		<div class="pw-input">
			<label for="pw">비밀번호</label>
			<div class="input-bg">
				<input type="text" name="pw" id="pw" placeholder="비밀번호를 입력하세요.">
			</div>
			<div class="pw-error">비밀번호 오류</div>
		</div>
		<div class="pw2-input">
			<label for="pw2">비밀번호 확인</label>
			<div class="input-bg">
				<input type="text" name="pw2" id="pw2" placeholder="비밀번호를 입력하세요.">
			</div>
			<div class="pw2-error">비밀번호 확인 오류</div>
		</div>
		<div class="name-input">
			<label for="name">이름</label>
			<div class="input-bg">
				<input type="text" name="name" id="name" placeholder="이름을 입력하세요.">
			</div>
			<div class="name-error">이름 오류</div>
		</div>
		<div class="phone-input">
			<label for="phone">전화번호</label>
			<div class="input-bg">
				<input type="text" name="phone" id="phone" placeholder="전화번호를 입력하세요.">
			</div>
			<div class="phone-error">전화번호 확인 오류</div>
		</div>
		<div class="add-input">
			<label for="address">주소</label>
			<div class="input-bg add1">
				<input type="text" name="add1" id="add1" placeholder="주소를 입력하세요.">
			</div>
			<div class="input-bg add2">
				<input type="text" name="add2" id="add2" placeholder="상세주소를 입력하세요.">
			</div>
			<div class="phone-error">주소 확인 오류</div>
		</div>
		<button class="submit">가입하기</button>
	</form>
	<div class="simple-login">
		<h5 class="sub">간편 회원가입</h5>
		<div class="simple-login-btn-group">
			<a href="#">1</a>
			<a href="#">2</a>
		</div>
	</div>
</div>


</body>
</html>