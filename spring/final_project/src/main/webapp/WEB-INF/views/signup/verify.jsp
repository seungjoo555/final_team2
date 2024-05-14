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
		margin-bottom : 20px;
	}
	
	.input-wrap button{
		height: 50px;
		width : 100px;
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
	.verify-auth{
		display : none;
	}
	
	.timer{
		text-align : center;
		margin-left : 395px;
		margin-bottom : 40px;
		font-weight: bold;
		color : red;
	}
	
	
	
</style>
</head>
<body>
<div class="authentication-container">
	<div class="form-wrap">
		<div class="h-wrap">
			<h2>이메일 인증</h2>
		</div>
		<hr>
		<div class="p-wrap">
			<p>인증번호받기 버튼을 누르신 후</p>
			<p>3분 이내에 가입하신 이메일에 전송된 인증 번호를 입력해 주세요.</p>
			<p>이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.</p>
		</div>
		<div class="input-wrap">
			<div class="input-group">
				<label for="mem-id">가입한 이메일</label>
				<br>
				<input type="text" class="mem-id" value="${user.me_id}"readonly>
			</div>
			<div class="input-group">
				<input type="text" class="auth-key" disabled >
				<button class="send-auth">인증번호받기</button>
				<button class="verify-auth">인증</button>
			</div>
			<div class="timer"></div>
		</div>
		<div class="extra-wrap">
			<p>인증 코드가 오지 않았나요?</p>
			<p class="resend-btn">인증코드 다시 받기</p>
		</div>
	</div>
</div>
<script type="text/javascript">
var timer;
let flag = false;
	<!--인증메일 전송이벤트 -->
	
	$('.send-auth').click(function(){
		sendAuth();
	})
	<!--다시받기 이벤트-->
	$('.resend-btn').click(function(){
		if(!flag){
			alert("인증번호 받기 버튼을 먼저 클릭해주세요.");
			return false;
		}
		resendAuth();
		
	});
	
	function resendAuth(){
		// 타이머 초기화
	    clearInterval(timer);
	    $('.timer').text('');

	    // 새로운 타이머 시작
	    sendAuth();
	}
	
	function ableInput(){
		$('.send-auth').hide();
		$('.verify-auth').css("display","inline-block");
		$('.auth-key').attr("disabled",false);
		$('.auth-key').css("background-color","white");
		$('.auth-key').css("border","1px solid black");
		flag = true;
	}
	
	function disableInput(){
		$('.send-auth').show();
		$('.verify-auth').hide();
		$('.auth-key').attr("disabled",true);
		$('.auth-key').css("background-color","#EBEBEB");
		$('.auth-key').css("border","");
		flag = false;
	}
	
	function makeTimer(){
		var duration = 180;
            timer = setInterval(function(){
                var minutes = parseInt(duration / 60, 10);
                var seconds = parseInt(duration % 60, 10);

                
                $('.timer').text("유효시간 : "+ minutes + ":" + (seconds < 10 ? "0" + seconds : seconds));
                if (--duration < 0) {
                    clearInterval(timer);
                    $('.timer').text('유효시간이 만료되었습니다. 다시받기 버튼을 클릭해주세요.')
                    //타이머종료시 입력불가
                    $('.auth-key').attr("disabled",true);

                }
            }, 1000); // 1초마다 갱신
	}
			
	
	function sendAuth(){
		let me_id = $('.mem-id').val();
		
		$.ajax({
			async : true,
			url :"<c:url value='/signup/sendAuth'/>",
			type : 'get',
			data : {me_id: me_id},
			success : function(data){
				console.log("data :: " + data);
				switch(data){
				case "true" : 
					    alert("인증번호가 발송되었습니다.");
					    ableInput();
					    makeTimer();
					    break;
				case "false" : 
						alert('메일 발송에 실패하였습니다. 다시 시도해주세요.');
						disableInput();
					    break;
				case "-1" : 
						alert("로그인 후 진행해주세요.");
						disableInput();
						location.replace("<c:url value='/login'/>"); break;
				case "-2" : 
						alert("권한 외 접근입니다."); 
						disableInput();
						location.replace("<c:url value='/'/>");
						break;
				case "-3" : 
						alert("이미 이메일 인증을 완료한 계정입니다."); 
						disableInput();
						location.replace("<c:url value='/'/>");
						break;
				}
				
			},error : function(jqXHR, textStatus, errorThrown){
				
			}
		})
		
		console.log("fl :: "+flag);
		
	}
	
	<!-- 인증 버튼 클릭 이벤트-->
	$('.verify-auth').click(function(){
		let mv_code = $('.auth-key').val();
		let mv_me_id = $('.mem-id').val();
		$.ajax({
			async : true,
			type : 'post',
			url : "<c:url value='/signup/checkverify'/>",
			contentType : "application/json; charset=utf-8",
			dataType :"json",
			data : JSON.stringify({mv_me_id : mv_me_id,
					mv_code : mv_code}),
			success : function(data){
				console.log(data);
				if(data.res=="true"){
					alert("이메일 인증이 완료되었습니다.");
					location.replace("<c:url value='/'/>")
				}else if(data.res=="false"){
					alert("인증번호를 다시 확인해주세요.");
				}
			},error : function(){
				
			}
		})
		
	})
	

</script>

</body>
</html>