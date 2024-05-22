<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/mentoringdetailpage.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
</head>
<body>
	<div class="apply-mentoring_header">
  		<div class="header-title">
  			<h3>${mentoring.ment_title}</h3>
  		</div>
  	</div>
  	<div class="member-btn-box">
	  	<div class="memberInfo" >
			<img class="basic-profile" value="${mentorInfo.mentIf_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
			<a href="<c:url value="/mypage/profile?me_id=${mentorInfo.mentIf_me_id}"/>" class="mentor-nickname" value="${mentorInfo.mentIf_me_id}">${mentorInfo.mentIf_me_nickname}</a>
	  	</div>
	  	<div class="btn-box">
			<!-- 본인 글일 경우 신고기능 비활성화 -->
			<c:if test="${mentorInfo.mentIf_me_id != user.me_id}">
				<div class="report-btn-box">
					<input type="hidden" class="report-isture" value="${istrue}">
					<button class="report-btn">
						<img src="<c:url value="/resources/img/siren_icon.svg" />" alt="사이렌아이콘" width="24" class="siren-icon">
					</button>
				</div>
			</c:if>
			<div class="like-btn-box">
				<input type="hidden" class="ment_num" value="${mentoring.ment_num}">
				<input type="hidden" class="reco_ment_count" value="${reco_ment_count.reco_ment_count}">
				<input type="hidden" class="report-isture" value="${istrue}">
				<button type="button" id="btnUp" data-state="1" class="like-btn btn-up">
					<img src="<c:url value="/resources/img/like_icon.svg" />" alt="라이크아이콘" width="24" class="like-icon">
					<span class="init-like">${reco_ment_count.reco_ment_count}</span>
				</button>
			</div>				
		</div>
  	</div>
	<hr>
	<div class="mentoring_body_info_list">
		<ul class="mentoring-inputList">
			<li class="mentoring-listItem">
				<label for="ment_job" class="inputbox-labelText">직무</label>
				<span id="ment_job" class="inputbox-input">${mentorInfo.mentIf_ment_job}</span>
			</li>
			<li class="mentoring-listItem">
				<label for="ment_exp" class="inputbox-labelText">경력</label>
				<span class="inputbox-input" id="ment_exp">${mentorInfo.mentIf_exp}년</span>
			</li>
		</ul>
		<ul class="mentoring-inputList">
			<li class="mentoring-listItem">
				<label for="ment_portfolio" class="inputbox-labelText">포트폴리오</label>
				<span class="inputbox-input" id="ment_portfolio">${mentorInfo.mentIf_portfolio}</span>
			</li>
			<li class="mentoring-listItem">
				<label for="ment_duration" class="inputbox-labelText">종료일</label>
				<span class="inputbox-input" id="ment_duration">
					<fmt:formatDate value="${mentoring.ment_duration}" pattern="yyyy-MM-dd" />
				</span>
			</li>
		</ul>
	</div>
	<div class="mentoring_body_content">
		<div class="mentoring-content-title">멘토링 소개</div>
		<div class="inputbox-input mentoring-content" id="ment_content">${mentoring.ment_content}</div>
	</div>
	
	<!-- 신고화면 -->
   <div id="modal-report" class="modal-report" style="display:none;">
		<div id="dimmed-report" class="dimmed-report"></div>
		<div class="report-container">
			<div class="report-box">
			</div>
		</div>
   </div>
	
<script type="text/javascript">

$(document).on('click', '#dimmed-report', function(){
   $("#modal-report").css('display','none');
   $("body").css('overflow','visible');
})
	   
/* 신고 버튼 이벤트 */
$('.report-btn').click(function(){
	
	$("#modal-report").css('display','block');
	$("body").css('overflow','hidden');
	
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
	let ment_num = $('.ment_num').val();
   //출력
	insertReport(ment_num);
});

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
});

</script>

<!-- 좋아요 이벤트 -->
<script type="text/javascript">
$('.btn-up').click(function() {
	
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