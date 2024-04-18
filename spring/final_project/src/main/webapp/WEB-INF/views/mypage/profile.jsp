<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/profile.css"/>">
</head>
<body>
	<div>
		<label class="profile-label">
			<img alt="프로필" src="<c:url value="/resources/img/basic_profile.png"/>">
		</label>
		<div class="profile-nickname">${member.me_nickname}</div>
		<div class="profile-joindate-box">
			<span class="profile-datetext">가입일 : </span>
			<fmt:formatDate value="${member.me_date}" pattern="yyyy-MM-dd" /> 
		</div>
		<div class="profile-degree">${member.me_degree }</div>
	</div>
	<div>
		<h3>프로필</h3>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="me_interests" class="inputbox-lableText">관심 분야</label>
				<input type="text" class="inputbox-input" name="me_interests" readonly value="${member.me_interests}">
				
			</li>
			<li class="recruit-listItem">
				<label for="me_preferloc" class="inputbox-lableText">선호 지역</label>
				<input type="text" class="inputbox-input" name="me_preferloc" readonly value="${member.me_preferloc}">
				
			</li>
		</ul>
		<ul>
			<li class="recruit-listItem">
				<label for="me_prefertime" class="inputbox-lableText">선호 시간</label>
				<input type="text" class="inputbox-input" name="me_prefertime" readonly value="${member.me_prefertime}">
				
			</li>
			<li class="recruit-listItem">
				<label for="me_onoff" class="inputbox-lableText">온/오프라인</label>
				<input type="text" class="inputbox-input" name="me_onoff" readonly value="${member.me_onoff}">
				
			</li>
		</ul>
		<ul>
			<li class="recruit-listItem">
				<label for="me_intro" class="inputbox-lableText">소개</label>
				<input type="text" class="inputbox-input" name="me_intro" readonly value="${member.me_intro}">
			</li>
		</ul>
		</ul>
	</div>
</body>
</html>