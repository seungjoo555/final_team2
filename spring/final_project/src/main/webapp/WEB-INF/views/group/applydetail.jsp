<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
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
	
	<input type="hidden" name="num" value="${goap.goap_recu_num}">
	<div class="form-row-content">
		<textarea rows="10" class="form-control second-box"readonly>
			${goap.goap_content}
		</textarea>
	</div>
	<div class="button-area">
		<button type="button" class="group-apply-cancel-btn">취소</button>
		<button class="group-apply-update-btn">수정하기</button>
	</div>
</body>
</html>