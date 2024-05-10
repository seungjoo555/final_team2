<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/dropdown.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/multi.dropdown.js"/>"></script>
</head>
<body>
	<form action="<c:url value="/lecture/insert"/>" method="post"
		class="insert-form">
		<div class="first-container">
			<h5>1. 강의 기본 정보 설정</h5>
			<hr>
			<ul class="recruit-inputList">
				<li class="recruit-listItem"><label for="progCt_name"
					class="inputbox-lableText">강의 분야</label>
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
					class="inputbox-lableText">사용 언어,스킬</label>
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
			<ul class="recruit-inputList">
				<li class="recruit-listItem">
					<label for="lect_mentIf_me_id" class="inputbox-lableText">작성자 닉네임</label> 
					<input type="text" value="${user.me_nickname}" readonly class="inputbox-input" id="lect_mentIf_me_id" name="lect_mentIf_me_id">
				</li>
				<li class="recruit-listItem">
					<label for="lect_price" class="inputbox-lableText">강의 가격</label> 
					<input type="text" placeholder="강의 적정 가격을 써 주세요." class="inputbox-input" id="lect_price" name="lect_price">
				</li>
			</ul>
		</div>
		<div class="second-container">
			<h5>2. 강의에 대해 소개해 주세요.</h5>
			<hr>
			<section>
				<div class="topicbox">
					<label for="lect_name" class="inputbox-lableText">강의 제목</label> <input
						placeholder="제목을 작성하세요." class="inputbox-input-topic"
						id="lect_name" name="lect_name">
				</div>
				<div class="form-row content">
					<textarea rows="10" class="form-control second-box"
						id="lect_intro" name="lect_intro"></textarea>
				</div>
				<div class="button-area">
					<button type="button" class="cancel-button">취소</button>
					<button type="submit" class="write-button">작성하기</button>
				</div>
			</section>
		</div>
	</form>
	<script>
		$('#lect_intro').summernote({
		  placeholder: '내용을 입력하세요.',
		  tabsize: 2,
		  height: 400
		});
		
		<!-- 취소 버튼 클릭 이벤트-->
		$('.cancel-button').click(function(){
			if(confirm("작성을 취소하고 이전으로 돌아가시겠습니까?")){
				location.href='<c:url value="/lecture/list"/>';
			}
		})
		
		<!-- 작성하기 버튼 클릭 이벤트-->
		$('.write-button').click(function(){
			if(!lect_mentIf_me_id.value || !lect_price.value || !lect_name.value || !lect_intro.value) {
				alert('모든 항목은 필수 입력 사항입니다.');
				return false;
			}
			
			let chkCount = /^[0-9]*$/;
			
			if(!chkCount.test(recu_count.value)) {
				alert("강의 가격은 숫자만 작성 가능합니다.")
				return false;
			}
			
			if(confirm("입력하신 내용으로 강의를 등록 하시겠습니까?")) {
				location.href='<c:url value="/lecture/insert"/>';
			}
		})
		
		function countCate_ck(obj) {
			let chkbox = document.getElementsByName("toCt_progCt");
			let chkCnt = 0;
			
			for (let i = 0; i < chkbox.length; i++) {
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
			let chkbox = document.getElementsByName("toLg_lang");
			let chkCnt = 0;
			
			for (let i = 0; i < chkbox.length; i++) {
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
		
	</script>
</body>
</html>