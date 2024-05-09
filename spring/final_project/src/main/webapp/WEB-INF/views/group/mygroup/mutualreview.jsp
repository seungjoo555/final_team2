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
	.btn-box{width: 20%;}
	
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
				<div class="float-left">그룹 멤버 상호평가 페이지</div>
			</div>
			<div class="member-list-bg">
				
			</div>
			
			<!-- 페이지네이션 -->
			<div class="box-pagination">
				<ul class="pagination justify-content-center">
					<!-- 페이지네이션 출력됨 -->
				</ul>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<!-- 그룹 멤버 불러오기 -->
<script type="text/javascript">
let cri = {
		page : 1,
		search : ${group.go_num},
		type : 'all'
	}

getMemberList(cri)

function getMemberList(cri){
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : "<c:url value="/group/manage/member/list"/>", 
		type : 'post', 
		data : JSON.stringify(cri), 
		//서버로 보낼 데이터 타입
		contentType : "application/json; charset=utf-8",
		//서버에서 보낸 데이터의 타입
		dataType :"json", 
		success : function (data){
				displayMemberList(data.list) // 지원자 리스트 표시
				displayGroupPagination(data.pm) // 페이지네이션 표시
			}, 
			error : function(a, b, c){
				
		}
	});
	
}
	
function displayMemberList(list){
	let str = '';

	if(list.length == 0){
		$(".member-list-bg").html(`<div style="text-align: center">조회 내역이 없습니다.</div>`)
		return;
	}
	
	for(member of list){
		
		// 만약 이미 평가한 사람이라면 
		// <a class="view-review", data-num = "\${mure.mure_num}">평가보기</a>
		
		// 아니라면
		// <a class="insert-review", data-id = "\${groupMember.gome_me_id}">평가하기</a>
		
		str +=
			`
			<tr>
				<td class="nickname">
					<c:url var = 'url1' value = '/mypage/profile'/>
					<a href="${url1}?me_id=\${member.gome_me_id}">\${member.nickname}</a>
				</td>
				<td><div class="id">\${member.gome_me_id}<div></td>
				<td class="review-manage-btn-group">
					<a class="member-warn-btn" data-id="\${member.gome_me_id}">평가하기</a>
				<td>
			</tr>
			`;
	
	}
		let table = `
			<table>
				<thead class="member-list-th">
					<tr>
						<th class="nickname" style="width: 40%">닉네임</th>
						<th class="id" style="width: 40%">아이디</th>
						<th class="btn-box"></th>
					</tr>
				</thead>
				<tbody class="applicant-list">
					\${str}
				</tbody>
			</table>
		`;
		
		$(".member-list-bg").html(table);
	
}

//페이지네이션
function displayGroupPagination(pm){
	let str = '';
	
	if(pm.prev){
		str +=
			`<li class="page-item">
				<a class="page-link" href="javascript:void(0)" data-page="\${pm.startPage - 1}" data-type="\${pm.cri.type}">이전</a>
		    </li>`;
	}
	
	for(let i = pm.startPage; i<=pm.endPage; i++){
		let active = pm.cri.page == i ? 'active':'';
		str +=
			`
			 <li class="page-item \${active}">
			 	<a class="page-link" href="javascript:void(0)" data-page="\${i}" data-type="\${pm.cri.type}">\${i}</a>
		    </li>				
			`;
	}
	
	if(pm.next){
		str +=
			`
			<li class="page-item">
				<a class="page-link" href="javascript:void(0)" data-page="\${pm.endPage + 1}" data-type="\${pm.cri.type}">다음</a>
		    </li>				
			`;
	}
	$('.box-pagination>ul').html(str);
}


// 클릭이벤트
$(document).on('click', '.box-pagination .page-link', function(){
	cri.page = $(this).data('page');
	getMemberList(cri);
})


<!-- 멤버 리스트 hover 설정 -->
$(document).on("mouseover",".applicant-list tr", function(){
	$(this).css("background-color", "#C9C9C9")
	$(this).children('.review-manage-btn-group').css("visibility", "visible")
})

$(document).on("mouseout",".applicant-list tr", function(){
	$(this).css("background-color", "transparent")
	$(this).children('.review-manage-btn-group').css("visibility", "hidden")
})

</script>

<!-- 멤버 리스트 query 설정 변경 -->
<script type="text/javascript">
$("[name=type]").click(function(){
	cri.type = $(this).val();
	getMemberList(cri);
})
</script>

<!-- 상호평가 하기 -->
<script type="text/javascript">
	$(document).on('click', '.member-warn-btn', function(){
		if(!${group.go_update}){
			alert('그룹이 얼려진 상태입니다. 리더가 그룹 얼리기를 해제한 후 이용할 수 있습니다.')
			return;
		}
		
		let id = $(this).data('id')
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/group/manage/member/warn"/>", 
			type : 'post', 
			data : {
				num : ${group.go_num},
				id : id
				}, 
			dataType :"json", 
			success : function (data){
					if(data.data == 'ok'){
						alert('경고를 부여했습니다.')
						getMemberList(cri);
					}else{
						alert('경고를 부여하지 못했습니다. 새로고침 후 다시 이용해주세요.')
					}
				}, 
				error : function(a, b, c){
					
			}
		});
	})
</script>

<!-- 상호평가 내용 보기 -->
<script type="text/javascript">
	$(document).on('click', '.member-ban-btn', function(){
		if(!${group.go_update}){
			alert('그룹이 얼려진 상태입니다. 리더가 그룹 얼리기를 해제한 후 이용할 수 있습니다.')
			return;
		}
		
		let id = $(this).data('id')
		
		if(confirm(id +' 회원을 그룹에서 탈퇴시키겠습니까? 그룹 탈퇴 시, 해당 사용자가 작성한 모든 데이터가 삭제되며 복구할 수 없습니다.'))
		
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/group/manage/applicant/ban"/>", 
			type : 'post', 
			data : {
				num : ${group.go_num},
				id : id
				}, 
			dataType :"json", 
			success : function (data){
					if(data.data == 'ok'){
						alert('멤버를 탈퇴시켰습니다.')
						getMemberList(cri);
					}else{
						alert('멤버를 탈퇴시키지 못했습니다. 새로고침 후 다시 이용해주세요.')
					}
				}, 
				error : function(a, b, c){
					
			}
		});
	})
</script>


</body>


</html>