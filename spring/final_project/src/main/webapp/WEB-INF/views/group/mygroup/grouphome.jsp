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
	
	/* group-calendar 관련 */
		.group-calendar{height: 100%; padding: 67px 30px 30px 30px;}
		.group-calendar .calendar{width: 100%; height:100%; border: 1px solid black;}
	
</style>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${group == null }">가입한 그룹이 아닙니다.</c:when>
		<c:otherwise>
			<div class="container-info-bar">
				<div class="float-left group-title">${group.go_name}</div>
				<div class="float-left">그룹 페이지</div>
				<div class="setting-btn float-rignt">
					<a href="#">
						<img class="hamburger-btn" src="<c:url value="/resources/img/hamburger-btn.png"/>">
					</a>
				</div>
				<div class="user-info float-rignt">
					${user.me_nickname} 님
				</div>
				
			</div>
			<div class="container-row">
				<div class="container-left">
				
					<!-- 그룹 타이머 -->
					<div class="group-timer">
						<label class="group-timer-title">스터디 시계</label>
						<div class="group-timer-box">공부 시간</div>
						<div class="group-timer-btn-group">
							<a class="start-btn">시작</a>
							<a class="pause-btn">중지</a>
						</div>
					</div>
					
					<!-- 그룹 D-DAY -->
					<div class="group-dday box">
						<div class="box-info-bar">
							D-DAY
						</div>
						<div>
							<ul class="dday-list">
								<c:forEach items= "${ddaylist}" var="dday">
									<li>
										<div>D${dday.dday}</div>
										<div>${dday.gocal_title}</div>
									</li>
								</c:forEach>
								
							</ul>					
						</div>
					</div>
				</div>
				<div class="container-right">
					<div class="group-calendar box">
						<div class="box-info-bar">
							일정
						</div>
						<div class="calendar">
						
						</div>
					</div>
				</div>
			</div>
			<div class="container-bottom">
				
				<div class="group-board box">
					<div class="box-info-bar">
						최근 그룹 게시글
						<c:url value="/group/post" var="url">
							<c:param name="groupNum" value="${group.go_num}"/>
						</c:url>
						<a href="${url}" class="to-post float-right">게시글 목록으로</a>
					</div>
					<div class="group-board-list">
						<c:forEach items="${boardlist}" var="board">
							<div>
								<label class="writer">${board.nickname}</label>
								<div class="content">${board.gopo_content}</div>
								<div class="time">${board.time_ago}</div>
							</div>
						</c:forEach>
						
						
					</div>
				</div>
			</div>
	
		</c:otherwise>
	</c:choose> 
</div>

</body>
</html>