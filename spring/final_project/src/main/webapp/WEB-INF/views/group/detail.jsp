<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/recruitinsert.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
</head>
<body>
<div class="container">
	<div class="first-container">
		<a href="<c:url value="/group/list"/>">
			<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" color="808080" 
				cursor="pointer" height="30" width="30" xmlns="http://www.w3.org/2000/svg" style="color: rgb(128, 128, 128);">
				<path d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path>
			</svg>
		</a>
		<div class="recruit_topic">${recruit.recu_topic}(${recruit.recu_state == 1 ? "모집중":"모집 완료"})</div>
		<div class="recruit_userAndDate">
			<img class="basic-profile" value="${groupKing_me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
			<a href="<c:url value="/mypage/profile?me_id=${groupKing_me_id}"/>" class="recruit_user">${groupKing}</a>
			<div class="btn-box">
				<!-- 본인 글일 경우 신고기능 비활성화 -->
				<c:if test="${groupKing_me_id != user.me_id}">
					<div class="report-btn-box">
						<input type="hidden" class="report-isture" value="${istrue}">
						<button class="report-btn">
							<img src="<c:url value="/resources/img/siren_icon.svg" />" alt="사이렌아이콘" width="24" class="siren-icon">
						</button>
					</div>
				</c:if>
				<div class="like-btn-box">
					<input type="hidden" class="reco_recu_num" value="${recruit.recu_num}">
					<input type="hidden" class="reco_recu_count" value="${reco_recu_count.reco_recu_count}">
					<button type="button" id="btnUp" data-state="1" class="like-btn btn-up">
						<img src="<c:url value="/resources/img/like_icon.svg" />" alt="라이크아이콘" width="24" class="like-icon">
						<span class="init-like">${reco_recu_count.reco_recu_count}</span>
					</button>
				</div>				
			</div>
			<!-- <div class="recruit_regDate">날짜</div> -->
		</div>
		<hr>		
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_type" class="inputbox-lableText">모집 구분</label>
				<span id="recu_type" class="inputbox-input">${recruit.recu_type == 0? "스터디":"프로젝트"}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_count" class="inputbox-lableText">모집 인원</label>
				<span class="inputbox-input" id="recu_count">${recruit.recu_count}명</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_online" class="inputbox-lableText">온·오프라인 여부</label>
				<span id="recu_online" class="inputbox-input">
					<c:choose>
						<c:when test="${recruit.recu_online == 0}">온라인</c:when>
						<c:when test="${recruit.recu_online == 1}">오프라인</c:when>
						<c:otherwise>온/오프라인 병행</c:otherwise>
					</c:choose>
				</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_target" class="inputbox-lableText">그룹 목적</label>
				<span class="inputbox-input" id="recu_target">${recruit.recu_target}</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_required" class="inputbox-lableText">필수 자격</label>
				<span class="inputbox-input" id="recu_required">${recruit.recu_required}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_due" class="inputbox-lableText">모집 마감일</label>
				<span class="inputbox-input" id="recu_due">
					<fmt:formatDate value="${recruit.recu_due}" pattern="yyyy-MM-dd" />
				</span>
			</li>
		</ul>
		<ul class="recruit-inputList">
			<li class="recruit-listItem">
				<label for="recu_preferred" class="inputbox-lableText">선호 자격</label>
				<span class="inputbox-input" id="recu_preferred">${recruit.recu_preferred}</span>
			</li>
			<li class="recruit-listItem">
				<label for="recu_interview" class="inputbox-lableText">면접 여부</label>
				<span id="recu_interview" class="inputbox-input">${recruit.recu_interview == 1 ? "아니요":"예"}</span>
			</li>
		</ul>
		<div class="recruit-inputList">
			<li class="recruit-cateLang">
				<span class="recruit-spancateLang">모집 분야</span>
				<ul class="recruit-cateLangList">
					<c:forEach items="${totalCategory}" var="cate">
						<li class="recruit-position">${cate.toCt_progCt_name}</li>
					</c:forEach>
				</ul>
			</li>
			<li class="recruit-cateLang">
				<span class="recruit-spancateLang">사용 언어</span>
				<ul class="recruit-cateLangList">
					<c:forEach items="${totalLanguage}" var="lang">
						<li class="recruit-position">${lang.toLg_lang_name}</li>
					</c:forEach>
				</ul>
			</li>
		</div>
	</div>
	<div class="second-container">
		<h4>프로젝트 소개</h4>
		<hr>
		<section>
			<div class="form-row content">
				<textarea rows="15" class="form-control second-box" id="recu_content">${recruit.recu_content}</textarea>
			</div>
		</section>
	</div>
	<c:if test="${groupKing_me_id != user.me_id}">
		<a class="btn btn-success col-12 mt-5" href="<c:url value="/group/apply?num=${recruit.recu_num}"/>">지원하기</a>
	</c:if>

   <!--------------------------- 신고화면 --------------------------->
   <div id="modal-report" class="modal-report report-modal" style="display:none;">
		<div id="dimmed-report" class="dimmed-report report-dimmend"></div>
		<div class="report-container">
			<div class="report-box">
			<div class="report-header">
		     		<div class="header-title"><h1>신고하기</h1></div>
		     	</div>
			<form action="<c:url value="/report/group"/>"  method="post" class="form-report">
				<div class="report-body">
						<div class="report-form-group">
							<label for="report-content">신고유형</label>
							<select class="input-box-input report-content" id="report-content" name="report-content">
								<c:forEach var="content" items="${contentList }">
									<option value="${content.repo_content }">${content.repo_content }</option>
								</c:forEach>
							</select>
						</div>
						<div class="report-form-group">
							<label for="report-detail">신고내용</label>
							<textarea class="form-control report-detail" id="report-detail" name="report-detail"></textarea>
						</div>
				</div>
				<div class="report-footer">
					<div class="btn-report-box">
						<button type="button" class="btn-report-insert"class="btn-report-insert">신고하기</button>
					</div>
				</div>
			</form>
			</div>
		</div>
   </div>
	
	
