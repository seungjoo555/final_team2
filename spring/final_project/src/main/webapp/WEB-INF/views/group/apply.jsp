<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/groupapply.css"/>">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3 class="apply-title">
		<c:if test="${recruit.recu_type == 0}">
			스터디 지원서
		</c:if>
		 <c:if test="${recruit.recu_type == 1}">
			프로젝트 지원서
		</c:if>
	</h3>
	<div class="sub-box">
		<h5 class="sub-title">1. 프로젝트 기본 정보를 입력해 주세요.</h5>
		<a href="<c:url value="/group/detail?num=${recruit.recu_num}"/>" class="recruit-detail">공고 보기</a>
	</div>
	<hr>
	<form action="<c:url value="/group/apply"/>" method="post" class="group-apply-form">
		<input type="hidden" name="num" value="${recruit.recu_num}">
		<div class="form-row-content">
			<textarea rows="10" class="form-control second-box" id="goap_content" name="goap_content">지원 직군 : <br> 지원 사유 : <br> 경험 / 경력 : <br> 사용 가능한 기술 / 언어 :  <br> 다짐 : </textarea>
		</div>
		<div class="button-area">
			<button type="button" class="group-apply-cancel-btn">취소</button>
			<button class="group-apply-btn">지원하기</button>
		</div>
	</form>
	
	<script type="text/javascript">
	$('#goap_content').summernote({
	  placeholder: '지원 직군 : <br> 지원 사유 : <br> 경험 / 경력 : <br> 사용 가능한 기술 / 언어 :  <br> 다짐 : ',
	  tabsize: 2,
	  height: 400
	});
	
	<!-- 취소 버튼 클릭 이벤트-->
	$('.group-apply-cancel-btn').click(function(){
		if(confirm("작성을 취소하고 이전으로 돌아가시겠습니까?")){
			location.href='<c:url value="/group/detail?num=${recruit.recu_num}"/>';
		}
	});
	
	<!-- 작성하기 버튼 클릭 이벤트-->
	$('.group-apply-btn').click(function(){
		if(!goap_content.value) {
			alert('모든 항목은 필수 입력 사항입니다.');
			return false;
		}
		
		if(confirm("입력하신 내용으로 모집 공고를 올리시겠습니까?")) {
			location.href='<c:url value="/group/applydetail?num=${recruit.recu_num}"/>';
		} else {
			return false;
		}
	});
	
	
	</script>
</body>
</html>