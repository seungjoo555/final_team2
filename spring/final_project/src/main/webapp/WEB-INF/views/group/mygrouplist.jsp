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
	
	.container-info-bar>*{line-height: 90px; float:left; color: #243323; font-size: 24px;}
	.container-info-bar::after{content: ''; display: block;  clear:both;}

	.container-info-bar [class$=title]{font-weight: 900;}
	
	[class$=-bg]{width: 90%; margin: 30px auto; background-color: white; padding: 55px 0; 
		display:flex; flex-direction: column; justify-content: center; align-items: center;}
	
	/*list 내부 요소 style*/
		[class$=list]{width: 90%;}
		[class$=list]>:last-child{border:none;} /* list의 마지막 요소는 border 없음 */
		
		/*list 내부 info 요소 style*/
		
		
		[class$=list] [class$=info]{width: 100%; border-bottom: 1px solid #9C9C9C;} 
		
		[class$=list] [class$=info] .image{width: 60px; height: 60px; border: solid black 1px;}
		
	/* =================================================================================== */

	.group-list tbody>:last-child{border:none;}
	.group-list .group-info:hover{background-color: #9C9C9C;} 
	
	.group-list .group-title a{line-height: 50px; font-size: 24px; color: black; font-weight: bold; text-decoration: none;}
	.group-list .group-time{height: 50px; line-height: 50px; font-size: 18px;}
	
	.no-list{display: flex; flex-direction: column; justify-content: center; align-items: center;}
	.no-list-page:first-child{font-size: 24px; font-weight: bold; margin-bottom: 30px;}
	
	.no-list-page a{margin: 20px auto; padding: 10px 5px; text-decoration: none; color: white; font-size: 16px; font-weight: bold; text-align: center; background-color: #9C9C9C; border-radius: 5px;}
</style>
</head>
<body>
	<div class="container">
		<div class="container-info-bar">
			<div class="grouplist-title">나의 그룹</div>
		</div>
		<div class="group-list-bg">
		
		
			<c:if test="${list != null}">
				<table class="group-list">
					<thead>
						<tr>
							<th>그룹명</th>
							<th class="text-center">공부 시간</th>
							<th class="text-center">인원</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="group">
							<tr class="group-info">
								<td class="group-title">
									<c:url value="/group/home" var="url">
										<c:param name="groupNum" value="${group.go_num}"/>
									</c:url>
									<a href="${url}">${group.go_name}</a>
								</td>
								<td class="group-time text-center">
									<c:choose>
										<c:when test="${group.go_time < 360}">0시간</c:when>
										<c:otherwise>${group.go_time % 360 }시간</c:otherwise>
									</c:choose>
								</td>
								<td class="text-center">${group.go_member_count }명</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				페이지네이션 추가 필요
			</c:if>
				
			<c:if test="${list == null }">
				<div class="no-list-page">
					<div>가입한 그룹이 없습니다.</div>
					<a href="<c:url value="/"/>">모집공고 보러 가기</a>
					 링크 필요
				</div>
				
			</c:if>
			
			
			
		</div>
	</div>
</body>
</html>