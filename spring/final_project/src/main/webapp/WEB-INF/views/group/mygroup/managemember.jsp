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
	
	
	/* ======================================= groupmanage.jsp ============================================ */
	/* applicantmanage의 style을 주로 이용함. */

	.member-list-bg>*{width: 90%; margin: 0px auto; text-align: center; padding: 10px;}
	
	.member-list-th tr th{width: calc(80% / 3);}
	.member-list-th tr th:last-child{width: 20%;}
	
	.apply-manage-btn-group .member-warn-btn{background-color: yellow; margin-right: 5px;}
	.apply-manage-btn-group .member-ban-btn{background-color: red; margin:auto 10px auto 0;}
	
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
				<div class="float-left">그룹 멤버 관리페이지</div>
			</div>
			<div class="member-query">
				<form>
					<input type="radio" id="all" name="type" value="all" checked>
					<label for="all">전체</label>
					<input type="radio" id="over-5" value="over-5" name="type">
					<label for="over-5">경고 5회 이상</label>
				
				</form>
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
		type : 0
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
		$(".applicant-list-bg").html(`<div style="text-align: center">조회 내역이 없습니다.</div>`)
		return;
	}
	
	for(member of list){
		
		str +=
			`
			<tr>
				<td class="nickname">
					<c:url var = 'url1' value = '/mypage/profile'/>
					<a href="${url1}?me_id=\${member.gome_me_id}">\${member.nickname}</a>
				</td>
				<td><div class="id">\${member.gome_me_id}<div></td>
				<td class="text-center warn">\${member.gome_warn}</td class="content">
				<td class="apply-manage-btn-group">
					<a class="member-warn-btn" data-id="\${member.gome_me_id}">경고</a>
					<a class="member-ban-btn" data-id="\${member.gome_me_id}">탈퇴</a>
				<td>
			</tr>
			`;
			
		let table = `
			<table>
				<thead class="member-list-th">
					<tr>
						<th class="nickname">닉네임</th>
						<th class="id">아이디</th>
						<th class="warn">경고 횟수</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="applicant-list">
					\${str}
				</tbody>
			</table>
		`;
		
		$(".member-list-bg").html(table);
	}
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

<!-- 지원자 리스트 query 설정 변경 -->
<script type="text/javascript">
$("[name=type]").click(function(){
	cri.type = $(this).attr('value');
	getMemberList(cri);
})
</script>



</body>


</html>