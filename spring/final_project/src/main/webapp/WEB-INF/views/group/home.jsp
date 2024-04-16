<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.menu-bar{margin: 15px 0; }

	.group-category{display: inline-block; margin-right: 10px; }
	.group-category-insert{display:flex; float: right;}
	
	.group-list{width:250px; height:300px; border: 1px solid black; border-radius: 30px; list-style : none;}
	li{list-style : none;   color: inherit; }
	.group-list-item-schedule > p{display: inline-block; }
	.groupSituation{display:flex; float: right;}
	.group-list-item-memberInfo > div{display: inline-block; }
	.border-line{border: 1px solid black;height: 1px; width: 180px;'}
</style>

</head>
<body>
<div class="container">
	<!-- 메뉴바 -->
	<section class="menu-bar">
		<div class="group-category">
			<span class="group-category-item all">전체</span>
		</div>
		<div class="group-category">
			<span class="group-category-item study">스터디</span>
		</div>
		<div class="group-category">
			<span class="group-category-item project">프로젝트</span>
		</div>
		<div class="group-category group -category-insert">
			<a class="btn-outline-success insert" href="<c:url value="/recruit/insert"/>">모집글 작성</a>
		</div>
	</section>
	<!-- 리스트 -->
	<c:forEach  items="${list }" var="greoup">
	
	</c:forEach>
	<ul class="group-list">
		<a class="group-list-item"  href="<c:url value="/group/home"/>">
			<li>
				<!-- 프로젝트/스터디 구분 -->
				<div class="group-list-item-category" >
					<div>프로젝트</div>
				</div>
				<!-- 마감일 -->
				<div class="group-list-item-schedule">
					<p>마감일 |</p>
					<p>2023.04.16</p>
				</div>
				<!-- 그룹 모집 제목 -->
				<h3 class="group-list-item-title">제목</h3>
				<!-- 분야 리스트 -->
				<ul class="group-list-item-contentList">
					<li>분야</li>
				</ul>
				<!-- 사용언어 -->
				<ul class="group-list-item-languageList">
					<li>언어</li>
				</ul>
				<!-- 구분선 -->
				<div class="border-line"></div>
				<div class="group-list-item-memberInfo" >
					<div class="memberNickname">닉네임</div>
					<div class="groupSituation">모집현황</div>
				</div>
			</li>
		</a>
	</ul>
	
</div>

</body>
</html>