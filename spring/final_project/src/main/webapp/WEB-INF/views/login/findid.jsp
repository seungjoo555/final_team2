<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.findid-container{
		padding : 100px;
		margin : 0 auto;
	}
	.findid-container .h-wrap{
		text-align: center; 
	}
	.findid-form-group{
		width: 50%;
		margin : 0 auto;
		padding : 15px;
	}
	
	.findid-form-group input{
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
	}
	
	.findid-btn{
		width: calc(50% - 30px);
		display : block;
		margin : 0 auto;
		height: 61px;
		background-color: #DAFBD8;
		border : none;
		border-radius : 5px;
	}
	
	.findid-btn:hover{
		background-color: #1dc078;
		color : white;
	}
	
	
	.login-links{
		text-align : center;
	}
	
	.findid-warnning{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : left;
	}
	
	.login-easy{
		text-align : center;
	}
	
	.findid-warnning .warn-msg{
		margin-top : 70px;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="findid-container">
		<form action="<c:url value="/login/findid"/>" method="post" class="findid-form">
		<div class="h-wrap">
			<h2>아이디 찾기</h2>
			<p>가입한 이름과 전화번호 작성하면 회원님의 아이디를 찾을 수 있습니다.</p>
		</div>
			<div class="findid-form-group">
				<label for="name">이름</label>
				<input type="text" class="form-control find-name" id="name" name="me_name">
			</div>
			<div class="findid-form-group">
				<label for="phone">전화번호</label>
				<input type="text" class="form-control find-phone" id="phone" name="me_phone">
			</div>
			<div class="findid-warnning">
		      	<p class="warn-msg">&nbsp</p>
		    </div>
			<button class="findid-btn" type="button">아이디찾기</button>
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
	//아이디찾기 필수항목 체크
	$(".findid-btn").click(function(){
		let name = $(".find-name").val();
		let phone = $(".find-phone").val();
		let str = "";
		
		if(name==null||name.length ==0){
			str = `<p class="warn-msg" style="color : red;">*이름을 입력해주세요.</p>`
			$(".findid-warnning").html(str);
			return false;
		}
		if(phone==null||phone.length==0){
			str = `<p class="warn-msg" style="color : red;">*전화번호를 입력해주세요.</p>`
			$(".findid-warnning").html(str);
			return false;
		}
		
		$(".findid-form").submit();
	})
	
	
</script>
</body>
</html>