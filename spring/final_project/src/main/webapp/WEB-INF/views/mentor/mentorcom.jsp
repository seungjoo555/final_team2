<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.com-wrap{
		width:1200px;
	}
	.com-wrap img{
		display : block;
		margin : 100px auto;
	}
	
	.text-wrap{
		text-align : center;
	}
	.a-wrap{
		display : block;
		width : 200px;
		height : 40px;
		background-color: #E6F5E5;
		text-align: center;
		margin : 50px auto;
	}
	
	.a-wrap a::visited{
		text-decoration: none;
	}
	.a-wrap a::hover{
		text-decoration: none;
	}

</style>
</head>
<body>
	<div class="com-wrap">
		<img alt="mentor-img" src="<c:url value="/resources/img/mentor.png"/>">
		<div class="text-wrap">
			<h2>멘토 신청이 완료되었습니다.</h2>
			<p style="margin-top:50px;">승인이 완료되면 나만의 멘토링과 강의를 열어 지식을 공유할 수 있습니다.</p>
		</div>
		<div class="a-wrap">
			<a href="<c:url value="/"/>">메인으로 돌아가기</a>
		</div>
	</div>
</body>
</html>