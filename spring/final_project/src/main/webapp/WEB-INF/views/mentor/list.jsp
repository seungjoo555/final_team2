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
<body>
<div class="container">
	<!-- 검색창 -->
	<div class="menu-bar">
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
	
   <!-- 상세화면 -->
   <div id="modal" class="modal apply-mentoring-modal" style="display:none;">
      <div id="dimmed" class="dimmed apply-mentoring-dimmend"></div>
      <div class="apply-mentoring_container">
      	<div class="apply-mentoring_box">
      	</div>
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
	getMentoing(ment_num);
	function getMentoing(ment_num){
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
	}	//getMentoing(ment_num); end
	
	/* 멘토링 모집 글 상세 출력 */
	function displayMentoringDetail(mentoring, mentor) {
		let str="";
		
		if(mentoring == null || mentor == null){
			str += `<h1>등록되지 않은 멘토링 정보입니다.<h1>`;
		}
		
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
						<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
						<div class="memberNickname">\${mentor.mentIf_me_nickname} </div>
						<img class="more-Menu" style="width: 15px; height: 20px;" src="<c:url value="/resources/img/more.png"/>">
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

/* dimmed 클릭 시 창 없애기 */
$(document).on('click', '#dimmed', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})
/* X 클릭 시 창 없애기 */
$(document).on('click', '.btn-cancel', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})


</script>

<script type="text/javascript">

/* 신청 창 */
$(document).on('click', '.btn-apply', function(){
	let ment_num = $('.btn-apply').val();
	getMentoingApply(ment_num);
	function getMentoingApply(ment_num){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/mentor/apply"/>", 
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
	}	//getMentoingApply(ment_num); end
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
  
})
/* 신청버튼 이벤트 */
$(document).on('click', '.btn-apply-insert', function(){
   //$(".form-apply").submit();
   //alert("신청하기");
   
	//서버에 보낼 데이터 생성
	//빈 값 들어옴...
	let mentoApVO = {
		mentAp_ment_num : $("#mentAp_ment_num").val(),
		mentAp_contact :  $("#mentAp_contact").val(),
		mentAp_content :  $("#mentAp_content").val()
			
	}
	console.log(mentoApVO);
	/*
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/mentor/apply"/>', 
		type : 'post', 
		data : JSON.stringify(comment), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("댓글을 등록했습니다.");
				$('.textarea-comment').val('');
				cri.page = 1;
				getCommentList(cri);
			}else{
				alert("댓글을 등록하지 못했습니다.");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});*/
})
</script>


</body>
</html>