<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 멤버관리</title>
<link rel="stylesheet" href="<c:url value="/resources/css/adminmember.css"/>">
</head>
<body>
<div class="container">

	<h1>멤버관리</h1>
	
	<div class="box-search-form">
		<form action="<c:url value="/admin/managemember"/>" method="get" class="search-form">
			<select name="type" class="form-control-select" name="type">
				<option value="all" <c:if test="${pm.cri.type == 'all'}">selected</c:if>>아이디</option>
				<option value="auth" <c:if test="${pm.cri.type == 'auth'}">selected</c:if>>등급</option>
				<option value="state" <c:if test="${pm.cri.type == 'state'}">selected</c:if>>상태</option>
			</select>
			<div class="box-search-input">
				<input type="text" name="search" class="form-control-input" placeholder="검색어" value="${pm.cri.search}">
				<button class="">
					<img alt="검색" src="/team2/resources/img/search_icon.svg">
				</button>
			</div>
		</form>
	</div>
	
	<div class="box-member-list">
		<table class="table table-hover table-member-list">
			<thead>
				<tr>
			        <th><input class="total-check-member" type="checkbox"></th>
			        <th>아이디</th>
			        <th>권한</th>
			        <th>상태</th>
			        <th>버튼</th>
			      </tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(list) == 0}">
					<tr>
						<td colspan="5">가입한 유저가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${fn:length(list) != 0}">
					<c:forEach items="${list}" var="member" varStatus="i">
						<tr>
							<td>
								
								<c:if test="${member.me_ms_state == '탈퇴'}">
									<input class="check-member-disabled" name="check-member-disabled"  type="checkbox" disabled="disabled" >
								</c:if>
								<c:if test="${member.me_ms_state != '탈퇴'}">
									<input class="check-member" name="check-member" type="checkbox">
								</c:if>	
							</td>
							<td data-me_id="${member.me_id}">${member.me_id}</td>
							<td>
								<c:if test="${member.me_ms_state == '탈퇴'}">
									<select id="select-auth-${i.index}" disabled>
										<option class="ma_auth" value="${member.me_ma_auth}" selected>${member.me_ma_auth}</option>
									</select>
								</c:if>
								<c:if test="${member.me_ms_state != '탈퇴'}">
									<select id="select-auth-${i.index}">
										<c:forEach items="${authList}" var="ma_auth">
											<option class="ma_auth" value="${ma_auth}" <c:if test="${member.me_ma_auth == ma_auth}">selected</c:if>>${ma_auth}</option>
										</c:forEach>
									</select>
								</c:if>
							</td>
							<td>
								<c:if test="${member.me_ms_state == '탈퇴'}">
									<select  id="select-state-${i.index}" disabled >
										<option class="ms_state" value="${member.me_ms_state}" selected >${member.me_ms_state}</option>
									</select>
								</c:if>
								<c:if test="${member.me_ms_state != '탈퇴'}">
									<select  id="select-state-${i.index}">
										<c:forEach items="${stateList}" var="ms_state">
											<option class="ms_state" value="${ms_state}" <c:if test="${member.me_ms_state == ms_state}">selected</c:if>>${ms_state}</option>
										</c:forEach>
									</select>
								</c:if>
							</td>
							<td>
								<c:if test="${member.me_ms_state == '탈퇴'}">
									<button class="btn-update" disabled>변경</button>
								</c:if>
								<c:if test="${member.me_ms_state != '탈퇴'}">
									<button class="btn-update">변경</button>
								</c:if>
									<button class="btn-delete">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		
	<button class="btn-batch-processing" type="button">일괄 변경</button>
	<button class="btn-batch-delete" type="button">일괄 삭제</button>

	</div>

	<!-- 페이지네이션 -->
	<div class="box-pagination">
		 <ul class="pagination justify-content-center">
		 	<c:if test="${pm.prev}">
		 		<c:url value="/admin/managemember" var="url">
		 			<c:param name="page" value="${pm.startPage - 1 }"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item">
			    	<a class="page-link" href="${url}">이전</a>
			    </li>
		 	</c:if>
		 	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
		 		<c:url value="/admin/managemember" var="url">
		 			<c:param name="page" value="${i}"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item <c:if test="${pm.cri.page == i }">active</c:if>">	
			    	<a class="page-link" href="${url}">${i}</a>
			    </li>
		 	</c:forEach>
		    <c:if test="${pm.next}">
		    	<c:url value="/admin/managemember" var="url">
		 			<c:param name="page" value="${pm.endPage + 1 }"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item">
			    	<a class="page-link" href="${url}">다음</a>
			    </li>
		    </c:if>
	 	</ul>
	</div>
  	
	
	
	<!-- 회원 일괄 정보 변경 처리 화면 -->
   <div id="modal" class="modal admin-member-process-modal" style="display:none;">
      <div id="dimmed" class="dimmed admin-member-process-dimmed"></div>
      <div class="admin-member-process-container">
      	<div class="admin-report-process-box">
	  	<div> <h1>멤버 정보 변경</h1> </div>
	  	<input type="hidden" id="td-list" value="\${tdList}">
	  	<div class="state-select-box">
			<select id="select-auth-all">
				<c:forEach items="${authList}" var="ma_auth">
					<option class="ma_auth" value="${ma_auth}" >${ma_auth}</option>
				</c:forEach>
			</select>

			<select  id="select-state-all">
				<c:forEach items="${stateList}" var="ms_state">
					<option class="ms_state" value="${ms_state}" >${ms_state}</option>
				</c:forEach>
			</select>
		</div>
		<div class="box-btn-admin-member-process"><button type="button" class="btn-admin-member-process">변경하기</button></div>
	  	</div>
	  	
      </div>
   </div>

