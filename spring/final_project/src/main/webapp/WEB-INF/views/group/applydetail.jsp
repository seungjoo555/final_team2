<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/applydetail.css"/>">
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
		<h5 class="sub-title">1. 지원서를 확인해 주세요.</h5>
		<a href="<c:url value="/group/detail?num=${recruit.recu_num}"/>" class="recruit-detail">공고 보기</a>
	</div>
	<hr>
	<input type="hidden" name="num" value="${goap.goap_recu_num}">
	<div class="form-row-content">
		<textarea rows="10" class="form-control second-box" disabled>${goap.goap_content}</textarea>
	</div>
	<div class="button-area">
		<c:if test="${goap.goap_me_id == user.me_id}">
			<button type="button" class="group-apply-back-btn">뒤로가기</button>
			<button class="group-apply-update-btn">수정하기</button>
		</c:if>
	</div>
	<script type="text/javascript">
		$('.second-box').summernote({
		  placeholder: '지원 직군 : <br> 지원 사유 : <br> 경험 / 경력 : <br> 사용 가능한 기술 / 언어 :  <br> 다짐 : ',
		  tabsize: 2,
		  height: 400
		});
		
		$('.second-box').summernote('disable');
		
		$('.group-apply-back-btn').click(function() {
			location.href='<c:url value="/group/detail?num=${goap.goap_recu_num}"/>'
		})
		
		$('.group-apply-update-btn').click(function(){
			location.href='<c:url value="/group/apply/update?num=${goap.goap_recu_num}"/>';
		})
	</script>
</body>
</html>