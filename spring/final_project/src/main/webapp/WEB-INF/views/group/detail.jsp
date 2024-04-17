<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
</head>
<body>
	<div class="first-container">
		<div class="recruit_topic">제목 공간</div>
		<div class="recruit_userAndDate">
			<div class="recruit_user">아이디</div>
			<div class="recruit_regDate">날짜</div>
		</div>
		<hr>		
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_type" class="inputbox-lableText">모집 구분</label>
				<select name="recu_type" id="recu_type" class="inputbox-input">
					<option value="0">스터디</option>
					<option value="1">프로젝트</option>
				</select>
			</li>
			<li class="recruit-listItem">
				<label for="recu_count" class="inputbox-lableText">모집 인원</label>
				<input type="text" placeholder="본인 포함한 인원 수를 숫자만 입력하세요." class="inputbox-input" id="recu_count" name="recu_count">
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_online" class="inputbox-lableText">온·오프라인 여부</label>
				<select name="recu_online" id="recu_online" class="inputbox-input">
					<option value="0">온라인</option>
					<option value="1">오프라인</option>
					<option value="2">온/오프라인</option>
				</select>
			</li>
			<li class="recruit-listItem">
				<label for="recu_target" class="inputbox-lableText">그룹 목적</label>
				<input type="text" placeholder="포트폴리오 제출용, 공모전 참여 등" class="inputbox-input" id="recu_target" name="recu_target">
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_required" class="inputbox-lableText">필수 자격</label>
				<input type="text" placeholder="JavaScript 및 Spring" class="inputbox-input" id="recu_required" name="recu_required">
			</li>
			<li class="recruit-listItem">
				<label for="recu_due" class="inputbox-lableText">모집 마감일</label>
				<input type="date" class="inputbox-input" id="recu_due" name="recu_due">
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_preferred" class="inputbox-lableText">선호 자격</label>
				<input type="text" placeholder="끈기있는 분이면 좋겠습니다." class="inputbox-input" id="recu_preferred" name="recu_preferred">
			</li>
			<li class="recruit-listItem">
				<label for="recu_interview" class="inputbox-lableText">면접 여부</label>
				<select id="recu_interview" class="inputbox-input" name=recu_interview>
					<option value="0">예</option>
					<option value="1">아니오</option>
				</select>
			</li>
		</ul>
	</div>
	<div class="second-container">
		<h4>프로젝트 소개</h4>
		<hr>
		<section>
			<div class="form-row content">
				<textarea rows="10" class="form-control second-box" id="recu_content" name="recu_content" ></textarea>
			</div>
		</section>
	</div>
</body>
</html>