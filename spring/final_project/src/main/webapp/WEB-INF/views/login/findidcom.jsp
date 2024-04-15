<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.findidcom-container{
		padding : 100px;
		margin : 0 auto;
	}
	.findidcom-container .h-wrap{
		text-align: center; 
	}
	.findidcom-form-group{
		width: 50%;
		margin : 0 auto;
		padding : 15px;
	}
	
	.findidcom-form-group input{
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
		margin-bottom : 70px;
	}
	
	.btn-login{
		width: calc(50% - 30px);
		display : block;
		margin : 0 auto;
		height: 61px;
	}
	
	
	.login-links{
		text-align : center;
	}
	
	
	.login-easy{
		text-align : center;
	}
	
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="findidcom-container">
		<div class="h-wrap">
			<h1>아이디 찾기</h1>
			<h5>입력하신 정보와 일치하는 회원 정보입니다.</h5>
		</div>
			<div class="findidcom-form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control finded-id" id="id" name="id" value="">
			</div>
			<button class="btn-login btn-success" type="button">로그인</button>
			<div class="login-links">
			    <p style="margin-top: 50px;">
			        <a href="<c:url value="/login"/>">로그인</a> | <a href="<c:url value="/login/findpw"/>">비밀번호 찾기</a>
			    </p>
		    </div>
		    <div class="login-easy">
			    <p style ="margin-top: 50px;">
			   		──────────&nbsp&nbsp&nbsp&nbsp&nbsp간편로그인&nbsp&nbsp&nbsp&nbsp&nbsp──────────  
			    </p>
		    </div>
		   	<!-- 이 아래에 이미지 -->
		</form>
	</div>
	
<script type="text/javascript">
	$(".btn-login").click(function(){
		location.replace("http://localhost:8080/team2/login");
	})
</script>
</body>
</html>