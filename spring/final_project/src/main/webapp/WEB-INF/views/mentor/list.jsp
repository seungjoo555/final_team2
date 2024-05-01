<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토링 리스트</title>
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/mentorlist.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/mentoringdetail.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
<body>
<div class="container">
	<!-- 검색창 -->
	<div class="menu-bar">
		<div class="mentor mentor-insert">
			<c:if test="${user.me_ma_auth == '일반'}">
				<a class="btn-outline-success mentor-insert" href="<c:url value="/mentor/apply"/>">멘토 신청하기</a>
			</c:if>
			<c:if test="${user.me_ma_auth == '멘토'}">
				<a class="btn-outline-success mentor-mentoring-insert" href="<c:url value="/mentor/mentoring/insert"/>">멘토링 열기</a>
			</c:if>
		</div>
		<form action="<c:url value='/mentor/list'/>" method="get" id="searchForm" onsubmit="return false;">
			<div class="input-group" id="input-group">
				<input   class="form-control" type="text" placeholder="검색어를 입력하세요" name="mento-totalsearch" id="mento-totalsearch" onkeypress=""> 
				<input type="hidden" name="page" value="1">
				<button type="button" class="btn btn-outline-dark" id="mento-totalsearch-btn">
					<img alt="검색" src="<c:url value="/resources/img/search_icon.svg"/>">
				</button>
			</div>
			<div class="check-group" id="check-group" >
				<!-- for문으로 mentor-job 출력하기 -->
				<c:forEach var="job" items="${jobList }" >
					<div class="check_wrap">
						<input type="checkbox" id="check_input_${job.ment_job}"  class="check-input" onclick='getCheckboxValue(event)' value="${job.ment_job}" />
						<label for="check_input_${job.ment_job}"><span>${job.ment_job}</span></label>
					</div>
				</c:forEach>
			
			</div>
		</form>
	</div>

	<!-- 리스트 -->
	<div class="box-mento-list">
		<ul class="mento-list"></ul>
	</div>
	<!-- 페이지네이션 -->
	<div class="box-pagination">
		<ul class="pagination justify-content-center"></ul>
	</div>
	
	
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

