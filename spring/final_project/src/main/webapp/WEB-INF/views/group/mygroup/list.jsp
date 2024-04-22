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
										<c:when test="${group.go_time < 3600}">0시간</c:when>
										<c:when test="${group.go_time / 3600 > 999}">999+시간</c:when>
										<c:otherwise>${Math.round(group.go_time / 3600)}시간</c:otherwise>
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
				</div>
				
			</c:if>
			
			
			
		</div>
	</div>
</body>
</html>