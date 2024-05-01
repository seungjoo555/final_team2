<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/adminreport.css"/>" >
<title>관리자 - 신고관리</title>

</head>
<body>
<div class="container">	
	<h1>신고 관리</h1>
	<div class="admin-header">
		<form action="<c:url value="/board/list"/>" method="get">
			<div class="input-group mb-3">
				<div class="select-box">
					<select name="type" class="form-control">
						<option value="all" <c:if test="${pm.cri.type == 'all'}">selected</c:if>>전체</option>
						<option value="recruit" <c:if test="${pm.cri.type == 'recruit'}">selected</c:if>>모집공고</option>
						<option value="mentoring" <c:if test="${pm.cri.type == 'mentoring'}">selected</c:if>>멘토링</option>
						<option value="lecture" <c:if test="${pm.cri.type == 'lecture'}">selected</c:if>>강의</option>
						<option value="member" <c:if test="${pm.cri.type == 'member'}">selected</c:if>>유저</option>
						<option value="post" <c:if test="${pm.cri.type == 'post'}">selected</c:if>>게시글</option>
						<option value="comment" <c:if test="${pm.cri.type == 'comment'}">selected</c:if>>댓글</option>
					</select> 
				</div>
				<div class="count-report">신고된 게시글 : </div>
				<div class="check-view-box">
					<input type="checkbox" id="check-view">
					<label for="check-view" > <span>미처리 된 신고 항목만 보기</span></label>
				</div>
			</div>
		</form>
	</div>
		<table class="table table-hover">
			<thead>
				<tr>
			        <th></th>
			        <th>신고횟수</th>
			        <th>신고 대상 타입</th>
			        <th>신고 대상</th>
			        <th>신고상세</th>
			        <th>처리상태</th>
			      </tr>
			</thead>
			<tbody>
			<!-- 
				<c:forEach items="" var="">
				 -->
					<tr>
						<td></td>
						<td>1</td>
						<td>x아ㅣㅂ</td>
						<td>세ㅐ당</td>
						<td>상세</td>
						<td>상태</td>
					</tr>
					<!-- 
				</c:forEach>
				 -->
			</tbody>
		</table>
	
	<!-- 페이지네이션 -->


</div>


</body>
</html>