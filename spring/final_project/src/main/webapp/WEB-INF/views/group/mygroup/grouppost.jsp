<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- mygroup.css -->
<link rel="stylesheet" href="<c:url value="/resources/css/mygroup.css"/>">

<style>
	/* ======================================= grouppost.jsp ======================================= */
	
	.post-list-bg{padding: 55px 70px;}
	
	/* 그룹 게시글 작성 form 관련 */
		.group-post-input{margin: 0px auto; width: 90%;}
		.group-post-input::after{display: block; content: ''; clear: both;}
		
		.group-post-input .input{width: 100%; height: 96px; border: 1px solid #4F4F4F}
		.group-post-input .submit{width: 140px; height: 40px; line-height: 40px; border-radius: 3px; 
			background-color: #649B60; color: white;}
	
	/* 그룹 게시글 관련 */
		.post-list-bg>*{width: 100%; border-bottom: 1px solid #9C9C9C; padding: 20px 0;}
		.post-list-bg>*:last-child{border-bottom: none;}
		.post-list-bg>*:first-child{padding-top: 0px;}
		
		.post-info{height: 40px;}
		.post-info>*{line-height: 40px; }
		.post-info .writer{margin-right: 5px; font-size: 20px; font-weight: bold;}
		.post-info .time{font-weight: normal; color: #9C9C9C;}
		.post-info::after{display: block; content: ''; clear: both;}
		
		.post-content{margin-top: 10px; color: #4F4F4F;}
		
		.post-manage-btn-group{width: 20%;}
		.post-manage-btn-group *{width: 100px; height: 30px; line-height: 30px; text-align: center; 
			font-size: 14px; border-radius: 5px; margin-top: 20px;}
		.post-manage-btn-group *:first-child{color: black; background-color: #C9C9C9}
		.post-manage-btn-group *:last-child{margin-left: 10px; color: white; background-color: #5A7059}	
	
	
</style>

</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${group == null }">
				<div class="not-group-member">
					<div>가입한 그룹이 아닙니다.</div>
					<a href="<c:url value="/"/>">홈으로 가기</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="container-info-bar">
					<div class="float-left group-title">${group.go_name}</div>
					<div class="float-left">그룹 게시판</div>
				</div>
				<div class="group-post-input">
					<form action="">
						<textarea class="input" cols="5"></textarea>
						<button class="submit float-right">등록</button>
					</form>
				</div>
				<div class="post-list-bg">
					<c:forEach var="post" items="${list}">
						<div>
							<div class="post-info">
								<div class="writer float-left">${post.nickname}</div>
								<div class="time float-left">${post.time_ago}</div>
							</div>
							<div class="post-content">
								${post.gopo_content }
							</div>
							<c:if test="${user.me_id == post.gopo_gome_me_id }">
								<div class="post-manage-btn-group">
									<a class="float-left">수정</a>
									<a class="float-left">삭제</a>
								</div>
							</c:if>
						</div>
					
					</c:forEach>
				</div>
				페이지네이션 추가 필요
			</c:otherwise>
	</c:choose> 
	</div>
</body>
</html>