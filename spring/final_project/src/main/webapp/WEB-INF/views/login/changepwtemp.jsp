<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.changePW-container{
		padding : 100px;
		margin : 0 auto;
	}
	.changePW-container .h-wrap{
		text-align: center; 
	}
	.changePW-form-group{
		width: 50%;
		margin : 0 auto;
		padding : 15px;
	}
	
	.changePW-form-group input{
		height: 50px;
		border-radius: 5px;
		background-color: #EBEBEB;
	}
	
	.changePW-btn{
		width: calc(50% - 30px);
		display : block;
		margin : 0 auto;
		height: 61px;
		background-color: #DAFBD8;
		border : none;
		border-radius : 5px;
	}
	
	.changePW-btn:hover{
		background-color: #1dc078;
		color : white;
	}
	
	
	.login-links{
		text-align : center;
	}
	
	.changePW-warnning{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : left;
	}
	
	.login-easy{
		text-align : center;
	}
	
	.changePW-warnning .warn-msg{
		margin-top : 70px;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="changePW-container">
		<form action="<c:url value="/login/changepwtemp"/>" method="post" class="changePW-form">
		<div class="h-wrap">
			<h2>비밀번호 변경</h2>
			<p>변경할 비밀번호를 입력하세요. </p>
		</div>
			<div class="changePW-form-group">
				<label for="pw">새 비밀번호</label>
				<input type="text" class="form-control newpw" id="pw" name="me_pw">
			</div>
			<div class="changePW-form-group">
				<label for="phone">새 비밀번호 확인</label>
				<input type="text" class="form-control newpw2" id="pw2" name="pw2">
			</div>
			<div class="changePW-warnning">
		      	<p class="warn-msg">&nbsp</p>
		    </div>
			<button class="changePW-btn" type="button">비밀번호변경</button>
			<input type="hidden" class="me_id" name="me_id" value="${user.me_id}">
		</form>
	</div>
<script type="text/javascript">
	//아이디찾기 필수항목 체크
	$(".changePW-btn").click(function(){
		let pw = $(".newpw").val();
		let pw2 = $(".newpw2").val();
		let str = "";
		console.log($('.me_id').val())
		if(pw==null||pw.length ==0){
			str = `<p class="warn-msg" style="color : red;">*비밀번호를 입력해주세요.</p>`
			$(".changePW-warnning").html(str);
			return false;
		}
		if(pw2==null||pw2.length==0){
			str = `<p class="warn-msg" style="color : red;">*비밀번호 확인을 입력해주세요.</p>`
			$(".changePW-warnning").html(str);
			return false;
		}
		if(pw != pw2){
			str = `<p class="warn-msg" style="color : red;">*비밀번호 확인과 비밀번호가 일치하지 않습니다.</p>`
			$(".changePW-warnning").html(str);
			return false;
		}
		
		$(".changePW-form").submit();
	})
	
	
</script>
</body>
</html>