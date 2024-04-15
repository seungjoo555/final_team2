<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.login-container{
		padding : 100px;
		margin : 0 auto;
	}
	.h-wrap{
		text-align: center; 
	}
	.login-form-group{
		width: 50%;
		margin : 0 auto;
		padding : 15px;
	}
	
	.login-form-group input{
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
	}
	
	.login-btn{
		width: calc(50% - 30px);
		display : block;
		margin : 0 auto;
		height: 61px;
		background-color: #DAFBD8;
		border : none;
		border-radius : 5px;
	}
	
	.login-btn:hover{
		background-color: #1dc078;
		color : white;
	}
	
	.login-auto-container{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : right;
		margin-bottom: 70px;
		
	}
	
	.login-links{
		text-align : center;
	}
	
	.login-warnning{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : left;
	}
	
	.login-easy{
		text-align : center;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="login-container">
		<form action="<c:url value="/login"/>" method="post" class="login-form">
		<div class="h-wrap">
			<h1>로그인</h1>
			<h5>로그인 정보를 입력하세요.</h5>
		</div>
			<div class="login-form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control login-id" id="id" name="id">
			</div>
			<div class="login-form-group">
				<label for="pw">비번</label>
				<input type="password" class="form-control login-pw" id="pw" name="pw">
			</div>
			<div class="login-auto-container">
				<input type = "checkbox" name="login-auto" class="login-auto">
				<label for="auto-login">자동로그인</label>
			</div>
			<div class="login-warnning">
		      	<p class="warn-msg"> </p>
		    </div>
			<button class="login-btn" type="button">로그인</button>
			<div class="login-links">
			    <p style="margin-top: 50px;">
			        <a href="<c:url value="/login/findid"/>">아이디 찾기</a> | <a href="<c:url value="/login/findpw"/>">비밀번호 찾기</a>
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
	//로그인 필수항목 체크
	$(".login-btn").click(function(){
		let id = $(".login-id").val();
		let pw = $(".login-pw").val();
		let str = "";
		
		if(id==null||id.length ==0){
			str = `<p style="color : red;">*아이디를 입력해주세요.</p>`
			$(".login-warnning").html(str);
			return false;
		}
		if(pw==null||pw.length==0){
			str = `<p style="color : red;">*비밀번호를 입력해주세요.</p>`
			$(".login-warnning").html(str);
			return false;
		}
		
		$(".login-form").submit();
	})
	
	
</script>
</body>
</html>