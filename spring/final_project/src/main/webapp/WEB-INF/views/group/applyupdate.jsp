<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/applyupdate.css"/>">
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
		<h5 class="sub-title">1. 지원서를 수정해 주세요.</h5>
		<a href="<c:url value="/group/detail?num=${recruit.recu_num}"/>" class="recruit-detail">공고 보기</a>
	</div>
	<hr>
	<form action="<c:url value="/group/applyupdate"/>" method="post" class="group-apply-form">
		<input type="hidden" name="num" value="${recruit.recu_num}">
		<div class="form-row-content">
			<textarea rows="10" class="form-control second-box" id="goap_content" name="goap_content">${goap.goap_content}</textarea>
		</div>
		<div class="button-area">
			<button type="button" class="group-apply-update-cancel-btn">취소</button>
			<button class="group-apply-update-btn">수정하기</button>
		</div>
	</form>
	<script type="text/javascript">
		$('#goap_content').summernote({
		  placeholder: '지원 직군 : <br> 지원 사유 : <br> 경험 / 경력 : <br> 사용 가능한 기술 / 언어 :  <br> 다짐 : ',
		  tabsize: 2,
		  height: 400
		});
		
		<!-- 작성하기 버튼 클릭 이벤트-->
		$('.group-apply-update-btn').click(function(){
			if(!goap_content.value) {
				alert('모든 항목은 필수 입력 사항입니다.');
				return false;
			}
		});
		
		$('.group-apply-update-cancel-btn').click(function() {
			if(confirm("수정을 취소하고 이전으로 돌아가시겠습니까?")){
				location.href='<c:url value="/group/applydetail?num=${recruit.recu_num}"/>';
			}
		})
	</script>
</body>
</html>