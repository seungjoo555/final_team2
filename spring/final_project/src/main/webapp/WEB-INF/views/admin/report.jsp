<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/adminreport.css"/>" >
<title>관리자 - 신고관리</title>

</head>
<body>
<div class="container">	
	<h1>신고 관리</h1>
	<div class="admin-header">
		<form action="<c:url value="/admin/report"/>" method="get" id="typeForm">
			<div class="input-group mb-3">
				<div class="select-box">
					<select name="type" class="form-control" name="type">
						<option value="all" <c:if test="${pm.cri.type == 'all'}">selected</c:if>>전체</option>
						<option value="recruit" <c:if test="${pm.cri.type == 'recruit'}">selected</c:if>>모집공고</option>
						<option value="mentoring" <c:if test="${pm.cri.type == 'mentoring'}">selected</c:if>>멘토링</option>
						<option value="lecture" <c:if test="${pm.cri.type == 'lecture'}">selected</c:if>>강의</option>
						<option value="member" <c:if test="${pm.cri.type == 'member'}">selected</c:if>>유저</option>
						<option value="post" <c:if test="${pm.cri.type == 'post'}">selected</c:if>>게시글</option>
						<option value="comment" <c:if test="${pm.cri.type == 'comment'}">selected</c:if>>댓글</option>
					</select> 
				</div>
				<div class="count-report">신고된 게시글 : ${pm.totalCount}개</div>
				<div class="check-view-box">
					<input name="search" value="대기중" type="checkbox" id="check-view" <c:if test="${pm.cri.search == '대기중'}">checked</c:if> >
					<label for="check-view" class="check-label"> <span>미처리 된 신고 항목만 보기</span></label>
				</div>
			</div>
		</form>
	</div>
		<table class="table table-hover">
			<thead>
				<tr>
			        <th><input class="total-check-report" type="checkbox"></th>
			        <th>신고횟수</th>
			        <th>신고 대상 타입</th>
			        <th>신고 대상</th>
			        <th>신고상세</th>
			        <th>처리상태</th>
			      </tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(rsList) == 0}">
					<tr>
						<td colspan="6">신고된 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${fn:length(rsList) != 0}">
					<c:forEach items="${rsList}" var="report">
						<tr>
							<td>
								<c:if test="${report.repo_repo_state == '대기중'}">
									<input class="check-report" name="check-report" type="checkbox">
								</c:if>
								<c:if test="${report.repo_repo_state != '대기중'}">
									<input class="check-report-disabled" name="check-report-disabled"  type="checkbox" disabled="disabled" >
								</c:if>
							</td>
							<td>${report.repo_count}</td>
							<td data-table="${report.repo_table}">${report.repo_table_str}</td>
							<td data-target="${report.repo_target}">${report.repo_target_str}</td>
							<td><button class="report-detail-btn" type="button" value="${report.repo_table}" data-target="${report.repo_target}">신고상세</button></td>
							<td>${report.repo_repo_state}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		
		<button class="btn-batch-processing" type="button">처리하기</button>
		
	<!-- 페이지네이션 -->
	<div class="box-pagination">
		 <ul class="pagination justify-content-center">
		 	<c:if test="${pm.prev}">
		 		<c:url value="/admin/report" var="url">
		 			<c:param name="page" value="${pm.startPage - 1 }"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item">
			    	<a class="page-link" href="${url}">이전</a>
			    </li>
		 	</c:if>
		 	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
		 		<c:url value="/admin/report" var="url">
		 			<c:param name="page" value="${i}"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item <c:if test="${pm.cri.page == i }">active</c:if>">	
			    	<a class="page-link" href="${url}">${i}</a>
			    </li>
		 	</c:forEach>
		    <c:if test="${pm.next}">
		    	<c:url value="/admin/report" var="url">
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
  
	<!-- 멘토링 상세 화면 -->
   <div id="modal" class="modal apply-mentoring-modal" style="display:none;">
      <div id="dimmed" class="dimmed apply-mentoring-dimmend"></div>
      <div class="apply-mentoring_container">
      	<div class="apply-mentoring_box"></div>
      </div>
   </div>
  <!-- 신고내역 상세화면 -->
   <div id="modal" class="modal admin-report-modal" style="display:none;">
      <div id="dimmed" class="dimmed admin-report-dimmed"></div>
      <div class="admin-report-container">
      	<div class="admin-report-box"></div>
      </div>
   </div>
  <!-- 신고 일괄 처리 화면 -->
   <div id="modal" class="modal admin-report-process-modal" style="display:none;">
      <div id="dimmed" class="dimmed admin-report-process-dimmed"></div>
      <div class="admin-report-process-container">
      	
      </div>
   </div>
  
   
