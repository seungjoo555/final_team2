<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/mentoringapplyupdate.css"/>">
<title>Insert title here</title>
</head>
<body>
	<h3 class="apply-title">멘토링 지원서</h3>
	<div class="sub-box">
		<h5 class="sub-title">1. 지원서를 수정해 주세요.</h5>
		<a href="<c:url value="/mentor/detail?num=${mentoring.ment_num}"/>" class="mentoring-detail">공고 보기</a>
	</div>
	<hr>
	<form action="<c:url value="/mentoring/apply/update"/>" method="post" class="mentoring-apply-update-form">
		<input type="hidden" name="num" value="${mentoring.ment_num}">
		<input type="hidden" name="mentAp_num" value="${mentoringAp.mentAp_num}">
		<div class="mentoring-title-container">
			<label for ="ment_title" class="mentoring-name">멘토링 명</label>
			<input type="text" class="mentoring-name-item" id="ment_title" value="${mentoring.ment_title}" readonly>
		</div>
		<div class="mentoring-contact-container">
			<label for="mentAp_contact" class="mentoring-contact">연락처</label>
			<input type="text" class="mentoring-contact-item" id="mentAp_contact" name="mentAp_contact" value="${mentoringAp.mentAp_contact}">
		</div>
		<div class="form-row-content">
			<label for="mentAp_content" class="apply-container">지원서 내용</label>
			<textarea rows="10" class="form-control second-box" id="mentAp_content" name="mentAp_content">${mentoringAp.mentAp_content}</textarea>
		</div>
		<div class="button-area">
		<c:if test="${mentoringAp.mentAp_me_id == user.me_id}">
			<button type="button" class="mentoring-apply-update-cancel-btn">취소</button>
			<button class="mentoring-apply-update-btn">수정하기</button>
		</c:if>
	</div>
	</form>
	<script type="text/javascript">
		$('.mentoring-apply-update-cancel-btn').click(function() {
			location.href='<c:url value="/mentoring/apply/detail?num=${mentoring.ment_num}"/>'
		})
		
		
		$('.mentoring-apply-update-cancel-btn').click(function() {
			if(confirm("수정을 취소하고 이전으로 돌아가시겠습니까?")){
				location.href='<c:url value="/mentoring/apply/detail?num=${mentoring.ment_num}"/>';
			}
		})
		
		<!-- 작성하기 버튼 클릭 이벤트-->
		$('.mentoring-apply-update-btn').click(function(){
			if(!mentAp_content.value || !mentAp_contact.value) {
				alert('모든 항목은 필수 입력 사항입니다.');
				return false;
			}
		});
		
	</script>
</body>
</html>