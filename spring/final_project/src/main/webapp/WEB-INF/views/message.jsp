<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<c:if test="${msg != null}">
	alert('${msg}');
	// 클라이언트 측에서 확인 대화 상자를 표시하도록 설정된 경우
	<c:if test="${confirm}">
	    // 확인 대화 상자를 표시하고, 사용자의 응답에 따라 다른 동작을 수행합니다.
	    if (confirm('${confirmMsg}')) {
	        // 사용자가 확인을 선택한 경우
	        location.href = '<c:url value="${confirmUrl}"/>';
	    } else {
	        history.back();
	    }
	</c:if>
	// 클라이언트 측에서 확인 대화 상자를 표시하도록 설정되지 않은 경우
	<c:if test="${!confirm}">
	    location.href = '<c:url value="${url}"/>';
	</c:if>
</c:if>

</script>
</body>
</html>

