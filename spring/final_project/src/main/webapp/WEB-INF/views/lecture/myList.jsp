<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>내가 구매한 강의 리스트</h1>

<table class="table table-hover">
	<thead>
		<tr>
			<th>강의 제목</th>
			<th>강의 등록멘토</th>
			<th>강의 가격</th>
			<th>강의 게시일</th>
			<th>강의 업데이트일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="lecture">
			<tr>
				<td>
					<c:url value="/lecture/detail" var="url">
						<c:param name="lectNum" value="${lecture.lect_num}"/>
					</c:url>
					<a href="${url}">${lecture.lect_name}</a>
				</td>
				<td>
					<c:url value="/lecture/list" var="url">
						<c:param name="type" value="writer"/>
						<c:param name="search" value="${lecture.lect_mentIf_me_id}"/>
					</c:url>
					<a href="${url}">${lecture.lect_me_nickname}</a>
				</td>
				<td>${lecture.lect_price}</td>
				<td>${lecture.lect_posting}</td>
				<td>${lecture.lect_update}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>