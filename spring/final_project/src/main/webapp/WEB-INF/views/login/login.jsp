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
		width : 800px;
		padding-top : 100px;
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
		margin-bottom : 25px;
	}
	
	.login-btn:hover{
		background-color: #1dc078;
		color : white;
	}
	
	.login-auto-container{
		width: calc(50% - 30px);
		margin : 0 auto;
		text-align : right;
		margin-bottom: 50px;
		
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
	
	.sns-wrap{
		text-align : center;
	}
	
	    .modal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 500px;
        height: 500px;
        background-color: white;
        border-radius: 10px;
        overflow: auto;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* 모달 내용 스타일 */
    .modal-content {
    	height : 450px;
        position: relative;
        padding: 20px;
        border-radius: 10px;
    }
    
    #nickname{
    	width : 320px;
    	height : 50px;
    	border-radius : 5px;
    }
    
    #address1 {
    	margin-bottom : 10px;
    	width : 150px;
    	height : 50px;
    }
    
    #address2{
    	width : 400px;
    	height : 50px;
    }
    

    /* 모달 닫기 버튼 스타일 */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    /* 모달 닫기 버튼 호버 스타일 */
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    /* 배경을 어둡게 만드는 스타일 */
    .modal-backdrop {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* 어두운 배경색 */
        z-index: 9998; /* 모달보다 한 층 낮은 z-index */
    }
	
	.check-duplicate{
		width : 80px;
		height : 50px; 
		background-color: #DAFBD8;
		
	}
	
	.modal-content h2{
		font-size : 16px;
		font-weight : bold;
	}
	.modal-content input{
		padding : 10px;
		background-color : #EBEBEB;
		margin-right : 10px;
		border-radius : 5px;
	}
	
	.input-wrap{
		margin-top : 20px;
	}
	
	#btn-extraInfo{
		margin-top : 30px;
		height : 50px;
		background-color: #DAFBD8;
		border-radius : 5px;
	}
	

	

</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="login-container">
		<form action="<c:url value="/login"/>" method="post" class="login-form">
		<div class="h-wrap">
			<h2>로그인</h2>
			<p>로그인 정보를 입력하세요.</p>
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
				<input type = "checkbox" name="autoLogin" class="login-auto" value="true">
				<label for="auto-login">자동로그인</label>
			</div>
			<div class="login-warnning">
		      	<p class="warn-msg"> </p>
		    </div>
			<button class="login-btn" type="submit">로그인</button>
			<div class="login-links">
				<a href="<c:url value='/signup'/>">회원가입</a>
			    <p style="margin-top: 25px;">
			        <a href="<c:url value="/login/findid"/>">아이디 찾기</a> | <a href="<c:url value="/login/findpw"/>">비밀번호 찾기</a>
			    </p>
		    </div>
		    <div class="login-easy">
			    <p style ="margin-top: 50px;">
			   		──────────&nbsp&nbsp&nbsp&nbsp&nbsp간편로그인&nbsp&nbsp&nbsp&nbsp&nbsp──────────  
			    </p>
		    </div>
		   	<!-- 이 아래에 이미지 -->
		   	<div class="sns-wrap">
			    <a id="kakao-login-btn" href="javascript:loginWithKakao()">
				  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="150"
				    alt="카카오 로그인 버튼" />
				</a>
			</div>
		</form>
	</div>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

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

	})
</script>

