<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/profile.css"/>">
</head>
<body>
	<div>
		<div class="profile-label-box">
			<label class="profile-label">
				<img alt="프로필" src="<c:url value="/resources/img/basic_profile.png"/>">
			</label>
		</div>
		<div class="profile-nickname">${member.me_nickname}</div>
		<div class="profile-joindate-box">
			<span class="profile-datetext">가입일 : </span>
			<fmt:formatDate value="${member.me_date}" pattern="yyyy-MM-dd" /> 
		</div>
		<div class="degree-box">
			<div class="profile-degree">${member.me_degree }</div>		
			<progress class="degree-bar" id="degree-bar" value="36.5" min="0" max="100"></progress>
		</div>
	</div>
	<div class="profile">
		<form action="<c:url value="/profile/update"/>" method = "post">
			<input type="hidden" name="me_id" value="${member.me_id }"/>
			<h3 class="profile-title">프로필</h3>
			<ul class="profile-list">
				<li class="profile-listItem">
					<label for="me_interests" class="inputbox-lableText">관심 분야</label>
					<c:if test="${member.me_id == user.me_id}">
						<input type="text" name="me_interests" id="me_interests" class="inputbox-input" value="${member.me_interests}">
					</c:if>
					<c:if test="${member.me_id != user.me_id}">
						<input type="text" class="inputbox-input" readonly value="${member.me_interests}" >
					</c:if>
				</li>
				<li class="profile-listItem">
					<label for="me_preferloc" class="inputbox-lableText">선호 지역</label>
					<c:if test="${member.me_id == user.me_id}">
						<input type="text" name="me_preferloc" id="me_preferloc" class="inputbox-input" value="${member.me_preferloc}">
					</c:if>
					<c:if test="${member.me_id != user.me_id}">
						<input type="text" class="inputbox-input" readonly value="${member.me_preferloc}">
					</c:if>
				</li>
			</ul>
			<ul class="profile-list">
				<li class="profile-listItem">
					<label for="me_prefertime" class="inputbox-lableText">선호 시간</label>
					<c:if test="${member.me_id == user.me_id}">
						<input type="text" name="me_prefertime" id="me_prefertime" class="inputbox-input" value="${member.me_prefertime}">
					</c:if>
					<c:if test="${member.me_id != user.me_id}">
						<input type="text" class="inputbox-input" readonly value="${member.me_prefertime}">
					</c:if>
				</li>
				<li class="profile-listItem">
					<label for="me_onoff" class="inputbox-lableText">온/오프라인</label>
					<c:if test="${member.me_id == user.me_id}">
						<c:if test="${member.me_onoff == '0'}">
							<select name="me_onoff" id="me_onoff" class="inputbox-input">
								<option selected disabled hidden>온라인</option>
								<option value="0">온라인</option>
								<option value="1">오프라인</option>
								<option value="2">온/오프라인</option>
							</select>
				    	</c:if>
						<c:if test="${member.me_onoff == '1'}">
							<select name="me_onoff" id="me_onoff" class="inputbox-input">
								<option selected disabled hidden>오프라인</option>
								<option value="0">온라인</option>
								<option value="1">오프라인</option>
								<option value="2">온/오프라인</option>
							</select>
				    	</c:if>
				    	<c:if test="${member.me_onoff == '2'}">
				    		<select name="me_onoff" id="me_onoff" class="inputbox-input">
				    			<option selected disabled hidden>온/오프라인</option>
								<option value="0">온라인</option>
								<option value="1">오프라인</option>
								<option value="2">온/오프라인</option>
							</select>
				    	</c:if>
					</c:if>
					<c:if test="${member.me_id != user.me_id}">
						<c:if test="${member.me_onoff == '0'}">
							<input type="text" class="inputbox-input" readonly value="온라인">
				    	</c:if>
						<c:if test="${member.me_onoff == '1'}">
							<input type="text" class="inputbox-input" readonly value="오프라인">
				    	</c:if>
						<c:if test="${member.me_onoff == '2'}">
							<input type="text" class="inputbox-input" readonly value="온·오프라인">
				    	</c:if>
					</c:if>
				</li>
			</ul>
			<ul class="profile-list">
				<li class="profile-listItem">
					<label for="me_intro" class="inputbox-lableText">소개</label>
					<c:if test="${member.me_id == user.me_id}">
						<textarea name="me_intro" id="me_intro" class="inputbox-input-intro" rows="10">${member.me_intro}</textarea>
					</c:if>
					<c:if test="${member.me_id != user.me_id}">
						<textarea class="inputbox-input-intro" rows="10" readonly>${member.me_intro}</textarea>
					</c:if>
					
				</li>
			</ul>
			<c:if test="${member.me_id == user.me_id}">
				<div class="profile-btn-area">
					<button class="profile-update-btn" type="submit">수정하기</button>
				</div>
			</c:if>
		</form>
	</div>
	<script type="text/javascript">
		$('.profile-update-btn').click(function() {
			if(!me_interests.value || !me_preferloc.value || !me_prefertime.value || !me_onoff.value || !me_intro.value) {
					alert('모든 항목은 필수 입력 사항입니다.');
					return false;
				}
		})
		
	</script>
</body>
</html>