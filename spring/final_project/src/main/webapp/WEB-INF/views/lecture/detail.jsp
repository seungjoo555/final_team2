<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/lecture.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/report.css"/>">
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script>
        var IMP = window.IMP; 
        IMP.init("imp07347810");
        
        function requestPay() {
        	if(${user == null}){
        		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?") == true){
        			location.href = '<c:url value="/login"/>';
        			return;
        		}else{
        			return false;
        		}
        	}
            IMP.request_pay({
                pg: "kakaopay",
                pay_method: "card",
                merchant_uid: "${user.me_id}"+"lecture"+"${lecture.lect_num}",   // 주문번호
                name: "${lecture.lect_name}",
                amount: ${lecture.lect_price},                         // 숫자 타입
                buyer_email: "${user.me_id}",
                buyer_name: "${user.me_name}",
                buyer_tel: "${user.me_phone}"
            }, function (response) { // callback
            	if(response.imp_uid == null){
            		alert("이미 구매한 강의입니다.");
            		return;
            	}
            	let ornum = {
            		imp_uid : response.imp_uid
            	}
            	$.ajax({
                    type : "POST",
                    url : '<c:url value="/verify"/>',
                    data: ornum
                }).done(function(data) {
                    if(response.paid_amount == data.response.amount){
                        //결제 성공 시 비즈니스 로직
                    	$.ajax({
            				type: "post",
            				url: '<c:url value="/lecture/detail"/>',
            				data: {
            					lectRg_lect_num : ${lecture.lect_num},
            					lectRg_me_id : data.response.buyerEmail,
            					lectRg_money : data.response.amount,
            					lectRg_state : 1,
            				},
            				success : function (data){
            					if(data.result){
            						location.href='<c:url value="/lecture/register"/>';
            					}else{
            						alert('데이터베이스에 안들어감');
            					}
            				}, 
            				error : function(jqXHR, textStatus, errorThrown){
            					console.log(textStatus);
            				}
            			});
                    } else {
                        alert("결제 실패");
                    }
                });
            });
        }
    </script>
</head>
<body>

<div class="first-container">
	<a href="<c:url value="/lecture/list"/>">
		<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" color="808080" 
			cursor="pointer" height="30" width="30" xmlns="http://www.w3.org/2000/svg" style="color: rgb(128, 128, 128);">
			<path d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path>
		</svg>
	</a>
	<div class="lecture_topic">${lecture.lect_name}</div>
	<div class="lecture_userAndDate">
		<img class="basic-profile" value="${writer.me_id}"  style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
		<a href="<c:url value="/mypage/profile?me_id=${writer.me_id}"/>" class="lecture_user">${writer.me_nickname}</a>
		<div class="btn-box">
			<!-- 본인 글일 경우 신고기능 비활성화 -->
			<c:if test="${writer.me_id != user.me_id}">
				<div class="report-btn-box">
					<input type="hidden" class="report-isture" value="${istrue}">
					<button class="report-btn">
						<img src="<c:url value="/resources/img/siren_icon.svg" />" alt="사이렌아이콘" width="24" class="siren-icon">
					</button>
				</div>
			</c:if>
		</div>
		<!-- <div class="lecture_regDate">날짜</div> -->
	</div>
	<hr>		
	<ul class="lecture-inputList">
		<li class="lecture-listItem">
			<label for="recu_type" class="inputbox-lableText">강의 게시일</label>
			<span id="recu_type" class="inputbox-input">${lecture.lect_posting}</span>
		</li>
		<li class="lecture-listItem">
			<label for="recu_count" class="inputbox-lableText">최신 업데이트</label>
			<span class="inputbox-input" id="recu_count">${lecture.lect_update}</span>
		</li>
	</ul>
	<div class="lecture-inputList">
		<li class="lecture-cateLang">
			<span class="lecture-spancateLang">강의 분야</span>
			<ul class="lecture-cateLangList">
				<c:forEach items="${totalCategory}" var="cate">
					<li class="lecture-position">${cate.toCt_progCt_name}</li>
				</c:forEach>
			</ul>
		</li>
		<li class="lecture-cateLang">
			<span class="lecture-spancateLang">사용 언어,스킬</span>
			<ul class="lecture-cateLangList">
				<c:forEach items="${totalLanguage}" var="lang">
					<li class="lecture-position">${lang.toLg_lang_name}</li>
				</c:forEach>
			</ul>
		</li>
	</div>
</div>
<div class="cd-floating__price cd-floating__price--dis">
	<p class="cd-price__discount-rate"><!-- 할인율 --></p>
	<c:choose>
		<c:when test="${lecture.lect_price != 0}">
			<p>이런 유익한 강의가?! 단돈 ${lecture.lect_price}원!!!</p>
		</c:when>
		<c:otherwise>
			<p>이런 유익한 강의가! 무료라고?!!!</p>
		</c:otherwise>
	</c:choose>
	<del class="cd-price__reg-price"><!-- 원 가격 --></del>
</div>
<c:if test="${lecture.lect_price != 0 && user.me_id != lecture.lect_mentIf_me_id}">
	<button class="btn btn-success col-12" onclick="requestPay()">신청하기</button>
</c:if>
<div class="second-container">
	<h4>강의 소개</h4>
	<hr>
	<section>
		<div class="form-row content">
			<div style="min-height: 400px; border: 1px solid #f2f2f2" class="second-box" id="lect_content">${lecture.lect_intro}</div>
		</div>
	</section>
</div>
<div>
	<c:choose>
		<c:when test="${fileList.size() != 0 && payment.lectRg_state == true}">
			<h1>강의파일</h1>
			<c:forEach items="${fileList}" var="file">
				<a href="<c:url value="/download/${file.lectFi_path}"/>"
					class="form-control" download="${file.lectFi_ori_name}">${file.lectFi_ori_name}</a>
			</c:forEach>
		</c:when>
		<c:when test="${lecture.lect_price == 0}">
			<h1>강의파일</h1>
			<c:forEach items="${fileList}" var="file">
				<a href="<c:url value="/download/${file.lectFi_path}"/>"
					class="form-control" download="${file.lectFi_ori_name}">${file.lectFi_ori_name}</a>
			</c:forEach>
		</c:when>
		<c:when test="${fileList.size() == 0}">
			<h1>강의파일이 아직 없습니다.</h1>
		</c:when>
		<c:otherwise>
			<h1>강의 파일</h1>
			<div>강의파일은 구매후 보입니다.</div>
		</c:otherwise>
	</c:choose>
	<c:if test="${user.me_id == lecture.lect_mentIf_me_id}">
		<a href="<c:url value="/lecture/update?lect_num=${lecture.lect_num}"/>" class="btn btn-outline-warning">수정</a>
	</c:if>
</div>



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
		repo_table : "lecture",
		repo_target : ${lecture.lect_num}
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
				alert("해당 강의를 신고했습니다.");
			    $(".report-modal").css('display','none');
			   	$("body").css('overflow','visible');
			   	location.href = '<c:url value="/lecture/detail?page=1&type=all&search=&lectNum=${lecture.lect_num}"/>';			
			}else{
				alert("강의글을 신고하지 못했습니다.");
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
	
</body>
</html>