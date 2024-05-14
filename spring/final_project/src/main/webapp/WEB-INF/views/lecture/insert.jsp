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
				<li class="recruit-listItem">
					<label for="lect_mentIf_me_id" class="inputbox-lableText">작성자 닉네임</label> 
					<input type="text" value="${user.me_nickname}" readonly class="inputbox-input" id="lect_mentIf_me_id" name="lect_mentIf_me_id">
				</li>
				<li class="recruit-listItem">
					<label for="lect_price" class="inputbox-lableText">강의 가격</label> 
					<input type="text" placeholder="강의 적정 가격을 써 주세요." class="inputbox-input" id="lect_price" name="lect_price">
				</li>
			</ul>
			<ul class="recruit-inputList">
				<li class="recruit-listItem"><label for="progCt_name"
					class="inputbox-lableText">강의 분야</label>
					<div class="input-row multi-dropdown not-label">
						<div class="multi-dropdown-box placeholder">
							<!-- <input type="hidden" name="products" id="progCt_name" value="progCt_name" />  -->
							<button type="button" tabindex="-1"
								data-placeholder="모집 분야를 선택해 주세요.">강의 분야를 선택해 주세요.</button>
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
					</div>
				</li>
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
					</div>
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
				<div class="form-group">
				    <input type="file" class="form-control" name="file" id="fileInput" multiple>
				</div>
				<div id="fileList"></div>
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
			
			if(!chkCount.test(lect_price.value)) {
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
	<script type="text/javascript">
	//서버에 전송하기 전에 제목, 내용 글자수 확인
	$("form").submit(function(){
		let title = $("[name=bo_title]").val();
		if(title.length == 0){
			alert("제목은 1글자 이상 입력해야 합니다.");
			$("[name=bo_title]").focus();
			return false;
		}
		let content = $("[name=bo_content]").val();
		if(content.length == 0){
			alert("내용은 1글자 이상 입력해야 합니다.");
			$("[name=bo_content]").focus();
			return false;
		}
	});
	
	$('[name=bo_content]').summernote({
		placeholder : 'Hello Bootstrap 5',
		tabsize : 2,
		height: 400,
		callbacks: {
	 		// 이미지를 업로드할 경우 이벤트를 발생
		   	onImageUpload: function(files, editor, welEditable) {
		   		sendFile(files[0], this);
			},
			// 미디어(이미지 포함)을 삭제할 경우 이벤트를 발생
			onMediaDelete: function ($target, editor, $editable) {
				//이미지 경로를 추출
		    	var deletedImageUrl = $target
		    	.attr('src')
		        .replace("<c:url value='/download'/>","");
				//해당 이미지를 서버에서 삭제해달라고 요청(ajax로)
		     	removeImg(deletedImageUrl)
			}
		}
	});
	
	function sendFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		//첨부파일을 ajax로 보내는 예제		
		$.ajax({
			data: data,
	    	type: "post",
	    	url: '<c:url value="/img/upload"/>',
	 		cache : false,
	    	contentType : false,	
	    	processData : false,
	    	success : function(data){
	    		console.log(data);
	    		$(editor).summernote('editor.insertImage', "<c:url value='/download'/>"+data.url);
	    	}
		});
	}
	//업로드된 이미지를 삭제하는 함수
	function removeImg(imageName){
		data = new FormData()
		data.append('file', imageName)
		$.ajax({
	    	data: data,
	      	type: 'POST',
	      	url: '<c:url value="/img/delete"/>',
	      	contentType: false,
	      	processData: false,
	      	success : function(data){
	    		console.log(data);
	      }
	  })
	}
	
	const dataTransfer = new DataTransfer();
	
	$("#fileInput").change(function(){
	    let fileArr = document.getElementById("fileInput").files;
	    let fileList = document.getElementById('fileList');
	    
	    if(fileArr != null && fileArr.length > 0){
	
	        // Add new files to dataTransfer
	        for(let i = 0; i < fileArr.length; i++){
	            dataTransfer.items.add(fileArr[i]);
	        }
	    }
	    
	    fileList.innerHTML = '';
	    
	    for (let i = 0; i < dataTransfer.files.length; i++) {
	        let listItem = document.createElement('div');
	    	let deleteButton = document.createElement('button');
	    	deleteButton.type = "button";
	    	deleteButton.setAttribute('data-index', i); // 삭제할 파일의 인덱스 저장
	        
	        // 파일 이름 표시
	        listItem.textContent = dataTransfer.files[i].name;
	        // 삭제 버튼 생성 및 속성 설정
	        deleteButton.textContent = '삭제';
	        deleteButton.classList.add('remove_button');
	        
	        
	        listItem.appendChild(deleteButton);
	        fileList.appendChild(listItem);
	    }
	
	    // Update file input with new files
	    document.getElementById("fileInput").files = dataTransfer.files;
	    console.log("dataTransfer =>", dataTransfer.files);
	    console.log("input Files =>", document.getElementById("fileInput").files);
	    
	});
	
	$("#fileList").on("click", ".remove_button", function(event){
		let fileList = document.getElementById('fileList');
		
	    if(event.target.className=='remove_button'){
	        //console.log(event.target.dataset.index )
	        targetFile = event.target.dataset.index;
	        console.log(targetFile);
	    	dataTransfer.items.remove(targetFile);
	    	//fileList.removeChild(fileList.childNodes[targetFile]);
	    }
	    
	    fileList.innerHTML = ''; // 이전 목록 지우기
	    
	    for (let i = 0; i < dataTransfer.files.length; i++) {
	    	let listItem = document.createElement('div');
	    	let deleteButton = document.createElement('button');
	    	deleteButton.type = "button";
	    	deleteButton.setAttribute('data-index', i); // 삭제할 파일의 인덱스 저장
	        // 파일 이름 표시
	        listItem.textContent = dataTransfer.files[i].name;
	        // 삭제 버튼 생성 및 속성 설정
	        deleteButton.textContent = '삭제';
	        deleteButton.classList.add('remove_button'); // file-del 클래스 추가
	        
	        listItem.appendChild(deleteButton);
	        fileList.appendChild(listItem);
	    }
	
	    // Update file input with new files
	    document.getElementById("fileInput").files = dataTransfer.files;
	    console.log("dataTransfer =>", dataTransfer.files);
	    console.log("input Files =>", document.getElementById("fileInput").files);
	    
	});
	</script>
</body>
</html>