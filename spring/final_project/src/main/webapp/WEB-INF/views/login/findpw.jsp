<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.findpw-container{
		padding : 100px;
		margin : 0 auto;
	}
	.findpw-container .h-wrap{
		text-align: center; 
	}
	.findpw-form-group{
		width: 50%;
		margin : 0 auto;
		padding : 15px;
	}
	
	.findpw-form-group input{
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
	}
	
	.findpw-btn{
		width: calc(50% - 30px);
		display : block;
		margin : 0 auto;
		height: 61px;
	}
	
	
	.login-links{
		text-align : center;
	}
	
	.findpw-warnning{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : left;
	}
	
	.login-easy{
		text-align : center;
	}
	
	.findpw-warnning .warn-msg{
		margin-top : 70px;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="findpw-container">
		<form action="<c:url value="/findpw"/>" method="post" class="findpw-form">
		<div class="h-wrap">
			<h1>비밀번호 찾기</h1>
			<h5>가입한 아이디와 전화번호를 입력하면 비밀번호를 찾을 수 있습니다. </h5>
		</div>
			<div class="findpw-form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control find-id" id="id" name="id">
			</div>
			<div class="findpw-form-group">
				<label for="phone">전화번호</label>
				<input type="text" class="form-control find-phone" id="phone" name="phone">
			</div>
			<div class="findpw-warnning">
		      	<p class="warn-msg">&nbsp</p>
		    </div>
			<button class="findpw-btn btn-success" type="button">비밀번호찾기</button>
			<div class="login-links">
			    <p style="margin-top: 50px;">
			        <a href="#">로그인</a> | <a href="#">아이디 찾기</a>
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
	//아이디찾기 필수항목 체크
	$(".findpw-btn").click(function(){
		let id = $(".find-id").val();
		let phone = $(".find-phone").val();
		let str = "";
		
		if(id==null||id.length ==0){
			str = `<p class="warn-msg" style="color : red;">*아이디를 입력해주세요.</p>`
			$(".findpw-warnning").html(str);
			return false;
		}
		if(phone==null||phone.length==0){
			str = `<p class="warn-msg" style="color : red;">*전화번호를 입력해주세요.</p>`
			$(".findpw-warnning").html(str);
			return false;
		}
		
		$(".findpw-form").submit();
	})
	
	
</script>
</body>
</html>