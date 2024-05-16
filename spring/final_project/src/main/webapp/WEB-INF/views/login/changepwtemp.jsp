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
	

	.error{
	
		color:red;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
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
				<label id="pw-error" class="error" for="pw"></label>
			</div>
			<div class="changePW-form-group">
				<label for="pw2">새 비밀번호 확인</label>
				<input type="text" class="form-control newpw2" id="pw2" name="pw2">
				<label id="pw2-error" class="error" for="pw2"></label>
			</div>
			<div class="changePW-warnning">
		      	<p class="warn-msg">&nbsp</p>
		    </div>
			<button class="changePW-btn" type="submit">비밀번호변경</button>
			<input type="hidden" class="me_id" name="me_id" value="${user.me_id}">
		</form>
	</div>
	
<script type="text/javascript">
$(".changePW-form").validate({
	rules : {
		me_pw : {
			required : true,
			regex : /^[a-zA-Z0-9!@#]{6,15}$/
		},
		pw2 : {
			equalTo : pw //name이 아닌 id를 써 줌
		}
	}, 
	messages : {
		me_pw : {
			required : "필수 입력 항목입니다.",
			regex : "비밀번호는 숫자,영문, 특수문자 !@#만 사용가능하며 6~15자입니다."
		},
		pw2 : {
			equalTo : "비밀번호와 일치하지 않습니다."
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
</body>
</html>