</div>

<!-- 신고 상세화면 출력 - 클릭 이벤트 -->
<script type="text/javascript">
$(document).on('click', '.report-detail-btn', function(){
	//모달창 활성화 
	$(".admin-report-modal").css('display','block');
   //스크롤 비활성화
	$("body").css('overflow','hidden');
   //테이블과 타켓 정보 받아오기
   let repo_target = $(this).data("target");
   let repo_table =$(this).val();
   
	getReportList(repo_target, repo_table);
	function getReportList(repo_target, repo_table){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/report/detail"/>", 
			type : 'post', 
			data : {
				repo_target :  repo_target,
				repo_table :  repo_table
			},
			dataType :"json", 
			success : function (data){
				displayReportList(data.rpList, data.stateList, data.member ,data.link);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	//ajax end
	}	//getReportList(); end
	
   
	function displayReportList(rpList, stateList, member, link){
		let str = '', table='', option ='', linkStr='', btnStr='';
		
		//신고리스트
		if(rpList == null || rpList.length == 0){
			table +=
				`
				<tr>
					<td colspan="3">신고된 내역이 없습니다.</td>
				</tr>
				`;
		}else{
			for(var i=0; i< rpList.length; i++){
				report = rpList[i];
				let dateStr = convertDate(report.repo_date);
				table += 
					`
					<tr>
						<td class="tbody-td td-f">\${report.repo_me_id}</td>
						<td class="tbody-td td-s">\${report.repo_detail}</td>
						<td class="tbody-td td-e">\${dateStr}</td>
					</tr>
					`
			}
		}
		//멤버 상태
		for(var i=0; i<stateList.length; i++){
			let state = stateList[i], select = "";
			if(member.me_ms_state == state){
				select = "selected";
			}
			option +=
				`
				<option value="\${state}" \${select}>\${state}</option>
				`
		}
		
		//링크 이동
		if(repo_table == "mentoring"){
			linkStr += `<a href="#" class="report-target-link mentoring-link">바로가기(클릭)</a>`
		}else{
			linkStr += `<a href="<c:url value="\${link}"/>" class="report-target-link">바로가기(클릭)</a>`
		}
		
		//처리된 신고 버튼 비호활성화
			console.log("rpList[0].repo_repo_state :: " + rpList[0].repo_repo_state);
		if(rpList[0].repo_repo_state == "대기중"){
			btnStr += `<div class="box-report-process-btn"><button type="button" class="report-process-btn">변경</button></div>`
		}else{
			btnStr += `<div class="box-report-process-btn">\${rpList[0].repo_repo_state}</div>`
		}
				
		
		str += 
			`
			<div class="amidn-report-header">
		      		<div class="header-title"><h1>신고 내역</h1></div>
		      		<div class="btn-cancel"> <button>X</button> </div>
		      	</div>
		      	<div class="amidn-report-body">
		      		<div class="box-targe-link">
		      			<div class="report-target-title">신고대상</div>
		      			<input type="hidden" id="repo_target" value="\${repo_target}">
		      			<input type="hidden" id="repo_table" value="\${repo_table}">
		      `
		      +
		      linkStr
		      +
		      `
		      			
		      		</div>
		      		<div class="box-report-table">
		      		<table class="table table-hover table-report">
						<thead class="thead-flex">
							<tr>
						        <th class="thead-th th-f">신고자 ID</th>
						        <th class="thead-th th-s">신고 사유</th>
						        <th class="thead-th th-e">신고 일자</th>
					       </tr>
						</thead>
						<tbody class="tdoby-scroll">
		      `
		      +
		      table
		      +
		      `
						</tbody>
					</table>
		      		</div>
		      	</div>
		      	<div class="amidn-report-footer">
		      		<div class="report-meid" value="\${member.me_id}">\${member.me_id}</div>
		      		<div class="state-select-box">
						<select name="type" class="form-control state-select" name="state-select">
				`
				+
				option
				+
				`
							
							
						</select> 
					</div>
				`
				+
				btnStr
				+
				`
				</div>
			`
      $('.admin-report-box').html(str);
	}
   
   
   
})

//날짜 변경 함수
function convertDate(milliSecond) {
  const days = ['일', '월', '화', '수', '목', '금', '토'];
  const data = new Date(milliSecond);  //Date객체 생성

  const year = data.getFullYear();    //0000년 가져오기
  const month = data.getMonth() + 1;  //월은 0부터 시작하니 +1하기
  const date = data.getDate();        //일자 가져오기
  const day = days[data.getDay()];    //요일 가져오기

  //return `${year}.${month}.${date}. (${day})`;
  return `\${year}.\${month}.\${date}`;
}


/* dimmed 클릭 시 모달창 비활성화 */
$(document).on('click', '.admin-report-dimmed', function(){
   $(".admin-report-modal").css('display','none');
   $("body").css('overflow','visible');
})
$(document).on('click', '.apply-mentoring-dimmend', function(){
   $(".apply-mentoring-modal").css('display','none');
})
$(document).on('click', '.admin-report-process-dimmed', function(){
   $(".admin-report-process-modal").css('display','none');
   $("body").css('overflow','visible');
})
/* X 클릭 시 창 없애기 */
$(document).on('click', '.btn-cancel', function(){
   $(".admin-report-modal").css('display','none');
   $("body").css('overflow','visible');
})
</script>


<!-- 신고된 유저 상태 변경 버튼 이벤트 -->
<script type="text/javascript">
$(document).on('click', '.report-process-btn', function(){
	let set_state =  $(".state-select :selected").val();
	let set_me_id = $('.report-meid').attr("value");
	
	if(confirm("해당 유저의 상태를 [" + set_state + "]로 변경하시겠습니까?") == false)
		return;
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/report/update"/>', 
		type : 'post', 
		data : {
			set_me_id : set_me_id,
			set_state : set_state,
			repo_target : $("#repo_target").val(), 
		    repo_table :$("#repo_table").val()
		},
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("해당 신고건이 " + data.state + "되었습니다.");
				$(".admin-report-modal").css('display','none');
				$("body").css('overflow','visible');
				location.href = '<c:url value="/admin/report"/>';	
			}else{
				alert("해당 신고를 처리하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});
	
	
})

</script>


<script type="text/javascript">
$("[name=type]").change(function(){
	$("#typeForm").submit();
})
$("#check-view").change(function(){
	if($("#check-view").prop("checked")){
		${pm.cri.search == '대기중'}
		$("#typeForm").submit();
	}else{
		${pm.cri.search == ''}
		$("#typeForm").submit();
	}
})

</script>

<!-- 체크박스 일괄 처리 이벤트 -->
<script type="text/javascript">
$(document).on('click', '.total-check-report', function(){
	if($(".total-check-report").prop("checked")){
		$("input:checkbox[class='check-report']").prop('checked',true);
	}else{
		$("input:checkbox[class='check-report']").prop('checked',false);
	}
})

//select 이벤트 동작 없애기


$(document).on('click', '.btn-batch-processing', function(){
	var checkBox = $("input[name=check-report]:checked");
	
	if(checkBox.length === 0){
		alert("선택된 신고내역이 없습니다.");
		return;
	}
	
	var tdList = [];
	
	//반복해서 값 가져오기
	checkBox.each(function(i){
		//tr, td 정보 가져오기
		var tr = checkBox.parent().parent().eq(i);
		var td = tr.children();
		//특정 td값 가져오기
		let obj = {
			repo_table :  td.eq(2).data("table"),
			repo_target : td.eq(3).data("target")
		}
		tdList.push(obj);
	})
	
	//처리화면 띄우기
	//모달창 활성화 
	$(".admin-report-process-modal").css('display','block');
   //스크롤 비활성화
	$("body").css('overflow','hidden');
	
   let processStr = "";
   processStr += 
	   `
		<div class="admin-report-process-box">
	  	<div> <h1>신고처리</h1> </div>
	  	<input type="hidden" id="td-list" value="\${tdList}">
	  	<div class="state-select-box">
			<select name="type" class="form-control state-select" name="state-select" onchange="">
				<c:forEach items="${stateList}" var="state">
					<option value="${state}" >${state}</option>
				</c:forEach>
			</select> 
		</div>
		<div class="box-btn-admin-report-process"><button type="button" class="btn-admin-report-process">처리하기</button></div>
	  	</div>
	   `
	   
   $('.admin-report-process-container').html(processStr);
})

//일괄 처리 버튼 클릭 이벤트
$(document).on('click', '.btn-admin-report-process', function(){
	let set_state =  $(".state-select :selected").val();
	console.log("변경 상태 : " + set_state);
	
	var checkBox = $("input[name=check-report]:checked");
	
	if(checkBox.length === 0){
		alert("선택된 신고내역이 없습니다.");
		return;
	}
	
	var tdList = [];
	
	//반복해서 값 가져오기
	checkBox.each(function(i){
		//tr, td 정보 가져오기
		var tr = checkBox.parent().parent().eq(i);
		var td = tr.children();
		//특정 td값 가져오기
		let obj = {
			repo_table :  td.eq(2).data("table"),
			repo_target : td.eq(3).data("target")
		}
		tdList.push(obj);
	})

	if(confirm("해당 유저의 상태를 [" + set_state + "]로 변경하시겠습니까?") == false)
		return;
	
	let updateDto = {
		set_state : set_state,
		tdList : tdList
	}
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/report/update/all"/>', 
		type : 'post', 
		data : JSON.stringify(updateDto),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("해당 신고건들이 " + data.state + "되었습니다.");
				$(".admin-report-modal").css('display','none');
				$("body").css('overflow','visible');
				location.href = '<c:url value="/admin/report"/>';	
			}else{
				alert("해당 신고를 처리하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});
	
	
})

</script>



<!-- 멘토링 상세화면 출력 -->
<script type="text/javascript">
$(document).on('click', '.mentoring-link', function(){
	let ment_num = 1;

	   $(".apply-mentoring-modal").css('display','block');
	   //출력
		getMentoring(ment_num);
		function getMentoring(ment_num){
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : "<c:url value="/mentor/detail"/>", 
				type : 'post', 
				data : {
					ment_num : ment_num
				},
				dataType :"json", 
				success : function (data){
					displayMentoringDetail(data.mentoring, data.mentor);
				}, 
				error : function(jqXHR, textStatus, errorThrown){
				}
			});	//ajax end
		}	//getMentoring(ment_num); end
		
		/* 멘토링 모집 글 상세 출력 */
		function displayMentoringDetail(mentoring, mentor) {
			let str="";
			
			if(mentoring == null || mentor == null){
				str += `<h1>등록되지 않은 멘토링 정보입니다.<h1>`;
			}
			
			//마감일 데이터포맷
			let dateString = convertDate(mentoring.ment_duration);
			
			//직무, 경력, 포토폴리오가 없을 경우 출력 메세지 설정
			
			str += 
				`
		      	<div class="apply-mentoring_header">
		      		<div class="header-title"><h1>멘토링 소개</h1></div>
		      	</div>
		      	<div class="apply-mentoring_body">
		      		<div class="apply-mentoring_body_info_header">
	      				<div class="memberInfo" >
							<img class="basic-profile" value="\${mentor.mentIf_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
							<a href="<c:url value="/mypage/profile?me_id=\${mentor.mentIf_me_id}"/>" class="memberNickname" value="\${mentor.mentIf_me_id}">\${mentor.mentIf_me_nickname} </a>
						</div>
		      		</div>
		      		<h1>\${mentoring.ment_title}</h1>
		      		<div class="apply-mentoring_body_info_list">
		      			<ul>
		      				<li>직무 : \${mentor.mentIf_ment_job}</li>
		      				<li>경력 : \${mentor.mentIf_date}년</li>
		      				<li>포토폴리오 : \${mentor.mentIf_portfolio}</li>
		      			</ul>
		      		</div>
		      		<div class="apply-box-border-line"><div class="apply-border-line"></div></div>
		      		<div class="apply-mentoring_body_content">
		      			<div>\${mentoring.ment_content}</div>
		      		</div>
		      	</div>
		      	<div class="apply-mentoring_footer">
					<div class="apply-due">종료일 : \${dateString}</div>
					
				</div>
				`
			$('.apply-mentoring_box').html(str);
		}//displayMentoringDetail(); end
		
		//날짜 변경 함수
		function convertDate(milliSecond) {
		  const days = ['일', '월', '화', '수', '목', '금', '토'];
		  const data = new Date(milliSecond);  //Date객체 생성

		  const year = data.getFullYear();    //0000년 가져오기
		  const month = data.getMonth() + 1;  //월은 0부터 시작하니 +1하기
		  const date = data.getDate();        //일자 가져오기
		  const day = days[data.getDay()];    //요일 가져오기

		//  return `${year}.${month}.${date}. (${day})`;
		  return `\${year}.\${month}.\${date}`;
		}
	   
})


</script>
</body>
</html>