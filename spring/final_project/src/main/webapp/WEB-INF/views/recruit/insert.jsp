<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
</head>
<body>
	<div class="container">
		<form action="<c:url value="/recruit/insert"/>" method = "post" class="insert-form">
			<div>
				<h5>1. 프로젝트 기본 정보를 입력해 주세요.</h5>
				<hr>		
			</div>
			<ul>
				<li>
					<label for="recu_type">모집 구분</label>
					<select name="recu_type" id="recu_type">
						<option value="0">스터디</option>
						<option value="1">프로젝트</option>
					</select>
				</li>
				<li>
					<label for="recu_count">모집 인원</label>
					<input type="text" placeholder="본인 포함한 인원 수를 숫자만 입력하세요." id="recu_count" name="recu_count">
				</li>
			</ul>
			<ul>
				<li>
					<label for="recu_online">온·오프라인 여부</label>
					<select name="recu_online" id="recu_online">
						<option value="0">온라인</option>
						<option value="1">오프라인</option>
						<option value="2">온/오프라인</option>
					</select>
				</li>
				<li>
					<label for="recu_target">그룹 목적</label>
					<input type="text" placeholder="포트폴리오 제출용, 공모전 참여 등" id="recu_target" name="recu_target">
				</li>
			</ul>
			<ul>
				<li>
					<label for="recu_required">필수 자격</label>
					<input type="text" placeholder="JavaScript 및 Spring" id="recu_required" name="recu_required">
				</li>
				<li>
					<label for="recu_due">모집 마감일</label>
					<input type="date" id="recu_due" name="recu_due">
				</li>
			</ul>
			<ul>
				<li>
					<label for="recu_preferred">선호 자격</label>
					<input type="text" placeholder="끈기있는 분이면 좋겠습니다." id="recu_preferred" name="recu_preferred">
				</li>
				<li>
					<label for="recu_interview">면접 여부</label>
					<select id="recu_interview" name=recu_interview>
						<option value="0">예</option>
						<option value="1">아니오</option>
					</select>
				</li>
			</ul>
			<div>
				<h5>2. 프로젝트에 대해 소개해 주세요.</h5>
				<hr>
				<section>
					<div>
						<label for="recu_topic">주제</label>
						<input placeholder="프로젝트 주제를 작성하세요." id="recu_topic" name="recu_topic">
					</div>
					<div class="form-row content">
						<textarea rows="10" class="form-control second-box" id="recu_content" name="recu_content" ></textarea>
					</div>
					<div>
						<button type="button">취소</button>
						<button>작성하기</button>
					</div>
				</section>
			</div>
		</form>		
	</div>
	<script>
		$('#recu_content').summernote({
		  placeholder: '내용을 입력하세요.',
		  tabsize: 2,
		  height: 400
		});
	</script>
</body>
</html>