</div>


<!-- 신고 이벤트 -->
<script type="text/javascript">

/* 신고 팝업 */
$(document).on('click', '.report-btn', function(){
	if(${user == null}){
		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?") == true){
			location.href = '<c:url value="/login"/>';			
		}else{
			return false;
		}
	}
	
	if(${user.me_verify ==0}){
		alert("이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.");
		location.href = '<c:url value="/signup/verify"/>';
		return false;
	}
	
	if(${user.me_temppw==1}){
		alert("임시 비밀번호를 변경하셔야 사이트 이용이 정상적으로 가능합니다.");
		location.href = '<c:url value="/login/changepwtemp"/>';
		return false;
	}
	
	//만약 신고내역이 이미 있다면
	if($(".report-isture").val() =='false'){
		alert("이미 신고한 게시글입니다.");
		return;
	}
	
	//스크롤 비활성화
	$("body").css('overflow','hidden');
	$("#modal-report").css('display','block');
})

/* 그룹 모집글 신고하기 */
$(document).on('click', '.btn-report-insert', function(){
	
	//서버에 보낼 데이터 생성
	let ReportVO = {
		repo_repo_content : $("select[name=report-content] option:selected").val(),
		repo_detail :  $("#report-detail").val(),
		repo_table : "recruit",
		repo_target : ${recruit.recu_num}
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
				alert("해당 모집글을 신고했습니다.");
			    $(".report-modal").css('display','none');
			   	$("body").css('overflow','visible');
			   	location.href = '<c:url value="/group/detail"/>';			
			}else{
				alert("모집글을 신고하지 못했습니다.");
			}
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
			console.log(jqXHR);
			console.log(textStatus);
		}
	});
	
})

/* dimmed 클릭 시 창 없애기 */
$(document).on('click', '#dimmed-report', function(){
   $("#modal-report").css('display','none');
   $("body").css('overflow','visible');
})
</script>

<!-- 좋아요 이벤트 -->
<script type="text/javascript">
	$('.btn-up').click(function() {
		if(${user == null}){
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?") == true){
				location.href = '<c:url value="/login"/>';			
			}else{
				return false;
			}
		}
		
		if(${user.me_verify ==0}){
			alert("이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.");
			location.href = '<c:url value="/signup/verify"/>';
			return false;
		}
		
		if(${user.me_temppw==1}){
			alert("임시 비밀번호를 변경하셔야 사이트 이용이 정상적으로 가능합니다.");
			location.href = '<c:url value="/login/changepwtemp"/>';
			return false;
		}
		
		let recu_num = $(".reco_recu_num").val();
		let recommend = {
				recu_num : recu_num
		}
		
		$.ajax({
			async : true,
			url : '<c:url value="/group/recommend"/>', 
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
		let recu_num = $(".reco_recu_num").val();
		let reco_recu_count = $(".reco_recu_count").val();
		let recommend = {
				recu_num : recu_num,
				reco_recu_count : reco_recu_count
		}
		
		$.ajax({
			url : '<c:url value="/group/recommend"/>',
			method : "get",
			data : recommend,
			success: function (data){
				
				let count = parseInt(data.reco_recu_count);
				$('.init-like').text(count);
				
			}, 
			error : function(a, b, c){
				console.log("실패");
			}
		})
	}
</script>
</body>
</html>