<!-- 리스트 출력 -->
<script type="text/javascript">
	let cri = {
			page : 1,
			type : "",
			search : "",
			jobList :[]
	}
	getMentoList(cri);
	function getMentoList(cri){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/mentor/list"/>", 
			type : 'post', 
			data : JSON.stringify(cri),
			//서버로 보낼 데이터 타입
			contentType : "application/json; charset=utf-8",
			//서버에서 보낸 데이터의 타입
			dataType :"json", 
			success : function (data){
				displayMentoList(data.list);
				displayMentoPagination(data.pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	//ajax and
	}	//getGroupList(cri); end

	//리스트 출력 함수
	function displayMentoList(list){
		let str = '';
		if(list == null || list.length == 0){
			str = '<h3>등록된 모임이 없습니다.</h3>';
			$('.mento-list').html(str);
			return;	
		}
		
		
		for(mentoing of list){
			
			str +=
				`
				<!-- 게시글 정보 링크 -->
				<a class="mento-item" data-num="\${mentoing.ment_num}">
					<li>
						<!--그룹 모집 내용-->
						<div class="mento-list-item-content">
							<h3 class="mento-list-item-title">\${mentoing.ment_title }</h3>
							<!-- 멘토 직무 -->
							<div class="mento-list-item-contentList">
								직무 : \${mentoing.ment_mentIf_job}
							</div>
							<!-- 멘토 경력 -->
							<div class="mento-list-item-languageList">
								경력 : \${mentoing.ment_mentIf_exp}년
							</div>
						</div>
						
						<!-- 구분선 -->
						<div class="box-border-line"><div class="border-line"></div></div>
						<div class="mento-list-item-memberInfo" >
							<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
							<div class="memberNickname">\${mentoing.ment_me_nickname } </div>
							<div class="mentoSituation">0</div>
						</div>
					</li>
				</a>
				`
				//</ul>
		}	//for end
		$('.mento-list').html(str);
	} //displayGroupList() end;
	
	//페이지네이션
	function displayMentoPagination(pm){
		let str = '';
		if(pm.prev){
			str +=
				`<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.startPage - 1}" >이전</a>
			    </li>`;
		}
		
		for(let i = pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active':'';
			str +=
				`
				 <li class="page-item \${active}">
				 	<a class="page-link" href="javascript:void(0)" data-page="\${i}" >\${i}</a>
			    </li>				
				`;
		}
		
		if(pm.next){
			str +=
				`
				<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.endPage + 1}" >다음</a>
			    </li>				
				`;
		}
		$('.box-pagination>ul').html(str);
	}	//displayGroupPagination() end
	
	//페이지네이션 클릭이벤트
	$(document).on('click', '.box-pagination .page-link', function(){
		cri.page = $(this).data('page');
		getMentoList(cri);
	})
	
	
</script>

<!-- 분야 선택 이벤트 -->
<script type="text/javascript">
function getCheckboxValue(event)  {
	var arr =  [];
	cri.jobList = getCheckInput(arr);
	cri.page = 1;
	getMentoList(cri);
}

function getCheckInput(arr) {
	$(".check-input").each(function(){
		if($(this).prop("checked")){
			arr.push({ ment_job: $(this).val()});	  
		}  
	})
	return arr;
}
</script>

<!-- 검색 창 이벤트 -->
<script type="text/javascript">
$(document).on('click', '#mento-totalsearch-btn', function(){
	search();
})
$(document).on('keyup', '#mento-totalsearch', function(){
	if(event.keyCode === 13){
	search();
	}
})

function search() {
	cri.page = 1;
	cri.search = $("#mento-totalsearch").val();
	getMentoList(cri);
}



</script>


<!-- ============================================멘토링 글 상세 ================================================================ -->

<script type="text/javascript">
/* 아이템 클릭 이벤트 - 상세 화면 */
$(document).on('click', '.mento-item', function(event){
   let ment_num = $(this).data("num");

   $("#modal").css('display','block');
   //스크롤 비활성화
   $("body").css('overflow','hidden');
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
	      		<div class="btn-cancel"> <button>X</button> </div>
	      	</div>
	      	<div class="apply-mentoring_body">
	      		<div class="apply-mentoring_body_info_header">
      				<div class="memberInfo" >
						<img class="basic-profile" value="\${mentor.mentIf_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
						<a href="<c:url value="/mypage/profile?me_id=\${mentor.mentIf_me_id}"/>" class="memberNickname" value="\${mentor.mentIf_me_id}">\${mentor.mentIf_me_nickname} </a>
						<div class="report-btn-box"><button class="report-btn">신고</button></div>
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
				<div class="btn-apply-box"><button type="button" class="btn-apply" value="\${mentoring.ment_num}">신청하기</button></div>
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
	
   $(".modal-report").css('display','block');
	let ment_num = $('.btn-apply').val();
   //출력
	insertReport(ment_num);
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

})

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
		url : '<c:url value="/reportr"/>', 
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
})
	
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
	
	function getMentoring(ment_num){
		console.log("함수");
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
	
	function displayMentoringDetail(mentoring, mentor) {
		let str="";
		
		if(mentoring == null || mentor == null){
			str += `<h1>등록되지 않은 멘토링 정보입니다.<h1>`;
		}
		
		str += 
			`
	      	<div class="apply-mentoring_header">
	      		<div class="header-title"><h1>멘토링 소개</h1></div>
	      		<div class="btn-cancel"> <button>X</button> </div>
	      	</div>
	      	<div class="apply-mentoring_body">
	      		<div class="apply-mentoring_body_info_header">
      				<div class="memberInfo" >
						<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
						<div class="memberNickname">\${mentor.mentIf_me_nickname} </div>
						<div class="report-box"><button class="report-btn">신고</button></div>
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
				<div class="apply-due">종료일 : \${mentoring.ment_duration}</div>
				<div class="btn-apply-box"><button type="button" class="btn-apply" value="\${mentoring.ment_num}">신청하기</button></div>
			</div>
			`
		$('.apply-mentoring_box').html(str);
	}//displayMentoringDetail(); end
   
	
})
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
})
</script>



</body>
</html>