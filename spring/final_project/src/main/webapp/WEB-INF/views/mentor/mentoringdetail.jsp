<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="apply-mentoring_header">
  		<div class="header-title">
  			<h3>${mentoring.ment_title}</h3>
  		</div>
  	</div>
  	<div class="memberInfo" >
		<img class="basic-profile" value="${mentorInfo.mentIf_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
		<a href="<c:url value="/mypage/profile?me_id=${mentorInfo.mentIf_me_id}"/>" class="mentor-nickname" value="${mentorInfo.mentIf_me_id}">${mentorInfo.mentIf_me_nickname}</a>
  	</div>
  	<div class="btn-box">
		<!-- 본인 글일 경우 신고기능 비활성화 -->
		<c:if test="${mentorInfo.mentIf_me_id != user.me_id}">
			<div class="report-btn-box">
				<input type="hidden" class="report-isture" value="${istrue}">
				<button class="report-btn">
					<img src="<c:url value="/resources/img/siren_icon.svg" />" alt="사이렌아이콘" width="24" class="siren-icon">
				</button>
			</div>
		</c:if>
		<div class="like-btn-box">
			<input type="hidden" class="reco_ment_num" value="${mentoring.ment_num}">
			<input type="hidden" class="reco_ment_count" value="${reco_ment_count.reco_ment_count}">
			<button type="button" id="btnUp" data-state="1" class="like-btn btn-up">
				<img src="<c:url value="/resources/img/like_icon.svg" />" alt="라이크아이콘" width="24" class="like-icon">
				<span class="init-like">${reco_ment_count.reco_ment_count}</span>
			</button>
		</div>				
	</div>
	<hr>
	<div class="mentoring_body_info_list">
		<ul class="mentoring-inputList">
			<li class="mentoring-listItem">
				<label for="ment_job" class="inputbox-lableText">직무</label>
				<span id="ment_job" class="inputbox-input">${mentorInfo.mentIf_ment_job}</span>
			</li>
			<li class="mentoring-listItem">
				<label for="ment_exp" class="inputbox-lableText">경력</label>
				<span class="inputbox-input" id="ment_exp">${mentorInfo.mentIf_exp}년</span>
			</li>
			<li class="mentoring-listItem">
				<label for="ment_portfolio" class="inputbox-lableText">포트폴리오</label>
				<span class="inputbox-input" id="ment_portfolio">${mentorInfo.mentIf_portfolio}</span>
			</li>
			<li class="mentoring-listItem">
				<label for="ment_duration" class="inputbox-lableText">종료일</label>
				<span class="inputbox-input" id="ment_duration">${mentoring.ment_duration}</span>
			</li>
		</ul>
	</div>
	<div class="apply-mentoring_body_content">
		<div>${mentoring.ment_content}</div>
	</div>
</body>
</html>