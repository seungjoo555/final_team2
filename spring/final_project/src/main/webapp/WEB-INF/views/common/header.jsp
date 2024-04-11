<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
	<nav class="navbar navbar-expand-sm bg-success navbar-light">
		<div class="container-fluid">
			<h1>
				<a class="navbar-brand" href="/">
					<img alt="LOGO" src="<c:url value="/resources/img/somany.png"/>">
				</a>
			</h1>
			<ul class="navbar-left">
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="#" />">스터디/프로젝트</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="#" />">멘토링</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="#" />">커뮤니티</a>
				</li>
			</ul>
			<form class="d-flex" action="<c:url value='/totalSearchList?' />"
				method="get">
				<input class="form-control" type="text" placeholder="검색어를 입력하세요"
					name="totalsearch" id="totalsearch"> <input type="hidden"
					name="page" value="1">
				<button type="submit" class="btn btn-outline-dark"
					id="totalsearch-btn">
					<img alt="검색" src="/team1/images/search_icon.svg">
				</button>
			</form>

			<ul class="navbar-right">
				<c:if test="${user == null}">
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="#" />">로그인</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="#" />">회원가입</a></li>
				</c:if>
				<c:if test="${user != null}">
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="" />">마이페이지</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="#" />">로그아웃</a></li>
				</c:if>
			</ul>
		</div>
	</nav>
</header>