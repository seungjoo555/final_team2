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
		<div class="recruit_topic">${recruit.recu_topic}</div>
		<div class="recruit_userAndDate">
			<div class="recruit_user">${groupKing.gome_me_id}</div>
			<!-- <div class="recruit_regDate">날짜</div> -->
		</div>
		<hr>		
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_type" class="inputbox-lableText">모집 구분</label>
				<span id="recu_type" class="inputbox-input">${recruit.recu_type == 1? "스터디":"프로젝트"}</span>
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
						<c:when test="${recruit.recu_online == 1}">온라인</c:when>
						<c:when test="${recruit.recu_online == 2}">오프라인</c:when>
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
				<span id="recu_interview" class="inputbox-input">${recruit.recu_interview == 0 ? "아니요":"예"}</span>
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
</body>
</html>