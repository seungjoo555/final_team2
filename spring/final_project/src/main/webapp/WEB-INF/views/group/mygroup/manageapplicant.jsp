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
<style>
	
	
	/* ======================================= manageapplicant.jsp ============================================ */
	
	.applicant-list-bg>*{width: 90%; margin: 0px auto; text-align: center; padding: 10px;}
	
	/* applyList table thead*/
	.applicant-list-th .id{width: 20%; overflow: hidden; white-space: nowrap; text-overflow:ellipsis;}
	.applicant-list-th .nickname{width: 20%; overflow: hidden; white-space: nowrap; text-overflow:ellipsis;}
	.applicant-list-th .content{width: 50%;}
	
	/* applyList table tbody*/
	.applicant-list td{line-height: 50px; height: 50px;}
	.applicant-list .nickname{
		width: 90%; font-weight: bold; margin: auto; text-decoration: underline; color: black;
		overflow: hidden; white-space: nowrap; text-overflow:ellipsis;
	}
	.applicant-list .id{width: 90%; margin: auto; overflow: hidden; white-space: nowrap; text-overflow:ellipsis;}
	.applicant-list .content a{
		width: 80%; display: block; text-decoration: underline; color: black; margin: auto;
		overflow: hidden; white-space: nowrap; text-overflow:ellipsis;
	}
	
	.apply-manage-btn-group{text-align: center; margin-top: 0; visibility: hidden;}
	.apply-manage-btn-group>*{width: 50px; border-radius: 5px; margin: auto 0;}
	.apply-manage-btn-group>*:hover{text-decoration: none;}
	.apply-manage-btn-group .apply-confirm-btn{background-color: #5A7059; color: white; margin-right: 5px;}
	.apply-manage-btn-group .apply-deny-btn{background-color: #FFFFFF; color: #243323; margin:auto 10px auto 0;}
	
</style>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${group == null }">
			<div class="not-authorized text-align-center">
				<div>접근 권한이 없는 페이지 입니다.</div>
				<a href="<c:url value="/"/>">홈으로 가기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container-info-bar">
				<div class="float-left group-title">${group.go_name}</div>
				<div class="float-left">지원자 관리페이지</div>
			</div>
			<div class="applicant-list-bg">
				
			</div>
		</c:otherwise>
	</c:choose>
</div>

<!-- 그룹 지원자 불러오기 -->
<script type="text/javascript">

getApplyList()

function getApplyList(){
	let str = '';
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/group/manage/applicant/list"/>', 
		type : 'post', 
		data : {
			num : ${group.go_num},
		}, 
		dataType : "json", 
		success : function (data){
			if(data.list.length == 0){
				$(".applicant-list-bg").append(`<div style="text-align: center">접수된 가입 신청이 없습니다.</div>`)
			}
			
			for(apply of data.list){
				
				str +=
					`
					<tr>
						<td>
							<c:url var = 'url1' value = '/mypage/profile'/>
							<a class="nickname" href="${url1}?me_id=\${apply.goap_me_id}">\${apply.nickname}</a>
						</td>
						<td><div class="id">\${apply.goap_me_id}<div></td>
						<td class="text-center content">
							<a href="#">\${apply.goap_content }</a>
						</td class="content">
						<td class="apply-manage-btn-group">
							<a class="apply-confirm-btn" data-num="\${apply.goap_num}">수락</a>
							<a class="apply-deny-btn" data-num="\${apply.goap_num}">거절</a>
						<td>
					</tr>
					`;
				}
			
				let table = `
					<table>
						<thead>
							<tr>
								<th class="nickname">닉네임</th>
								<th class="id">아이디</th>
								<th class="content">지원 내용</th>
							</tr>
						</thead>
						<tbody class="applicant-list">
							\${str}
						</tbody>
					</table>
				`;
				
				$(".applicant-list-bg").append(table); // 페이지 넘김이 아니라 아래에 내용 추가
				
			}, 
			error : function(a, b, c){
				
		}
	});
	
}

<!-- 지원자 리스트 hover 설정 -->
$(document).on("mouseover",".applicant-list tr", function(){
	$(this).css("background-color", "#C9C9C9")
	$(this).children('.apply-manage-btn-group').css("visibility", "visible")
})

$(document).on("mouseout",".applicant-list tr", function(){
	$(this).css("background-color", "transparent")
	$(this).children('.apply-manage-btn-group').css("visibility", "hidden")
})
</script>




<!-- 지원 수락 -->
<script type="text/javascript">
	// 구현 예정
	$(document).on('click', '.apply-confirm-btn', function(){
		let num = $(this).data('num')
		alert('수락'+num)
	})
</script>

<!-- 지원 거절 -->
<script type="text/javascript">
	// 구현 예정
	$(document).on('click', '.apply-deny-btn', function(){
		let num = $(this).data('num')
		alert('거절'+num)
	})
</script>
</body>
</html>