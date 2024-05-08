<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.form-wrap{
		height : 800px;
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	    transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.form-wrap:hover {
	  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	
	.h-wrap{
		padding-top: 100px;
		text-align: center;
	}
	
	.h-wrap h2{
		
		font-weight: bold;
	}
	
	.form-wrap hr{
		width : 50%;
		margin : 0 auto;
		margin-top : 50px;
	}
	
	.p-wrap{
		margin-top : 50px;
		text-align: center;
	}
	
	.input-wrap {
		margin-top : 50px;
	}
	
	.input-wrap .input-group {
		display: inline-block;
		margin-left : 300px;
	}
	
	
	.form-wrap input{
		width : 550px;
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
		margin-bottom : 30px;
	}
	
	.input-wrap button{
		height: 50px;
		width : 80px;
		color : black;
		background-color: #E6F5E5;
		border-radius : 5px;
	}
	
	.extra-wrap{
		display : flex;
		margin-left : 300px;
	}
	
	.resend-btn{
		font-weight : bold;
		margin-left : 5px;
	}
	
	.resend-btn:hover{
		cursor: pointer;
	}
	
	
	
	
</style>
</head>
<body>
<div class="authentication-container">
	<div class="form-wrap">
		<form action="<c:url value="/login/authentication"/>" method="post" class="authentication-form">
			<div class="h-wrap">
				<h2>이메일 인증</h2>
			</div>
			<hr>
			<div class="p-wrap">
				<p>가입하신 이메일로 인증코드가 전달하였습니다.</p>
				<p>3분 이내에 이메일에 있는 인증 번호를 입력해 주세요.</p>
			</div>
			<div class="input-wrap">
				<div class="input-group">
					<label for="me_id">가입한 이메일</label>
					<br>
					<input type="text" value="${dbMember.me_id}"readonly>
				</div>
				<div class="input-group">
					<input type="text">
					<button>인증</button>
				</div>
			</div>
			<div class="extra-wrap">
				<p>인증 코드가 오지 않았나요?</p>
				<p class="resend-btn">인증코드 다시 받기</p>
			</div>
		</form>
	</div>
</div>
</body>
</html>