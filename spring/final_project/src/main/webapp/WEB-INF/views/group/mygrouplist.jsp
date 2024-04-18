<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.container{width:1570px; background-color: #F9F9F9; margin: 100px auto 200px auto; padding: 60px 0; box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);}
	
	/* info-bar style*/
	.container-info-bar{height: 90px; width: 90%; margin: 0 auto;}
	
	.container-info-bar>*{line-height: 90px; float:left; color: #243323; font-size: 36px;}
	.container-info-bar::after{content: ''; display: block;  clear:both;}

	.container-info-bar [class$=title]{font-weight: 900;}
	
	[class$=-bg]{width: 90%; margin: 30px auto; background-color: white; padding: 55px 0; 
		display:flex; flex-direction: column; justify-content: center; align-items: center;}
	
	/*list 내부 요소 style*/
		[class$=list]{width: 90%;}
		[class$=list]>:last-child{border:none;} /* list의 마지막 요소는 border 없음 */
		
		/*list 내부 info 요소 style*/
		[class$=list] [class$=info] *{float:left}
		[class$=list] [class$=info]::after{content: ''; display: block;  clear:both;}
		
		[class$=list] [class$=info] .image{width: 60px; height: 60px; border: solid black 1px;}
	/* =================================================================================== */
	
	.group-title{width: 100%; height: 50px; font-size: 24px; border-bottom: 1px solid #9C9C9C;}
	.group-title a{color: black; font-weight: bold; text-decoration: none;}
	
</style>
</head>
<body>
	<div class="container">
		<div class="container-info-bar">
			<div class="grouplist-title">나의 그룹</div>
		</div>
		<div class="group-list-bg">
			<div class="group-list">
				<c:if test="${list != null}">
					<c:forEach items="${list}" var="group">
						<div class="group-title">
							<c:url value="/group/home" var="url">
								<c:param name="group" value="${group.go_num}"/>
							</c:url>
							<a href="${url}">${group.go_name}</a>
						</div>
					</c:forEach>
					인원수 / 플젝인지 스터디인지 / 총 공부시간 띄우기
				</c:if>
				
				<c:if test="${list == null }">
					<div>가입한 그룹이 없습니다.</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>