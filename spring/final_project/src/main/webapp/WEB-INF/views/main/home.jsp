<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	<link rel="stylesheet" href="<c:url value="/resources/css/home.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/grouplist.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/mentorlist.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/mentoringdetail.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
</head>
<body>

<div class="container">
	
	<div class="box-banner">
		<img alt="배너" src="<c:url value="/resources/img/banner.svg"/>">
	</div>
	<div class="box-group-hot">
		<h2>HOT 스터디/프로젝트</h2>
		<div class="box-group-list">
			<ul class="group-list">
				<c:if test="${hotGroupList.isEmpty()}">
					<h3>등록된 스터디/프로젝트가 없습니다.</h3>
				</c:if>
				<c:forEach items="${hotGroupList}" var="group">
					<a class="group-item" href="<c:url value="/group/detail?num=${group.recu_num}"/>">
						<li>
							<!-- 프로젝트/스터디 구분 -->
							<div class="group-list-item-category" >
								<div class="item-category">
									<c:if test="${group.recu_type == 0}">
										스터디
									</c:if>
									<c:if test="${group.recu_type == 1}">
										프로젝트
									</c:if>
								</div>
							</div>
							<!-- 마감일 -->
							<div class="group-list-item-schedule">
								<p>마감일 |
									<fmt:formatDate value="${group.recu_due}" pattern="yyyy-MM-dd" />
								</p>
							</div>
							<div class="group-list-item-content">
								<!-- 그룹 모집 제목 -->
								<h3 class="group-list-item-title">${group.recu_topic}</h3>
								<!-- 분야 리스트 -->
								<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
									<c:forEach items="${totalCategory}" var="cate">
										<c:if test="${group.recu_num == cate.toCt_table_pk}">
											<ul class="cate-list">
												<li class="cate-list-item">${cate.toCt_progCt_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
								<!-- 사용언어 -->
								<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
									<c:forEach items="${totalLanguage}" var="lang">
										<c:if test="${group.recu_num == lang.toLg_table_pk}">
											<ul class="lang-list">
												<li class="lang-list-item">${lang.toLg_lang_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<!-- 구분선 -->
							<div class="box-border-line"><div class="border-line"></div></div>
							<div class="group-list-item-memberInfo" >
								<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
								<div class="memberNickname">${group.recu_gome_me_nickname } </div>
								<div class="groupSituation">
									<c:if test="${group.recu_state == 0}">
										모집완료
									</c:if>
									<c:if test="${group.recu_state == 1}">
										모집중
									</c:if>
										
								</div>
							</div>
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div class="box-group-hot">
		<h2>추천 멘토</h2>
		<div class="box-mento-list">
			<ul class="mento-list">
				<c:if test="${hotMentoingList.isEmpty()}">
					<h3>등록된 멘토링 모집글이 없습니다.</h3>
				</c:if>
				<c:forEach items="${hotMentoingList }" var="mentoing">
					<a class="mento-item" data-num="${mentoing.ment_num}">
						<li>
							<!--그룹 모집 내용-->
							<div class="mento-list-item-content">
								<h3 class="mento-list-item-title">${mentoing.ment_title }</h3>
								<!-- 멘토 직무 -->
								<div class="mento-list-item-contentList">
									직무 : ${mentoing.ment_mentIf_job}
								</div>
								<!-- 멘토 경력 -->
								<div class="mento-list-item-languageList">
									경력 : ${mentoing.ment_mentIf_exp}년
								</div>
							</div>
							
							<!-- 구분선 -->
							<div class="box-border-line"><div class="border-line"></div></div>
							<div class="mento-list-item-memberInfo" >
								<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
								<div class="memberNickname">${mentoing.ment_me_nickname } </div>
								<div class="mentoSituation">
									<c:if test="${mentoing.ment_state == 1}">
										모집중
									</c:if>
									<c:if test="${mentoing.ment_state == 0}">
										모집완료
									</c:if>
								</div>
							</div>
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="box-group-hot">
		<h2>인기 강의</h2>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>강의 제목</th>
					<th>강의 등록멘토</th>
					<th>강의 가격</th>
					<th>강의 게시일</th>
					<th>강의 업데이트일</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${hotLectureList.isEmpty()}">
				<h3>등록된 강의가 없습니다.</h3>
			</c:if>
		<c:forEach items="${hotLectureList}" var="lecture">
			<tr>
				<td>
					<c:url value="/lecture/detail" var="url">
						<c:param name="page" value="1"/>
						<c:param name="type" value="all"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="lectNum" value="${lecture.lect_num}"/>
					</c:url>
					<a href="${url}">${lecture.lect_name}</a>
				</td>
				<td>
					<c:url value="/lecture/list" var="url">
						<c:param name="type" value="writer"/>
						<c:param name="search" value="${lecture.lect_mentIf_me_id}"/>
					</c:url>
					<a href="${url}">${lecture.lect_mentIf_me_id}</a>
				</td>
				<td>${lecture.lect_price}</td>
				<td>${lecture.lect_posting}</td>
				<td>${lecture.lect_update}</td>
			</tr>
		</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 멘토링 상세 페이지 -->
	 <!-- 신고화면 -->
	   <div id="modal-report" class="modal-report" style="display:none;">
			<div id="dimmed-report" class="dimmed-report"></div>
			<div class="report-container">
				<div class="report-box">
				</div>
			</div>
	   </div>
	   <!-- 상세화면 -->
	   <div id="modal" class="modal apply-mentoring-modal" style="display:none;">
	      <div id="dimmed" class="dimmed apply-mentoring-dimmend"></div>
	      <div class="apply-mentoring_container">
	      	<div class="apply-mentoring_box"></div>
	      </div>
	   </div>
	
</div>







<script type="text/javascript">

$(document).ready(function() {
	$('.cate-container').on('click', function(event) {
		event.preventDefault();
	});
});

let isDragging = false;
let startPosition = 0;
let startScrollPosition = 0;

function startDragging(event) {
    isDragging = true;
    startPosition = event.clientX;
    startScrollPosition = event.currentTarget.scrollLeft;
    event.currentTarget.style.cursor = 'grabbing'; /* 드래그 중일 때의 커서 모양 설정 */
}

function stopDragging(event) {
    isDragging = false;
    event.currentTarget.style.cursor = 'grab'; /* 드래그 종료 후 커서 모양 설정 */
}

function dragging(event) {
    if (isDragging) {
        const deltaX = event.clientX - startPosition;
        event.currentTarget.scrollLeft = startScrollPosition - deltaX;
    }
}

$(document).ready(function() {
	$('.lang-container').on('click', function(event) {
		event.preventDefault();
	});
});
</script>

<!-- ========================================멘토링 상세================================================= -->

<script type="text/javascript">
/* 아이템 클릭 이벤트 - 상세 화면 */
$(document).on('click', '.mento-item', function(event){
   let ment_num = $(this).data("num");

   $("#modal").css('display','block');
   //스크롤 비활성화
   $("body").css('overflow','hidden');
   //출력
	getMentoring(ment_num);
   
})
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
			displayMentoringDetail(data.mentoring, data.mentor, data.istrue, data.reco_ment_count);
		}, 
		error : function(jqXHR, textStatus, errorThrown){
		}
	});	//ajax end
}	//getMentoring(ment_num); end

