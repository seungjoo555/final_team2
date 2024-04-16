<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
	
</head>
<body>
	<form action="<c:url value="/post/insert"/>" method = "post" enctype ="multipart/form-data" class="insert-form">
		<div class="container">
			<div>
				<h5>1. 프로젝트 기본 정보를 입력해 주세요.</h5>
				<hr>		
			</div>
			<ul>
				<li>
					<label>모집 구분</label>
					<select>
						<option>스터디</option>
						<option>프로젝트</option>
					</select>
				</li>
				<li>
					<label>모집 인원</label>
					<input type="text" placeholder="숫자만 입력하세요.">
				</li>
			</ul>
			<ul>
				<li>
					<label>온·오프라인 여부</label>
					<select>
						<option>온라인</option>
						<option>오프라인</option>
						<option>온/오프라인</option>
					</select>
				</li>
				<li>
					<label>그룹 목적</label>
					<input type="text" placeholder="포트폴리오 제출용, 공모전 참여 등">
				</li>
			</ul>
			<ul>
				<li>
					<label>필수 자격</label>
					<input type="text" placeholder="JavaScript 및 Spring">
				</li>
				<li>
					<label>모집 마감일</label>
					<input type="date">
				</li>
			</ul>
			<ul>
				<li>
					<label>선호 자격</label>
					<input type="text" placeholder="끈기있는 분이면 좋겠습니다.">
				</li>
				<li>
					<label>면접 여부</label>
					<select>
						<option>예</option>
						<option>아니오</option>
					</select>
				</li>
			</ul>
			<div>
				<h5>2. 프로젝트에 대해 소개해 주세요.</h5>
				<hr>
				<section>
					<div>
						<label>주제</label>
						<input placeholder="프로젝트 주제를 작성하세요.">
					</div>
					<div class="form-row content">
						<textarea rows="10" class="form-control second-box" id="content" name="content" ></textarea>
					</div>
					<div>
						<button>취소</button>
						<button>작성하기</button>
					</div>
				</section>
			</div>
		</div>
	</form>		
	<script>
		$('#content').summernote({
		  placeholder: '내용을 입력하세요.',
		  tabsize: 2,
		  height: 400
		});
	</script>
</body>
</html>