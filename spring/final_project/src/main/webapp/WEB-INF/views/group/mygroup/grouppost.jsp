<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- mygroup.css -->
<link rel="stylesheet" href="<c:url value="/resources/css/mygroup.css"/>">

</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${group == null }">
			<div class="not-group-member">
				<div>가입한 그룹이 아닙니다.</div>
				<a href="<c:url value="/"/>">홈으로 가기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container-info-bar">
				<div class="float-left group-title">${group.go_name}</div>
				<div class="float-left">그룹 게시판</div>
			</div>
			<div class="group-post-input">
				<textarea class="input" cols="5"></textarea>
				<button class="submit float-right">등록</button>
			</div>
			<div class="post-list-bg">
				<!-- 게시글 불러오기 script로 리스트 출력됨 -->
			</div>
			<div class="more-post">
				<!-- 게시글 더 보기 버튼 -->
			</div>
		</c:otherwise>
</c:choose> 
</div>

<!-- 게시글 불러오기 script -->
<script type="text/javascript">
let cri = {
		page : 1,
		search : ${group.go_num}
}

getGroupPostList(cri);

function getGroupPostList(cri){
	let str = '';
	console.log(cri)
	
	$.ajax({
		url : '<c:url value="/group/post/list"/>',
		method : "post",
		data : JSON.stringify(cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function(data){
			if(data.list.length == 0){
				$(".post-list-bg").append(`<div style="text-align: center">등록된 그룹 게시글이 없습니다.</div>`)
			}
			
			for(post of data.list){
				let btns = '';
				//현재 로그인한 유저와 댓글을 쓰기 위한 유저의 아이디가 동일하거나 댓글 관리 권한이 있다면 수정,삭제 버튼이 나타나고 아니라면 나타나지 않음
				if('${user.me_id}' == post.gopo_gome_me_id){	
				btns +=
					`
					<div class="post-manage-btn-group">
						<a class="post-edit-btn" data-num="\${post.gopo_num}">수정</a>
						<a class="post-delete-btn" data-num="\${post.gopo_num}">삭제</a>
					</div>
					`
				}
				
				str +=
					`
					<div>
						<div class="post-info">
							<div class="writer float-left">\${post.nickname}</div>
							<div class="time float-left">\${post.time_ago}</div>
							<div class="float-right">\${post.gopo_date}</div>
						</div>
						<div class="post-content">
							\${post.gopo_content }
						</div>
							\${btns}
					</div>
					`;
				}
				
				$(".post-list-bg").append(str); // 페이지 넘김이 아니라 아래에 내용 추가
				
				if(data.pm.next){
					$(".more-post").html('<button class="more-post-btn">더 보기</button>')
				}else{
					$(".more-post").html('마지막 게시글 입니다.')
				}
			}, 
			error : function(a, b, c){
				
		}
	});
}
</script>

<!-- 게시글 더 보기 script -->
<script type="text/javascript">
let page = 1;

$(document).on("click",".more-post-btn", function(){
	page += 1;
	
	let cri = {
			page : ''+page,
			search : ${group.go_num}
	}

	getGroupPostList(cri);
})
</script>

<!-- 게시글 작성 script -->
<script type="text/javascript">
$(".group-post-input .submit").click(function(){
	if(!${group.go_update}){
		alert('그룹이 얼려진 상태입니다. 리더가 그룹 얼리기를 해제한 후 이용할 수 있습니다.')
		return;
	}
	
	 $.ajax({
			async : false, 
			url : '<c:url value="/group/post/insert"/>', 
			type : 'post', 
			data : {
				num : ${group.go_num},
				content: $(".group-post-input .input").val(),
				writer: "${user.me_id}"
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data == "ok"){
					alert("게시글이 등록되었습니다.")
					$(".group-post-input .input").val("") // 입력창 초기화
					
					// 게시글 처음부터 다시 보여주기
					$(".post-list-bg").html('')
					
					let cri = {
						page : 1,
						search : ${group.go_num}
					}

					getGroupPostList(cri);
				}else{
					alert("게시글을 등록권한이 없습니다.")
				}
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("게시글을 등록하지 못했습니다. (에러 발생)")
			}
	});
})
</script>

<!-- 게시글 수정 script -->
<script type="text/javascript">
let content
let btnGroup
let num

	// 수정 버튼 클릭 시 기존 내용은 숨기고, textarea 창을 띄움.
	$(document).on("click",".post-edit-btn", function(){
		if(!${group.go_update}){
			alert('그룹이 얼려진 상태입니다. 리더가 그룹 얼리기를 해제한 후 이용할 수 있습니다.')
			return;
		}
		
		initComment()
		
		content = $(this).parent().parent().find(".post-content")
		btnGroup = $(this).parent()
		
		content.hide() // 기존 게시글 내용 숨기기
		btnGroup.hide() // 버튼들 숨기기
		
		let text = content.text().trim()
		num = $(this).data("num")
		
		
		let edit = `
			<div class="edit-box">
				<textarea class="post-content-edit" style="width: 100%; height: 100px; border: 1px solid black;">\${text}</textarea>
				<div class="post-edit-btn-group">
					<a class="post-finish-btn">완료</a>
					<a class="post-cancel-btn" onclick="initComment()">취소</a>
				</div>
			</div>
		`
		
		content.after(edit)
	})
		
	// 완료버튼 클릭 시
	$(document).on("click",".edit-box .post-finish-btn", function(){
		$.ajax({
			async : false, 
			url : '<c:url value="/group/post/update"/>', 
			type : 'post', 
			data : {
				num : num,
				content: $(".post-content-edit").val()
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data == "ok"){
					alert("게시글이 수정되었습니다.")
					
					initComment() // 수정 창 없애기
					refresh() // 게시글 목록 새로고침
				}else{
					alert("게시글을 수정권한이 없습니다.")
				}
				
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("게시글을 수정하지 못했습니다. (에러발생)")
			}
		});
	})
	
	// 기존 내용을 다시 보이게 하고, 수정창을 숨기는 함수
	function initComment(){
		// 숨겼던 기존 코드 표시하기
		$(".post-content").show()
		$(".post-manage-btn-group").show()
		
		// 수정창 숨기기
		$(".edit-box").remove()
	}
	
	// 게시글 목록 갱신 함수
	function refresh(){
		$(".post-list-bg").html('')
		
		for (let i=1; i<=page; i ++){
			
			let cri = {
				page: i,
				search : ${group.go_num}
			}					
			getGroupPostList(cri);
		}
	}
</script>

<!-- 게시글 삭제 script -->
<script type="text/javascript">
$(document).on("click",".post-delete-btn", function(){
	if(!${group.go_update}){
		alert('그룹이 얼려진 상태입니다. 리더가 그룹 얼리기를 해제한 후 이용할 수 있습니다.')
		return;
	}
	
	$.ajax({
		async : true, 
		url : '<c:url value="/group/post/delete"/>', 
		type : 'post', 
		data : {
			num : this.dataset.num
		}, 
		dataType : "json", 
		success : function (data){
			if(data.data == "ok"){
				alert("게시글이 삭제되었습니다.")
				refresh() // 게시글 목록 갱신(게시글 수정 script에 정의되어 있음.)
				
			}else{
				alert("게시글을 삭제하지 못했습니다.")
			}
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("게시글을 삭제하지 못했습니다. (오류발생)")
		}
});
})


</script>
</body>
</html>