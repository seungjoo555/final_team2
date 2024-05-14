<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/lecture.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
</head>
<body>

<div class="first-container">
	<a href="<c:url value="/lecture/list"/>">
		<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" color="808080" 
			cursor="pointer" height="30" width="30" xmlns="http://www.w3.org/2000/svg" style="color: rgb(128, 128, 128);">
			<path d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path>
		</svg>
	</a>
	<div class="lecture_topic">${lecture.lect_name}</div>
	<div class="lecture_userAndDate">
		<img class="basic-profile" value="${writer.me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
		<a href="<c:url value="/mypage/profile?me_id=${writer.me_id}"/>" class="lecture_user">${writer.me_nickname}</a>
		<div class="report-btn-box"><button class="report-btn">신고</button></div>
		<!-- <div class="lecture_regDate">날짜</div> -->
	</div>
	<hr>		
	<ul class="lecture-inputList">
		<li class="lecture-listItem">
			<label for="recu_type" class="inputbox-lableText">강의 게시일</label>
			<span id="recu_type" class="inputbox-input">${lecture.lect_posting}</span>
		</li>
		<li class="lecture-listItem">
			<label for="recu_count" class="inputbox-lableText">최신 업데이트</label>
			<span class="inputbox-input" id="recu_count">${lecture.lect_update}</span>
		</li>
	</ul>
	<div class="lecture-inputList">
		<li class="lecture-cateLang">
			<span class="lecture-spancateLang">강의 분야</span>
			<ul class="lecture-cateLangList">
				<c:forEach items="${totalCategory}" var="cate">
					<li class="lecture-position">${cate.toCt_progCt_name}</li>
				</c:forEach>
			</ul>
		</li>
		<li class="lecture-cateLang">
			<span class="lecture-spancateLang">사용 언어,스킬</span>
			<ul class="lecture-cateLangList">
				<c:forEach items="${totalLanguage}" var="lang">
					<li class="lecture-position">${lang.toLg_lang_name}</li>
				</c:forEach>
			</ul>
		</li>
	</div>
</div>
<div class="cd-floating__price cd-floating__price--dis">
	<p class="cd-price__discount-rate"><!-- 할인율 --></p>
	<c:choose>
		<c:when test="${lecture.lect_price != 0}">
			<p>이런 유익한 강의가?! 단돈 ${lecture.lect_price}원!!!</p>
		</c:when>
		<c:otherwise>
			<p>이런 유익한 강의가! 무료라고?!!!</p>
		</c:otherwise>
	</c:choose>
	<del class="cd-price__reg-price"><!-- 원 가격 --></del>
</div>
<a class="btn btn-success col-12" href="<c:url value="#"/>">신청하기</a>
<div class="second-container">
	<h4>강의 소개</h4>
	<hr>
	<section>
		<div class="form-row content">
			<div style="min-height: 400px" class="form-control second-box" id="lect_content">${lecture.lect_intro}</div>
		</div>
	</section>
</div>
	
</body>
</html>