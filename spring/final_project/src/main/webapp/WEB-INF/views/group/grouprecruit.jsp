<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/dropdown.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/multi.dropdown.js"/>"></script>
</head>
<body>
	<form action="<c:url value="/group/grouprecruit"/>" method="post" class="insert-form">
		<div class="first-container">
			<h5>1. 프로젝트 기본 정보를 입력해 주세요.</h5>
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
					<input type="date" min="today" class="inputbox-input" id="recu_due" name="recu_due">
				</li>
			</ul>
			<ul class="recruit-inputList">
				<li class="recruit-listItem">
					<label for="recu_preferred" class="inputbox-lableText">선호 자격</label> 
					<input type="text" placeholder="끈기있는 분이면 좋겠습니다." class="inputbox-input" id="recu_preferred" name="recu_preferred"></li>
				<li class="recruit-listItem">
					<label for="recu_interview" class="inputbox-lableText">면접 여부</label> 
					<select id="recu_interview" class="inputbox-input" name=recu_interview>
						<option value="0">예</option>
						<option value="1">아니오</option>
					</select>
				</li>
			</ul>
			<ul class="recruit-inputList">
				<li class="recruit-listItem"><label for="progCt_name"
					class="inputbox-lableText">모집 분야</label>
					<div class="input-row multi-dropdown not-label">
						<div class="multi-dropdown-box placeholder">
							<!-- <input type="hidden" name="products" id="progCt_name" value="progCt_name" />  -->
							<button type="button" tabindex="-1"
								data-placeholder="모집 분야를 선택해 주세요.">모집 분야를 선택해 주세요.</button>
							<input type="hidden" name="progCtList" />
							<div class="dropdown-list">
								<ul>
									<c:forEach items="${categoryList}" var="progCt">
										<li><label for="progCate_${progCt.progCt_num}"> <input
												type="checkbox" class="multi-dropdown-item"
												onClick="countCate_ck(this)" value="${progCt.progCt_num}"
												id="progCate_${progCt.progCt_num}" name="toCt_progCt" />
												<p>${progCt.progCt_name}</p>
										</label></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div></li>
				<li class="recruit-listItem"><label for="lang_name"
					class="inputbox-lableText">사용 언어</label>
					<div class="input-row multi-dropdown not-label">
						<div class="multi-dropdown-box placeholder">
							<input type="hidden" name="progLangList" />
							<button type="button" tabindex="-1"
								data-placeholder="사용 언어를 선택해 주세요.">사용 언어를 선택해 주세요.</button>
							<div class="dropdown-list">
								<ul>
									<c:forEach items="${languageList}" var="progLang">
										<li><label for="progCate${progLang.lang_num}"> <input
												type="checkbox" class="multi-dropdown-item"
												onClick="countLang_ck(this)" value="${progLang.lang_num}"
												id="progCate${progLang.lang_num}" name="toLg_lang" />
												<p>${progLang.lang_name}</p>
										</label></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div></li>
			</ul>
		</div>
		<div class="second-container">
			<h5>2. 프로젝트에 대해 소개해 주세요.</h5>
			<hr>
			<section>
				<div class="topicbox">
					<label for="recu_topic" class="inputbox-lableText">주제</label> <input
						placeholder="프로젝트 주제를 작성하세요." class="inputbox-input-topic"
						id="recu_topic" name="recu_topic">
				</div>
				<div class="form-row content">
					<textarea rows="10" class="form-control second-box"
						id="recu_content" name="recu_content"></textarea>
				</div>
				<div class="button-area">
					<button type="button" class="cancel-button">취소</button>
					<button type="submit" class="write-button">작성하기</button>
				</div>
			</section>
		</div>
	</form>
	<script>
		$('#recu_content').summernote({
		  placeholder: '내용을 입력하세요.',
		  tabsize: 2,
		  height: 400
		});
		
		<!-- 취소 버튼 클릭 이벤트-->
		$('.cancel-button').click(function(){
			if(confirm("작성을 취소하고 이전으로 돌아가시겠습니까?")){
				location.href='<c:url value="/group/grouplist"/>';
			}
		})
		
		<!-- 작성하기 버튼 클릭 이벤트-->
		$('.write-button').click(function(){
			if(!recu_type.value || !recu_count.value || !recu_online.value || !recu_target.value || !recu_required.value 
				|| !recu_due.value || !recu_preferred.value || !recu_interview.value || !recu_topic.value || !recu_content.value) {
				alert('모든 항목은 필수 입력 사항입니다.');
				return false;
			}
			
			var chkCount = /^[0-9]*$/;
			
			if(!chkCount.test(recu_count.value)) {
				alert("모집 인원은 숫자만 작성 가능합니다.")
				return false;
			}
			
			if(confirm("입력하신 내용으로 모집 공고를 올리시겠습니까?")) {
				location.href='<c:url value="/group/grouplist"/>';
			} else {
				return false;
			}
		})
		
		function countCate_ck(obj) {
			var chkbox = document.getElementsByName("toCt_progCt");
			var chkCnt = 0;
			
			for (var i = 0; i < chkbox.length; i++) {
				if(chkbox[i].checked) {
					chkCnt++;
				}
			}
			
			if(chkCnt > 3) {
				alert("모집 분야는 최대 3개까지 선택 가능합니다.");
				obj.checked = false;
				return false;
			}
		}
		
		function countLang_ck(obj) {
			var chkbox = document.getElementsByName("toLg_lang");
			var chkCnt = 0;
			
			for (var i = 0; i < chkbox.length; i++) {
				if(chkbox[i].checked) {
					chkCnt++;
				}
			}
			
			if(chkCnt > 3) {
				alert("사용 언어는 최대 3개까지 선택 가능합니다.");
				obj.checked = false;
				return false;
			}
		}
		
		<!-- 오늘 이전 날짜 선택 불가-->
		document.getElementById('recu_due').min = new Date().toISOString().substring(0, 10);
		console.log(recu_due);
		
	</script>
</body>
</html>