<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
</head>
<body>
	<div class="first-container">
		<a href="<c:url value="/group/home"/>">
			<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" color="808080" 
				cursor="pointer" height="30" width="30" xmlns="http://www.w3.org/2000/svg" style="color: rgb(128, 128, 128);">
				<path d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path>
			</svg>
		</a>
		<div class="recruit_topic">${recruit.recu_topic}(${recruit.recu_state == 1 ? "모집중":"모집 완료"})</div>
		<div class="recruit_userAndDate">
			<div class="recruit_user">${groupKing}</div>
			<!-- <div class="recruit_regDate">날짜</div> -->
		</div>
		<hr>		
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_type" class="inputbox-lableText">모집 구분</label>
				<span id="recu_type" class="inputbox-input">${recruit.recu_type == 0? "스터디":"프로젝트"}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_count" class="inputbox-lableText">모집 인원</label>
				<span class="inputbox-input" id="recu_count">${recruit.recu_count}명</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_online" class="inputbox-lableText">온·오프라인 여부</label>
				<span id="recu_online" class="inputbox-input">
					<c:choose>
						<c:when test="${recruit.recu_online == 0}">온라인</c:when>
						<c:when test="${recruit.recu_online == 1}">오프라인</c:when>
						<c:otherwise>온/오프라인 병행</c:otherwise>
					</c:choose>
				</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_target" class="inputbox-lableText">그룹 목적</label>
				<span class="inputbox-input" id="recu_target">${recruit.recu_target}</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_required" class="inputbox-lableText">필수 자격</label>
				<span class="inputbox-input" id="recu_required">${recruit.recu_required}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_due" class="inputbox-lableText">모집 마감일</label>
				<span class="inputbox-input" id="recu_due">
					<fmt:formatDate value="${recruit.recu_due}" pattern="yyyy-MM-dd" />
				</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_preferred" class="inputbox-lableText">선호 자격</label>
				<span class="inputbox-input" id="recu_preferred">${recruit.recu_preferred}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_interview" class="inputbox-lableText">면접 여부</label>
				<span id="recu_interview" class="inputbox-input">${recruit.recu_interview == 1 ? "아니요":"예"}</span>
			</li>
		</ul>
		<div class="recruit-inputList">
			<li class="recruit-cateLang">
				<span class="recruit-spancateLang">모집 분야</span>
				<ul class="recruit-cateLangList">
					<c:forEach items="${totalCategory}" var="cate">
						<li class="recruit-position">${cate.toCt_progCt_name}</li>
					</c:forEach>
				</ul>
			</li>
			<li class="recruit-cateLang">
				<span class="recruit-spancateLang">사용 언어</span>
				<ul class="recruit-cateLangList">
					<c:forEach items="${totalLanguage}" var="lang">
						<li class="recruit-position">${lang.toLg_lang_name}</li>
					</c:forEach>
				</ul>
			</li>
		</div>
	</div>
	<div class="second-container">
		<h4>프로젝트 소개</h4>
		<hr>
		<section>
			<div class="form-row content">
				<textarea rows="15" class="form-control second-box" id="recu_content">${recruit.recu_content}</textarea>
			</div>
		</section>
	</div>
	<a class="btn btn-success col-12 mt-5" href="<c:url value="#"/>">신청하기</a>
</body>
</html>