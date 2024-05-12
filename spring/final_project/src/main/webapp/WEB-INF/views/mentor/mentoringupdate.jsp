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
	.h-wrap hr{
		margin-top : 50px;
	}
	
	.mentoring-input-wrap{
		display : flex;
		justify-content : space-between;
		margin-top : 35px;
	}
	
	.mentoring-form-group input{
		width : 550px;
		height : 50px;
		border-radius : 5px;
		background-color: #EBEBEB;
		padding : 10px;
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
	
	.toCt_progCt_num{
		width : 550px;
		height : 50px;
		background-color: #EBEBEB;
		border-radius = 5px;
	}
	
	.text-wrap{
		margin-top : 35px;
	}
	
	
	
</style>
</head>
<body>
<div class="mentoringinsert-wrap">
	<div class="h-wrap">
		<h2>멘토링 클래스 정보를 입력하세요.</h2>
		<hr>
	</div>
	<div class="insert-form-wrap">
		<form action="<c:url value="/mentor/mentoring/update"/>" method="post" class="mentoring-insert-form">
			<input type="hidden" name ="ment_num" class="ment_num" value="${mentoring.ment_num }">
			<input type="hidden" name ="ment_me_id" class="ment_me_id" value="${mentoring.ment_me_id }">
			<div class="mentoring-insert-wrap">
				<div class="mentoring-input-wrap">
					<div class="mentoring-form-group">
						<label for="ment_title">클래스이름</label>
						<br>
						<input type="text" name ="ment_title" class="ment_title" placeholder="멘토링 클래스 제목을 입력하세요." value="${mentoring.ment_title }">
					</div>
					<div class="mentoring-form-group">
						<label for="ment_duration">클래스기간</label>
						<br>
						<input type="date" name="ment_duration" class="ment_duration" placeholder="맨토링 클래스 종료일을 입력하세요" value="${mentoring.ment_duration }">
					</div>
				</div>
				<div class="mentoring-input-wrap">
					<div class="mentoring-form-group">
						<label for="mentIf_ment_job">멘토직무</label>
						<br>
						<input type="text" name ="mentIf_ment_job" class="mentIf_ment_job" value="${mentIf.mentIf_ment_job}" readonly>
					</div>
					<div class="mentoring-form-group">
						<label for="mentIf_exp">멘토경력</label>
						<br>
						<input type="text" name="mentIf_exp" value = "${mentIf.mentIf_exp}" readonly>
					</div>
				</div>
				<div class="mentoring-input-wrap">
					<div class="mentoring-form-group">
						<label for="">멘토 분야</label>
						<br>
						<select name="toCt_progCt_num" class="toCt_progCt_num">
							<c:forEach var="progCt" items="${progCtList}">
								<option value="${progCt.progCt_num}" >${progCt.progCt_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="mentoring-form-group">
						<label for="mentIf_portfolio">포트폴리오</label>
						<br>
						<input type="text" name="mentIf_portfolio" value = "${mentIf.mentIf_portfolio}" readonly>
					</div>
				</div>
				<div class="text-wrap">
					<label for="ment_content">클래스내용</label>
					<textarea class="form-control ment_content" id="ment_content" name="ment_content" >${mentoring.ment_content }</textarea>
				</div>
				<div class="form-btn-group">
					<button type="button" class="btn-cancel">취소</button>
					<button type="button" class="btn-submit">작성하기</button>
				</div>
			</div>		
		</form>
	</div>
</div>
<script type="text/javascript">


</script>

<script type="text/javascript">
$('[name=ment_content]').summernote({
	placeholder: '맨토링 클래스 소개를 입력하세요.',
	tabsize: 2,
	height: 400
});
</script>

<script type="text/javascript">

$('.btn-submit').click(function(){
	let datas = {
		title : $('.ment_title').val(),
		duration : $('.ment_duration').val(),
		category : $('.toCt_progCt_num').val(),
		content : $('.ment_content').val()
	};
	
	if(datas.category!==null&&checkStr(datas.title)&&checkStr(datas.content)&&checkStr(datas.duration)){
		if(confirm('해당 정보로 멘토링클래스 수정을 하시겠습니까?')){
			$('.mentoring-insert-form').submit();
		}else{
			alert('취소하셨습니다.')
		}
	}else{
	   alert("모든 항목은 필수항목입니다.")
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
		location.href ="<c:url value='/mentor/list'/>";
	}
})

</script>
</body>
</html>