/* 멘토링 모집 글 상세 출력 */
function displayMentoringDetail(mentoring, mentor, istrue, reco_ment_count) {

	let str="";
	
	if(mentoring == null || mentor == null || reco_ment_count == null){
		str += `<h1>등록되지 않은 멘토링 정보입니다.<h1>`;
	}
	
	//본인 글일 경우 신고를 숨기고 삭제, 수정 버튼 추가
	//모집완료일 경우 신청버튼 숨기기 & 본인 글일 경우 모집종료 버튼 추가<?
	let meStr = '', reportStr = '';
	if(mentor.mentIf_me_id == $("[name=user-meId]").val()){
		meStr += 
			`
			
			<button class="update-btn" >
				<a class="btn-outline-success mentor-mentoring-update" 
				href="<c:url value="/mentor/mentoring/update?mentNum=\${mentoring.ment_num}"/>">수정</a>
			</button>	
			<button class="delete-btn">
				<a class="btn-outline-success mentor-mentoring-delete" 
					href="<c:url value="/mentor/mentoring/delete?mentNum=\${mentoring.ment_num}"/>">삭제</a>
			</button>
			`
		
	}else{
		reportStr +=
			`
			<button class="report-btn">
				<img src="<c:url value="/resources/img/siren_icon.svg" />" alt="사이렌아이콘" width="24" class="siren-icon">
			</button>
			`
		meStr +=
			`

			<input type="hidden" class="report-isture" value="\${istrue}">
			<div class="btn-apply-box"><button type="button" class="btn-apply" value="\${mentoring.ment_num}">신청하기</button></div>
			`
	}
	
	
	//마감일 데이터포맷
	let dateString = convertDate(mentoring.ment_duration);
	
	//직무, 경력, 포토폴리오가 없을 경우 출력 메세지 설정
	str += 
		`
      	<div class="apply-mentoring_header">
      		<div class="header-title"><h1>멘토링 소개</h1></div>
      		<div class="btn-cancel"> <button>X</button> </div>
      	</div>
      	<div class="apply-mentoring_body">
      		<div class="apply-mentoring_body_info_header">
     				<div class="memberInfo" >
					<img class="basic-profile" value="\${mentor.mentIf_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
					<a href="<c:url value="/mypage/profile?me_id=\${mentor.mentIf_me_id}"/>" class="memberNickname" value="\${mentor.mentIf_me_id}">\${mentor.mentIf_me_nickname} </a>
					<div class="report-btn-box">
		`
		+
		reportStr
		+
		`
					</div>
					<div class="like-btn-box">
						<input type="hidden" class="ment_num" value="\${mentoring.ment_num}">
						<input type="hidden" class="reco_ment_count" value="\${reco_ment_count.reco_ment_count}">
						<button type="button" id="btnUp" data-state="1" class="like-btn btn-up">
							<img src="<c:url value="/resources/img/like_icon.svg" />" alt="라이크아이콘" width="24" class="like-icon">
							<span class="init-like">\${reco_ment_count.reco_ment_count}</span>
						</button>
					</div>			
				</div>
      		</div>
      		<h1>\${mentoring.ment_title}</h1>
      		<div class="apply-mentoring_body_info_list">
      			<ul>
      				<li>직무 : \${mentor.mentIf_ment_job}</li>
      				<li>경력 : \${mentor.mentIf_exp}년</li>
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
		`
		+
		meStr
		+
		`
			
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

/* dimmed 클릭 시 창 없애기 */
$(document).on('click', '#dimmed', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})
$(document).on('click', '#dimmed-report', function(){
   $("#modal-report").css('display','none');
})
/* X 클릭 시 창 없애기 */
$(document).on('click', '.btn-cancel', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})


</script>
<!--========================================== 신고 기능 구현 ==========================================-->
<script type="text/javascript">
/* 신고 버튼 이벤트 */
$(document).on('click', '.report-btn', function(){
	
	if(${user == null}){
		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?") == true){
			location.href = '<c:url value="/login"/>';			
		}else{
			return false;
		}
	}
	
	//만약 신고내역이 이미 있다면
	if($(".report-isture").val() =='false'){
		alert("이미 신고한 게시글입니다.");
		return;
	}
	
   $(".modal-report").css('display','block');
	let ment_num = $('.btn-apply').val();
   //출력
	insertReport(ment_num);
})

//신고화면
function insertReport(ment_num){
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : "<c:url value="/report/mentor"/>", 
		type : 'get', 
		data : {
			ment_num : ment_num
		},
		dataType :"json", 
		success : function (data){
			displayReport(data.mentoring, data.contentList);
		}, 
		error : function(jqXHR, textStatus, errorThrown){
		}
	});	//ajax end
}	//insertReport(ment_num); end
	

function displayReport(mentoring, contentList){
	let str='', cList = '';
	let content = '';
	for(var i=0; i<contentList.length; i++){
		content = contentList[i];
		cList += 
			`
			<option value="\${content.repo_content}">\${content.repo_content}</option>
			`
	}
	
	str = 
		`
		<div class="report-header">
	     		<div class="header-title"><h1>신고하기</h1></div>
	     		
	     	</div>
		<div class="report-body">
			<form action="<c:url value="/report/mentor"/>"  method="post" class="form-report">
				<input type="hidden" id="ment_num" value="\${mentoring.ment_num}">
				<div class="report-form-group">
					<label for="report-content">신고유형</label>
					<select class="input-box-input report-content" id="report-content" name="report-content">
		`
		+ cList +
		`
					</select>
				</div>
				<div class="report-form-group">
					<label for="report-detail">신고내용</label>
					<textarea class="form-control report-detail" id="report-detail" name="report-detail"></textarea>
				</div>
			</form>
		</div>
		<div class="report-footer">
			<div class="btn-report-box">
				<button type="button" class="btn-report-insert"class="btn-report-insert">신고하기</button>
			</div>
		</div>
		`
	$('.report-box').html(str);
}

/* 멘토링 신고하기 */

$(document).on('click', '.btn-report-insert', function(){
	
	//서버에 보낼 데이터 생성
	let ReportVO = {
		repo_repo_content : $("select[name=report-content] option:selected").val(),
		repo_detail :  $("#report-detail").val(),
		repo_table : "mentoring",
		repo_target : $("#ment_num").val()
	}
	console.log(ReportVO);
	//null 체크
	if(ReportVO.repo_repo_content.length == 0 || ReportVO.repo_detail.length == 0){
		alert("신고 사유를 입력하세요.");
		return;
	}
	
	if(confirm("정말 신고하시겠습니까?") == false)
		return;
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/report"/>', 
		type : 'post', 
		data : JSON.stringify(ReportVO), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("해당 멘토링을 신고했습니다.");
			    $(".modal-report").css('display','none');
				$("#modal").css('display','none');
			   	$("body").css('overflow','visible');
				let cri = {
						page : 1,
						type : "",
						search : "",
						jobList :[]
				}
				getMentoList(cri);
			}else{
				alert("멘토링을 신고하지 못했습니다.");
			}
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});
	
})

</script>


<!-- ======================================= 멘토링 신청 ============================================ -->
<script type="text/javascript">

/* 신청 창 */
$(document).on('click', '.btn-apply', function(){
	if(${user == null}){
		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?") == true){
			location.href = '<c:url value="/login"/>';			
		}else{
			return false;
		}
	}
	let ment_num = $('.btn-apply').val();
	getMentoringApply(ment_num);
})
function getMentoringApply(ment_num){
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : "<c:url value="/mentoring/apply"/>", 
		type : 'get', 
		data : {
			ment_num : ment_num
		},
		dataType :"json", 
		success : function (data){
			displayMentoringApply(data.mentoring);
		}, 
		error : function(jqXHR, textStatus, errorThrown){
		}
	});	//ajax end
}	//getMentoringApply(ment_num); end
	
function displayMentoringApply(mentoring){
	   let str = 
		   `
	         	<div class="apply-mentoring_header">
		      		<div class="header-title"><h1>멘토링 신청</h1></div>
		      		<div class="btn-cancel"> <button>X</button> </div>
		      	</div>
		      	<div class="apply-mentoring_body" style="overflow: hidden; height: 80%;">
			      	<!-- 폼 -->
			      	<div class="form-apply-box">
				      	<form action="<c:url value="/mentor/list"/>" method="post" class="form-apply">
							<input type="hidden" value="\${mentoring.ment_num}" id="mentAp_ment_num" name="mentAp_ment_num">
				      		<div class="mentor-apply-form-group">
								<label for="id">멘토링 명</label>
								<input type="text" readonly class="form-control apply-mentorNickname" value="\${mentoring.ment_title}" id="mentorNickname" name="mentorNickname">
							</div>
				      		<div class="mentor-apply-form-group">
								<label for="id">연락처</label>
								<input type="text" class="form-control apply-contact" id="mentAp_contact" name="mentAp_contact">
							</div>
				      		<div class="mentor-apply-form-group">
								<label for="id">신청내용</label>
								<textarea rows="11" class="form-control h-25 apply-content" id="mentAp_content" name="mentAp_content"></textarea>
							</div>
				      	</form>
			      	</div>
		      	</div>
		      	<div class="apply-mentoring_footer">
					<div class="btn-apply-box">
						<button type="button" class="btn-apply-prev">이전으로</button> 
						<button type="button" class="btn-apply-insert"class="btn-apply-insert">신청하기</button>
					</div>
				</div>
		   `
		   ;
		$('.apply-mentoring_box').html(str);
}
	
	
   



/* 이전버튼 이벤트 */
$(document).on('click', '.btn-apply-prev', function(){
	ment_num = $("#mentAp_ment_num").val();
	getMentoring(ment_num);
});

/* 신청버튼 이벤트 */
 //신청중일 때(추가필요)
$(document).on('click', '.btn-apply-insert', function(){
	//서버에 보낼 데이터 생성
	let mentoApVO = {
		mentAp_ment_num : $("#mentAp_ment_num").val(),
		mentAp_contact :  $("#mentAp_contact").val(),
		mentAp_content :  $("#mentAp_content").val()
	}
	//null 체크
	if(mentoApVO.mentAp_contact.length == 0 || mentoApVO.mentAp_content.length == 0){
		alert("신청 내용을 입력하세요.");
		return;
	}
	
	if(confirm("멘토링을 정말 신청하시겠습니까?") == false)
		return;
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/mentoring/apply"/>', 
		type : 'post', 
		data : JSON.stringify(mentoApVO), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("멘토링을 신청했습니다.");
				$("#modal").css('display','none');
			   $("body").css('overflow','visible');
				let cri = {
						page : 1,
						type : "",
						search : "",
						jobList :[]
				}
				getMentoList(cri);
			}else{
				alert("멘토링을 신청하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});
});

$(document).on('click', '.btn-up', function(){
	
	if(${user == null}){
		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?") == true){
			location.href = '<c:url value="/login"/>';			
		}else{
			return false;
		}
	}
	
	let ment_num = $('.ment_num').val();
	
	let recommend = {
			ment_num : ment_num
	}
	
	$.ajax({
		async : true,
		url : '<c:url value="/mentoring/recommend"/>', 
		type : 'post', 
		contentType: "application/json; charset=utf-8",
		data : JSON.stringify(recommend),
		dataType : "json", 
		success : function(data) {
			let result = data.result;
			if (result === 1) {
                alert('좋아요를 눌렀습니다.');
                updatevote(1);
            } else if (result === 0) {
                alert('좋아요를 취소했습니다.');
                updatevote(-1);
            } else {
                alert('알 수 없는 상태입니다.');
            }
		},
		error : function(jqXHR, textStatus, errorThrown){
		}
	});	// ajax end
	
});

function updatevote(action, data) {
	let ment_num = $('.ment_num').val();
	let reco_ment_count = $(".reco_ment_count").val();
	let recommend = {
			ment_num : ment_num,
			reco_ment_count : reco_ment_count
	}
	
	$.ajax({
		url : '<c:url value="/mentoring/recommend"/>',
		method : "get",
		data : recommend,
		success: function (data){
			let count = parseInt(data.reco_ment_count);
			$('.init-like').text(count);
		}, 
		error : function(a, b, c){
			console.log("실패");
		}
	});
}
</script>
</body>
</html>
