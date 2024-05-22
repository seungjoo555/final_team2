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
	<form action="<c:url value="/lecture/update"/>" method="post" class="insert-form" enctype="multipart/form-data">
		<div class="second-container">
			<h5>내용, 강의파일만 수정 가능합니다.</h5>
			<hr>
			<section>
				<input type="hidden" name="lect_num" value="${lecture.lect_num}">
				<div class="topicbox">
					<label for="lect_name" class="inputbox-lableText">강의 제목</label> <input
						class="inputbox-input-topic"
						id="lect_name" name="lect_name" value="${lecture.lect_name}" readonly>
				</div>
				<div class="form-row content">
					<textarea rows="10" class="form-control second-box"
						id="lect_intro" name="lect_intro">${lecture.lect_intro}</textarea>
				</div>
				<div class="form-group box-attachment">
					<label>강의파일</label>
					<c:forEach items="${fileList}" var="file">
						<div class="form-control">
							<span>${file.lectFi_ori_name }</span>
							<a href="javascript:void(0);" class="btn-del" data-num="${file.lectFi_num}">&times;</a>
						</div>
					</c:forEach>
					<input type="file" class="form-control" name="file" id="fileInput" multiple/>
				</div>
				<div id="fileList"></div>
				<div class="button-area">
					<button type="button" class="cancel-button">취소</button>
					<button type="submit" class="write-button">수정하기</button>
				</div>
			</section>
		</div>
	</form>
	<script>
		<!-- 취소 버튼 클릭 이벤트-->
		$('.cancel-button').click(function(){
			if(confirm("수정을 취소하고 이전으로 돌아가시겠습니까?")){
				location.href='<c:url value="/lecture/list"/>';
			}
		})
		
		<!-- 작성하기 버튼 클릭 이벤트-->
		$('.write-button').click(function(){
			if(!lect_name.value || !lect_intro.value) {
				alert('제목, 내용은 필수 입력 사항입니다.');
				return false;
			}
		})
		
	</script>
	<script type="text/javascript">
	//서버에 전송하기 전에 제목, 내용 글자수 확인
	$("form").submit(function(){
		let title = $("[name=lect_name]").val();
		if(title.length == 0){
			alert("제목은 1글자 이상 입력해야 합니다.");
			$("[name=lect_name]").focus();
			return false;
		}
		let content = $("[name=lect_intro]").val();
		if(content.length == 0){
			alert("내용은 1글자 이상 입력해야 합니다.");
			$("[name=lect_intro]").focus();
			return false;
		}
	});
	
	$('[name=lect_intro]').summernote({
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
	<!-- 첨부파일 x버튼 구현 -->
	<script type="text/javascript">
	$(".btn-del").click(function(){
		let num = $(this).data("num");
		//input hidden 삭제한 첨부파일 번호를 추가
		$(this).parents(".box-attachment").prepend(`<input type="hidden" name="delNums" value="\${num}">`)
		//클릭한 x버튼의 첨부파일을 삭제
		$(this).parent().remove();
	});
	</script>
</body>
</html>