</div>

<!-- 회원 단일 정보 변경/삭제 기능 -->
<script type="text/javascript">

$(document).on("click", ".btn-update", function(){
	let tr = $(this).parent().parent();
	let td = tr.children();
	
	/* 변경 할 회원 정보 가져오기*/
	let member = {
			me_id : td.eq(1).data("me_id"),
			me_ma_auth : $("#" + (td.eq(2).children().attr("id")) +" option:selected").val(),
			me_ms_state : $("#" + (td.eq(3).children().attr("id")) +" option:selected").val()
	}
	if(confirm("해당 유저 "+member.me_id+" 의 정보를 "+member.me_ma_auth+", "+member.me_ms_state +"으로 변경하시겠습니까?") == false)
		return;
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/managemember/update"/>', 
		type : 'post', 
		data : JSON.stringify(member),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("멤버 정보가 변경 " + "되었습니다.");
				location.href = '<c:url value="/admin/managemember"/>';	
			}else{
				alert("멤버 정보를 변경하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});	//ajax end
	
	
	
})
//멤버 정보 삭제 버튼 이벤트
$(document).on("click", ".btn-delete", function(){
	let tr = $(this).parent().parent();
	let td = tr.children();
	
	if(confirm("해당 유저 "+td.eq(1).data("me_id")+"를 삭제하시겠습니까? 삭제 후 취소할 수 없습니다.") == false)
		return;
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/managemember/quit"/>', 
		type : 'post', 
		data : {
			me_id : td.eq(1).data("me_id")
		},
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("멤버 정보가 삭제되었습니다.");
				location.href = '<c:url value="/admin/managemember"/>';	
			}else{
				alert("멤버 정보를 삭제하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});	//ajax end
})
</script>

<!-- 체크박스 - 선택된 회원 정보 변경 기능 -->
<script type="text/javascript">

/* dimmed 클릭 시 모달창 비활성화 */
$(document).on('click', '.admin-member-process-dimmed', function(){
   $(".admin-member-process-modal").css('display','none');
   $("body").css('overflow','visible');
})

$(document).on('click', '.total-check-member', function(){
	if($(".total-check-member").prop("checked")){
		$("input:checkbox[class='check-member']").prop('checked',true);
	}else{
		$("input:checkbox[class='check-member']").prop('checked',false);
	}
})

///멤버 선택 변경 클릭이벤트
$(document).on('click', '.btn-batch-processing', function(){
   var checkBox = $("input[name=check-member]:checked");
   if(checkBox.length === 0){
		alert("선택된 신고내역이 없습니다.");
		return;
	}
   $(".admin-member-process-modal").css('display','block');
   $("body").css('overflow','hidden');
})


//선택된 멤버 정보 변경 이벤트
$(document).on('click', '.btn-admin-member-process', function(){
   //체크된 멤버 정보 변경
	var checkBox = $("input[name=check-member]:checked");
	
	var idList = [];
	
	//반복해서 id값 가져오기
	checkBox.each(function(i){
		//tr, td 정보 가져오기
		var tr = checkBox.parent().parent().eq(i);
		var td = tr.children();
		//특정 td값 가져오기
		var id = td.eq(1).data("me_id");
		idList.push(id);
	})
	
	let memberUpdateDto = {
		idList : idList,
		me_ma_auth : $("#select-auth-all option:selected").val(),
		me_ms_state : $("#select-state-all option:selected").val()
	}
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/managemember/update/all"/>', 
		type : 'post', 
		data : JSON.stringify(memberUpdateDto),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("선택된 멤버들의 정보가 변경 되었습니다.");
				location.href = '<c:url value="/admin/managemember"/>';	
			}else{
				alert("선택된 멤버들의 정보가 변경되지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(textStatus);
		}
	});	//ajax end
})

//선택된 멤버 일괄 삭제 이벤트
$(document).on('click', '.btn-batch-delete', function(){
   //체크된 멤버 정보 변경
	var checkBox = $("input[name=check-member]:checked");
	
	var idList = [];
	
	//반복해서 id값 가져오기
	checkBox.each(function(i){
		//tr, td 정보 가져오기
		var tr = checkBox.parent().parent().eq(i);
		var td = tr.children();
		//특정 td값 가져오기
		var id = td.eq(1).data("me_id");
		idList.push(id);
	})
	
	let memberUpdateDto = {
		idList : idList,
	}
	
	if(confirm("해당 유저들의 정보를 정말 삭제하시겠습니까? 삭제 후 취소할 수 없습니다.") == false)
		return;

	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/managemember/quit/all"/>', 
		type : 'post', 
		data : JSON.stringify(memberUpdateDto),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("선택된 멤버 정보를 삭제했습니다.");
				location.href = '<c:url value="/admin/managemember"/>';	
			}else{
				alert("선택된 멤버 정보를 삭제하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(textStatus);
		}
	});	//ajax end
})

</script>



</body>
</html>