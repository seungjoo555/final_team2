<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/mentoringapplydetail.css"/>">
<title>Insert title here</title>
</head>
<body>
	<h3 class="apply-title">멘토링 지원서</h3>
	<div class="sub-box">
		<h5 class="sub-title">1. 지원서를 확인해 주세요.</h5>
		<a href="<c:url value="/mentor/detail?num=${mentoring.ment_num}"/>" class="mentoring-detail">공고 보기</a>
	</div>
	<hr>
	<input type="hidden" name="num" value="${mentoring.ment_num}">
	<input type="hidden" name="mentAp_num" value="${mentoringAp.mentAp_num}">
	<div class="mentoring-title-container">
		<div class="mentoring-name">멘토링 명</div>
		<input type="text" class="mentoring-name-item" value="${mentoring.ment_title}">
	</div>
	<div class="form-row-content">
		<div class="apply-container">지원서 내용</div>
		<textarea rows="10" class="form-control second-box" disabled>${mentoringAp.mentAp_content}</textarea>
	</div>
	<div class="button-area">
		<c:if test="${mentoringAp.mentAp_me_id == user.me_id}">
			<button type="button" class="mentoring-apply-detail-back-btn">뒤로가기</button>
			<button class="mentoring-apply-update-btn">수정하기</button>
		</c:if>
	</div>
	
</body>
</html>