<!-- 카카오 로그인 -->
<script type="text/javascript">
	Kakao.init('e1f2ec82f149e61690c58a9a30348f59');
	
	function loginWithKakao() {
		Kakao.Auth.login({
	  success: function (authObj) {
	     Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
					
	     getInfo(); //동의한 회원정보 가져오기
	  },
	  fail: function (err) {
	      console.log(err);
	  	}
	});
}
	function getInfo() {
		  Kakao.API.request({
		    url: '/v2/user/me',
		    success: function (res) {
		      // 아이디, 이메일
		      //그 외 동의 정보는 res.kakao_account.속성명을 통해 가져올 수 있다
		      //console.log(res.kakao_account);//에서 필요한 정보를 확인
		      //아이디는 발급 받은 앱키마다 다르므로 중간에 앱키를 바꾸면 같은 카카오 계정이지만
		      //다른 아이디값이 나옴. 주의!
		      console.log(res.kakao_account);
		      var email = res.kakao_account.email;
		      var sns = "kakao"; //다른 sns 로그인을 위한 작업
		      var phone = res.kakao_account.phone_number;
		      var name = res.kakao_account.name;

		      console.log(email);
		      console.log(sns);
		      console.log(phone);
		      console.log(name);
		      
		      //카카오 로그인 
		      switch(checkMember(sns,email)){
			      case 1 : snsLogin(sns,email); break;
			      case 2:  
			    	  if(confirm('회원이 아닙니다. 가입하시겠습니까?')){
			    		  signupSns(sns,email,phone,name);
			    	  }
			    	  break;
			      case 3:  alert("다른 경로로 이미 가입된 이메일입니다."); location.href = '<c:url value="/login"/>'; break;
			      case -1 : alert("오류입니다. 다시 시도해주세요"); break;
		      }
		    },
		    fail: function (error) {
		        alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
		    }
		  });
		}
		
	//ajax로 가입한 아이디인지 확인
	function checkMember(sns, email){
	  var res;
	  $.ajax({
			async : false,
			url : `<c:url value="/sns"/>/\${sns}/check/id`, 
			type : 'post', 
			data : {email}, 
			success : function (data){
				res = data;
				console.log(res);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
	
			}
		});
	  return res;
	 }
	 //sns 계정 정보로 가입 진행
	 function signupSns(sns, email, phone, name){
	  alert("추가 정보 입력이 필요합니다.");
	  showModal(sns, email, phone, name);
	  
	 }
	 //sns 로그인 진행
	 function snsLogin(sns, email){
	  $.ajax({
			async : false,
			url : `<c:url value="/sns"/>/\${sns}/login`, 
			type : 'post', 
			data : {email}, 
			success : function (data){
				if(data){
					alert("로그인 되었습니다.");
					location.replace("<c:url value='/'/>")
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				
			}
		});
	 }
	 
	 //추가정보를 위한 모달창

	function showModal(sns, email, phone, name) {
		
		let checkFlag = false;
		
	    // 모달 창을 나타내는 HTML 코드를 생성
	    var modalHtml = `
	        <div id="myModal" class="modal">
	            <div class="modal-content">
	                <span class="close">&times;</span>
			    	<h2>SNS 가입을 위한 추가 정보</h2>
	                <!-- 모달 내용 -->
	                <div class="input-wrap">
	                	<label for="nickname">닉네임(중복확인 필수)</label>
		                <input type="text" id="nickname" placeholder="닉네임">
		                <button type="button" class="check-duplicate" >중복확인</button>
		                <span id="nickname-error"></span>
		            </div>
		            <div class ="input-wrap">
		                <label for="nickname">주소</label>
		                <br>
	                	<input type="text" id="address1" placeholder="주소">
	                	<input type="text" id="address2" placeholder ="상세주소">
	            	</div>
	             <button id="btn-extraInfo" class ="btn-extraInfo">입력완료</button>
	        </div>
	    `;
	    
	    // 스크롤 비허용
        $('body').css('overflow', 'hidden');
	    
	    // 모달 창을 현재 페이지에 추가
	    $('body').append(modalHtml);
	    
	    // 모달 닫기 버튼에 클릭 이벤트 추가
	    $('.close').click(function() {
	        closeModal();
	        checkFlag = false;
	    });
	    
	    $(document).on("change","#nickname",function(){
	    	checkFlag = false;
	    })
	    
	    $(document).on("click",".check-duplicate",function(){
	    	
	    	let nickname = $("#nickname").val();
			let nicknameRegex = /^[a-zA-Z0-9!@#가-힣]{1,8}$/
			
			if(!nickname){
				$("#nickname-error").text("닉네임을 입력하세요.")
				return;
			}
			
			if(!nicknameRegex.test(nickname)){
				$("#nickname-error").text("닉네임은 숫자,영문,한글로 이루어진 0~9 글자")
				return;
			}
			
			$.ajax({
				url : '<c:url value="/nickname/check"/>',
				method : 'get',
				async : true,
				data : {
					"nickname" : nickname
				},
				success : function(data){
					result = data.result
					
					if(!result){
						alert("이미 사용중인 닉네임입니다.");
						$("#nickname").css("color", "red")
					}else{
						alert("사용 가능한 닉네임입니다.");
						$("#nickname-error").text("")
						checkFlag = true;
					}
				},
				error : function (a, b, c) {
					console.error("예외 발생");
				}
			})
	    })
	    
	    
	    $(document).on("click",".btn-extraInfo",function(){
	    	if(!checkFlag){
	    		alert("닉네임 중복 검사를 완료해야합니다.")
	    		return false;
	    	}
	    	
	    	let address1 = $("#address1").val();
	    	let address2 = $("#address2").val();
	    	
	    	let address = address1 + address2;
	    	
	    	if(address1==null || address2==null || address1.length==0 || address2.length ==0){
	    		alert("주소를 입력해주세요.")
	    		return false;
	    	}
	    	
	    	if(address.length >50){
	    		alert("주소는 50글자를 넘을 수 없습니다.")
	    		return false;
	    	}
	    	
	    	let nickname = $('#nickname').val();
	    	
	    	$.ajax({
				async : false,
				url : `<c:url value="/sns"/>/\${sns}/signup`, 
				type : 'post', 
				data : {sns, email, phone, name, nickname, address}, 
				success : function (data){
					if(data){
						alert("회원가입이 완료되었습니다.")
					}else{
						alert('회원가입에 실패했습니다.')
					}
					
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					
				}
			});
	    	
 	
	    })
	    
	    // 모달 창을 표시
	    $('#myModal').css('display', 'block');
		}
	
	// 모달 창 닫기
	function closeModal() {
	    $('#myModal').css('display', 'none');
	}
	 
</script>


</body>
</html>