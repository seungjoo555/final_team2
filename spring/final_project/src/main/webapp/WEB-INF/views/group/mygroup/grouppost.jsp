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
			for(post of data.list){
				let btns = '';
				//현재 로그인한 유저와 댓글을 쓰기 위한 유저의 아이디가 동일하거나 댓글 관리 권한이 있다면 수정,삭제 버튼이 나타나고 아니라면 나타나지 않음
				if('${user.me_id}' == post.gopo_gome_me_id){	
				btns +=
					`
					<div class="post-manage-btn-group">
						<a class="float-left post-edit-btn" data-num="\${post.gopo_num}">수정</a>
						<a class="float-left post-delete-btn" data-num="\${post.gopo_num}">삭제</a>
					</div>
					`
				}
				
				str +=
					`
					<div>
						<div class="post-info">
							<div class="writer float-left">\${post.nickname}</div>
							<div class="time float-left">\${post.time_ago}</div>
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
	 $.ajax({
			async : false, 
			url : '<c:url value="/group/post/insert"/>', 
			type : 'post', 
			data : {
				goNum : ${group.go_num},
				content: $(".group-post-input .input").val(),
				writer: "${user.me_id}"
			}, 
			dataType : "json", 
			success : function (data){
				alert("게시글이 등록되었습니다.")
				$(".group-post-input .input").val("") // 입력창 초기화
				
				// 게시글 처음부터 다시 보여주기
				$(".post-list-bg").html('')
				
				let cri = {
					page : 1,
					search : ${group.go_num}
				}

				getGroupPostList(cri);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("게시글을 등록하지 못했습니다.")
			}
	});
})
</script>

<!-- 게시글 수정 script -->
<script type="text/javascript">
	// 구현 예정
	
</script>

<!-- 게시글 삭제 script -->
<script type="text/javascript">
$(document).on("click",".post-delete-btn", function(){
	
	$.ajax({
		async : true, 
		url : '<c:url value="/group/post/delete"/>', 
		type : 'post', 
		data : {
			gopoNum : this.dataset.num
		}, 
		dataType : "json", 
		success : function (data){
			if(data.data == "ok"){
				alert("게시글이 삭제되었습니다.")
				
				// 게시글 목록 갱신
				$(".post-list-bg").html('')
				
				for (let i=1; i<=page; i ++){
					
					let cri = {
						page: i,
						search : ${group.go_num}
					}					
					getGroupPostList(cri);
				}
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