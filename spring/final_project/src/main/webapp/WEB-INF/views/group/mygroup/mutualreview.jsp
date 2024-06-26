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
	.review-manage-btn-group{visibility: hidden;}
	
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
			<div class="applicant-query">
				<input type="radio" id="not-reviewed" value="not-reviewed" name="type" checked>
				<label for="not-reviewed">미평가한 멤버</label>
				<input type="radio" id="reviewed" value="reviewed" name="type">
				<label for="reviewed">평가한 멤버</label>
			</div>
			<div>
				<div class="member-list-bg">
				
				
				</div>
			</div>
			
			<!-- 페이지네이션 -->
			<div class="box-pagination">
				<ul class="pagination justify-content-center">
					<!-- 페이지네이션 출력됨 -->
				</ul>
			</div>
			
			<!-- 모달창 -->
			<div id="modal" class="modal" style="display:none;">
		      <div id="dimmed" class="dimmed apply-mentoring-dimmend"></div>
		      <div class="manage-group_container mutual-review-modal">
		      	<button class="cancle-btn">&times;</button>	
	      		
	      		<!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">사용자 평가</h4>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
			        <form action="<c:url value="/group/review/insert"/>" method="post" id="review-form">
			        	<div class="extra-info" style="display: none;">
			        		<input class="form-control" placeholder="" id="user_id" name="user_id" readonly>
			        		<input class="form-control" placeholder="" id="num" name="num" readonly>
			        	</div>
				          <div class="form-group empl_nm">
							<label for="id">평가 대상:</label>
							<input class="form-control" placeholder="" id="target_id" name="target_id" readonly>
						  </div>
						  <br>
				          <div class="form-group">
							<label for="memo">평가 내용:</label>
							<textarea class="form-control" placeholder="1자 이상 작성" id="memo" name="memo" ></textarea>
						  </div>
						  <div class="form-group">
							<label for="rate">평가 점수:</label>
							<input type="text" class="form-control" placeholder="1~10(소수점 x)" id="rate" name="rate" >
						  </div>
						  <button class="btn btn-outline-success float-right insertBtn">등록</button>
			        </form>
		      </div>
		   </div>
		   </div>
		</c:otherwise>
	</c:choose>
</div>

<!-- 미평가한 멤버 목록 불러오기(페이지 시작 시 자동 실행) -->
<script type="text/javascript">
let cri = {
		page : 1,
		search : ${group.go_num},
		type : '${user.me_id}'
	}

let btn = '<a data-id = "\${groupMember.gome_me_id}" onclick="insertModalOpen(member)">평가하기</a>'

	getNoReviewMemberList(cri)

function getNoReviewMemberList(cri){
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : "<c:url value="/group/noreview/list"/>", 
		type : 'post', 
		data : JSON.stringify(cri), 
		//서버로 보낼 데이터 타입
		contentType : "application/json; charset=utf-8",
		//서버에서 보낸 데이터의 타입
		dataType :"json", 
		success : function (data){
				displayMemberList(data.list, btn) // 지원자 리스트 표시
				displayGroupPagination(data.pm) // 페이지네이션 표시
			}, 
			error : function(a, b, c){
				
		}
	});
	
}
</script>

<!-- 평가한 멤버 목록 불러오기 -->
<script type="text/javascript">

function getReviewedMemberList(cri){
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : "<c:url value="/group/reviewed/list"/>", 
		type : 'post', 
		data : JSON.stringify(cri), 
		//서버로 보낼 데이터 타입
		contentType : "application/json; charset=utf-8",
		//서버에서 보낸 데이터의 타입
		dataType :"json", 
		success : function (data){
				displayMemberList(data.list, btn) // 지원자 리스트 표시
				displayGroupPagination(data.pm) // 페이지네이션 표시
			}, 
			error : function(a, b, c){
				
		}
	});
}
</script>

<!-- 리스트 화면에 출력 -->
<script type="text/javascript">
function displayMemberList(list, btn){
	let str = '';

	if(list.length == 0){
		$(".member-list-bg").html(`<div style="text-align: center">조회 내역이 없습니다.</div>`)
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
				<td class="review-manage-btn-group">
					\${btn}
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
	if($('#not-reviewed').is(':checked')){
		getNoReviewMemberList(cri)
	}else{
		getReviewedMemberList(cri)
	}
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

//평가하지 않은 멤버를 조회할 시,
//<a class="insert-review", data-id = "\${groupMember.gome_me_id}">평가하기</a>

//이미 평가한 멤버를 조회할 시, 
//<a class="view-review", data-num = "\${mure.mure_num}">평가보기</a>

$("#not-reviewed").click(function(){
	btn = '<a data-id = "\${member.gome_me_id}" onclick="insertModalOpen(member)">평가하기</a>'
	getNoReviewMemberList(cri);
})

$("#reviewed").click(function(){
	btn = '<a data-num = "\${member.mure_num}" onclick="insertModalOpen(member)">평가보기</a>'
	getReviewedMemberList(cri);
})

</script>


<!-- 모달창 관련 script -->
<script type="text/javascript">
let g_arg

//모달 초기화
function initModal(modal, arg){
	$('.mutual-review-modal #target_id').val('');
	$('.'+modal+' #memo').val('');
	$('.'+modal+' #rate').val('');

	document.getElementById('memo').readOnly = false; 
	document.getElementById('rate').readOnly = false; 
	
	$('.mutual-review-modal .insertBtn').hide()
	
	$('.'+modal).modal('hide');
}

//모달 show
function insertModalOpen(arg){
	
	$('.mutual-review-modal #num').val(${group.go_num});
	$('.mutual-review-modal #user_id').val('${user.me_id}');
	$('.mutual-review-modal #target_id').val(arg.gome_me_id);
	
	// 값이 있는 경우(기존 일정을 클릭했을 경우) 세팅
	if(arg.mure_content){
		console.log('reviewed')
		$('.mutual-review-modal #memo').text(arg.mure_content);
		$('.mutual-review-modal #rate').val(arg.mure_rate);
		
		document.getElementById('memo').readOnly = true; 
		document.getElementById('rate').readOnly = true; 
		
	}else{
		
		$('.mutual-review-modal .insertBtn').show()
	}
	
	//모달창 show
	$("#modal").css('display','block');
   	//스크롤 비활성화
  	$("body").css('overflow','hidden');
}

/* dimmed 클릭 시 창 없애기 */
$(document).on('click', '#dimmed', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})
/* X 클릭 시 창 없애기 */
$(document).on('click', '.cancle-btn', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})


</script>


<!-- 상호평가form submit event -->
<script type="text/javascript">
$('#review-form').on('submit', function(){
	let memo = $('#memo').val()
	let rate = $('#rate').val()
	
	if(!memo){
		alert('평가 내용을 입력해주세요.')
		return false
	}
	
	if(rate > 10 || rate < 1 || isNaN(rate)){
		alert('1~10의 점수를 입력해주세요.')
		return false
	}
	if(confirm('상호평가는 그룹의 멤버 당 한 번만 가능하며, 수정할 수 없습니다. 작성하신 내역을 저장하시겠습니까?')){
		$('#rate').val(Math.floor(rate))
		return true
	}else{
		return false
	}
})
</script>
</body>


</html>