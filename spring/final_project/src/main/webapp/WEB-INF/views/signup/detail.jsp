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


<style type="text/css">
.signup-detail-form{margin-top: 40px;}
.on-off-check{display: flex; width: 100%;}
.onoff-input input{width: 10%; }
</style>
</head>
<body class="center">
<div class="container">
	<h1>상세정보 입력</h1>
	<h5 class="sub">상세 정보를 입력해주세요. 작성한 내용은 프로필에 표시되며, 추후 변경 가능합니다.</h5>
	
	<form action="<c:url value="/signup/detail"/>" method="post" class="signup-detail-form" id="signup-detail-form">
		<div class="interest-input">
			<label for="interest">관심 영역</label>
			<div class="input-bg">
				<input type="text" name="interest" id="interest" placeholder="프론트 엔드, 백엔드, 정보보안 등.">
			</div>
		</div>
		<div class="location-input">
			<label for="location">선호 만남지역</label>
			<div class="input-bg">
				<input type="text" name="location" id="location" placeholder="오프라인 만남 선호 지역을 입력하세요.">
			</div>
		</div>
		<div class="time-input">
			<label for="time">선호 활동 시간대</label>
			<div class="input-bg">
				<input type="text" name="time" id="time" placeholder="선호하는 활동 시간대를 입력해주세요. (0~24)">
			</div>
		</div>
		<div class="onoff-input">
			<label for="onoff">온/오프라인 가능 여부</label>
			<div class="input-bg">
				<input type="radio" name="onoff" value="online" id="online">
				<label for="online">온라인 만</label>
				<input type="radio" name="onoff" value="offline" id="offline">
				<label for="offline">오프라인 만</label>
				<input type="radio" name="onoff" value="both" id="both">
				<label for="both">모두 가능</label>
			</div>
		</div>
		<div class="intro-input">
			<label for="intro">자기소개</label>
			<div class="input-bg">
				<input type="text" name="intro" id="intro" placeholder="자기소개를 입력하세요.">
			</div>
		</div>
		<button class="submit">완료하기</button>
	</form>
</div>

<script type="text/javascript">
$('#signup-detail-form').on('submit', function(){
	let time = $('#time').val()

	if(time > 24 || time < 0 || isNaN(time)){
		alert('0~24의 숫자를 입력해주세요.')
		return false
	}

	return true;
})
</script>

</body>
</html>