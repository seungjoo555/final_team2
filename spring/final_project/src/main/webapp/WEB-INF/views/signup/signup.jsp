<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value="/resources/css/signup.css"/>">
<!-- jquery validtaion -->	
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<body class="center">
<div class="container">
	<h1>회원가입</h1>
	<h5 class="sub">본인 정보를 입력해주세요.</h5>
	
	<form action="<c:url value="/signup"/>" method="post" class="signup-form" id="signup-form">
		<div class="id-input">
			<label for="id">아이디</label>
			<div class="input-bg">
				<input type="text" name="id" id="id" placeholder="이메일 형식으로 입력하세요.">
				<a class="id-dup-check">중복확인</a>
			</div>
			<label id="id-error" class="error" for="id"></label>
		</div>
		<div class="nickname-input">
			<label for="nickname">닉네임</label>
			<div class="input-bg">
				<input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력하세요.">
				<a class="nickname-dup-check">중복확인</a>
			</div>
			<label id="nickname-error" class="error" for="nickname"></label>
		</div>
		<div class="pw-input">
			<label for="pw">비밀번호</label>
			<div class="input-bg">
				<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요.">
			</div>
			<label id="pw-error" class="error" for="pw"></label>
		</div>
		<div class="pw2-input">
			<label for="pw2">비밀번호 확인</label>
			<div class="input-bg">
				<input type="password" name="pw2" id="pw2" placeholder="비밀번호를 입력하세요.">
			</div>
			<label id="pw2-error" class="error" for="pw2"></label>
		</div>
		<div class="name-input">
			<label for="name">이름</label>
			<div class="input-bg">
				<input type="text" name="name" id="name" placeholder="이름을 입력하세요.">
			</div>
			<label id="name-error" class="error" for="name"></label>
		</div>
		<div class="phone-input">
			<label for="phone">전화번호</label>
			<div class="input-bg">
				<input type="text" name="phone" id="phone" placeholder="010-xxxx-xxxx형태로 입력하세요.">
			</div>
			<label id="phone-error" class="error" for="phone"></label>
		</div>
		<div class="add-input">
			<label for="add1">주소</label>
			<div class="postcode-wrap">                   
			<input class="postcode" placeholder="   우편번호" name="postcode" id="postcode" type="text" readonly="readonly" >
			    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
			</div>
			<div class="input-bg add1">
				<input type="text" name="add1" id="add1" readonly placeholder="주소를 입력하세요.">
			</div>
			<div class="input-bg add2">
				<input type="text" name="add2" id="add2" placeholder="상세주소를 입력하세요.">
			</div>
			<label id="add1-error" class="error" for="add1"></label>
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

<!-- 입력값 유효성 검사 -->
<script type="text/javascript">
$("#signup-form").validate({
	rules : {
		id : {
			required : true,
			regex : /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/ 
		},
		nickname : {
			required : true,
			regex : /^[a-zA-Z0-9!@#가-힣]{1,8}$/
		},
		pw : {
			required : true,
			regex : /^[a-zA-Z0-9!@#]{6,15}$/
		},
		pw2 : {
			equalTo : pw //name이 아닌 id를 써 줌
		},
		name : {
			required : true,
			regex : /^[a-zA-Z가-힣]{2,20}$/
		},
		phone : {
			required : true,
			regex : /^\d{2,3}-\d{3,4}-\d{4}$|^\d{3,4}-\d{4}-\d{4}$/
		},
		add1 : {
			required : true
		}
	}, 
	messages : {
		id : {
			required : "필수 입력 항목입니다.",
			regex : "이메일 형식이 아닙니다."
		},
		nickname : {
			required : "필수 입력 항목입니다.",
			regex : "닉네임은 숫자, 한글, 영문, 특수문자 !@# 만 사용가능하며 1~8자입니다."
		},
		pw : {
			required : "필수 입력 항목입니다.",
			regex : "비밀번호는 숫자,영문, 특수문자 !@#만 사용가능하며 6~15자입니다."
		},
		pw2 : {
			equalTo : "비밀번호와 일치하지 않습니다."
		},
		name : {
			required : "필수 입력 항목입니다.",
			regex : "이름은 한글, 영문만 가능하며 2~20자입니다."
		},
		phone : {
			required : "필수 항목입니다.",
			regex : "전화번호 형식이 아닙니다."
		},
		add1 : {
			required : "필수 항목입니다."
		}
	}
});
$.validator.addMethod(
	"regex",
	function (value, element, regexp){
		var re= new RegExp(regexp);
		return this.optional(element) || re.test(value);
	},
	"정규표현식에 맞지 않습니다."
)
</script>

<!-- 중복 검사 여부 -->
<script type="text/javascript">
	let idFlag = false
	let nicknameFlag = false
	
	// 버튼 클릭 시 중복 검사 진행
	$(".id-dup-check").click(function(){
		let id = $("[name=id]").val();
		let idRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
		
		if(!id){
			$("#id-error").text("아이디를 입력하세요.")
			return
		}
		
		if(!idRegex.test(id)){
			return false;
		}
		
		let obj = {
				id : id
		}
		
		$.ajax({
			async : false,
			url : '<c:url value="/id/check/"/>', 
			type : 'get', 
			data : obj, 
			dataType : "json", 
			success : function (data){
				result = data.result
				
				if(!result){
					alert("이미 사용중인 아이디입니다.");
					$("#id").css("color", "red")
				}else{
					alert("사용 가능한 아이디입니다.")
					$("#id-error").text("")
					idFlag = true
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				console.log("예외 발생")
			}
		});
		
	})
	
	$(".nickname-dup-check").click(function(){
		let nickname = $("[name=nickname]").val();
		let nicknameRegex = /^[a-zA-Z0-9!@#가-힣]{1,8}$/
		
		if(!nickname){
			$("#nickname-error").text("닉네임을 입력하세요.")
			return
		}
		
		if(!nicknameRegex.test(nickname)){
			return false;
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
					nicknameFlag = true;
				}
			},
			error : function (a, b, c) {
				console.error("예외 발생");
			}
		})
		
	})
	
	// 값이 변경되면 flag를 false로 변경함
	$("[name=id]").change(function(){
		idFlag = false;
		$("#id").css("color", "black")
	})
	$("[name=nickname]").change(function(){
		nicknameFlag = false;
		$("#nickname").css("color", "black")
	})
	
	// 각 flag가 true 상태인지 확인함
	$("form").submit(function(){
		if(!idFlag){
			alert("아이디 중복 검사를 해야합니다.");
			return false;
		}
		if(!nicknameFlag){
			alert("닉네임 중복 검사를 해야합니다.");
			return false;
		}
	})
	
	function execPostCode() {
         new daum.Postcode({
             oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                console.log(data.zonecode);
                console.log(fullRoadAddr);
                
                
                $("[name=postcode]").val(data.zonecode);
                $("[name=add1]").val(fullRoadAddr);
                
                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
            }
         }).open();
     }


</script>
</body>
</html>