<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style type="text/css">

	.mentorinsert-container{
		width : 1200px;
		margin : 0 auto;
	}
	.mentorinsert-container h2{
		margin-top : 100px;
		text-align: left;
		font-size : 24px;
		
		
		/*
		display:flex;
		justify-content: space-between;*/
	}
	
	.form-wrap{
		display : flex;
		justify-content : space-between;
	}
	.mentorinsert-container input{
		width : 550px;
		height : 50px;
		border-radius : 5px;
		background-color: #EBEBEB;
		padding : 10px;
	}
	
	.mentorinsert-container input::placeholder{
		padding : 10px;	
	}
	.mentorinsert-container label{
		margin-top : 50px;
	}
	.form-btn-group{
		display : block;
		margin-top : 70px;
		text-align : right;
		margin-bottom : 200px;
	}
	
	.form-btn-group button{
		height : 50px;
		border-radius : 5px;
	}
	.btn-cancel{
		width : 70px;
		background-color: #EBEBEB
	}
	
	.btn-submit{
		width : 90px;
		background-color : #E6F5E5
	}
	.bank-wrap{
		display:flex;
	}
	.bank-wrap input{
		width:426px;
		margin-left : 22px;
		
	}
	.bank-wrap select{
		background-color: #EBEBEB;
		border-radius = 5px;
	
	}
	
	.mentIf_ment_job{
		background-color: #EBEBEB;
		border-radius = 5px;
		width : 550px;
		height : 50px;
	}
	

	
	
</style>
</head>
<body>
<div class="mentorinsert-container">
	<form action="<c:url value="/mentor/insert"/>" method="post" class="mentor-insert-form">
		<div class="txt-wrap">
			<h2>멘토 정보를 입력해주세요.</h2>
		</div>
		<hr style="margin-top:50px;">
		<div class="form-wrap">
			<div class="mentor-form-group">
				<label for="menIf_ment_job">멘토 직무</label>
				<br>
				<select name="mentIf_ment_job" class="mentIf_ment_job">
				    <option hidden disabled selected>
							직무를 선택해주세요.  
				    </option>
					<c:forEach items="${jobList}" var="ment">
						<option value="${ment.ment_job}">${ment.ment_job}</option>
					</c:forEach>
				</select>
			</div>
			<div class="mentor-form-group">
				<label for="mentIf_exp">경력</label>
				<br>
				<input type="number" placeholder="입력" name="mentIf_exp" class="mentIf_exp">
			</div>
		</div>
		<div class="form-wrap">
			<div class="mentor-form-group">
				<label for="mentIf_account">계좌 정보</label>
				<br>
				<div class="bank-wrap">
					<select name="mentIf_bank" class="mentIf_bank">
						<option hidden disabled selected>
							은행   
						</option>
						<option value="국민은행">국민은행</option>
						<option value="기업은행">기업은행</option>
						<option value="하나은행">하나은행</option>
						<option value="농협은행">농협은행</option>
						<option value="토스뱅크">토스뱅크</option>
						<option value="카카오뱅크">카카오뱅크</option>
					</select>
					<input type="text" placeholder="입력" name="mentIf_account" class="mentIf_account">
				</div>
			</div>
			<div class="mentor-form-group">
				<label for="mentIf_portfolio">포트폴리오</label>
				<br>
				<input type="text" placeholder="입력" name="mentIf_portfolio" class="mentIf_portfolio">
			</div>
		</div>
		<div>
			<div class="form-group">
				<label for="mentIf_intro">자기소개</label>
				<textarea class="form-control" id="mentIf_intro" name="mentIf_intro"></textarea>
			</div>
		</div>
		<input type="hidden" name="mentIf_me_id" value="${user.me_id}">
		<div class="form-btn-group">
			<button type="button" class="btn-cancel">취소</button>
			<button type="button" class="btn-submit">작성하기</button>
		</div>
	</form>
</div>

<script type="text/javascript">
$('[name=mentIf_intro]').summernote({
	placeholder: '자기소개를 입력하세요.',
	tabsize: 2,
	height: 400
});
</script>

<script type="text/javascript">

$('.btn-submit').click(function(){
	let datas = {
		job : $('.mentIf_ment_job').val(),
		exp : $('.mentIf_exp').val(),
		bank : $('.mentIf_bank').val(),
		account : $('.mentIf_account').val(),
		portfolio : $('.mentIf_portfolio').val()
	};
	
	console.log(datas.job);
	
	if(datas.job!==null&&checkStr(datas.exp)&&checkStr(datas.account)&&checkStr(datas.portfolio)&&datas.bank!==null){
		if(confirm('해당 정보로 멘토신청을 하시겠습니까?')){
			$('.mentor-insert-form').submit();
		}else{
			alert('취소하셨습니다.')
		}
	}else{
	   alert("자기 소개를 제외한 모든 항목은 필수항목입니다.")
	}
	
})

function checkStr(str){
	if(str.length===0 || str==null){
		return false;
	}
	return true;
}

$('.btn-cancel').click(function(){
	if(confirm("작성을 멈추고 이전화면으로 돌아가시겠습니까?")){
		location.href ="<c:url value='/mentor/apply'/>";
	}
})

</script>
</body>
</html>