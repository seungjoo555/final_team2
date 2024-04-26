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
	
	/* group-calendar 관련 */
		.group-calendar{height: 100%; padding: 67px 30px 30px 30px;}
		.group-calendar .calendar{width: 100%; height:100%; border: 1px solid black;}
	
</style>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${group == null }">
			<div class="not-authorized text-align-center">
				<div>가입한 그룹이 아닙니다.</div>
				<a href="<c:url value="/"/>">홈으로 가기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container-info-bar">
				<div class="float-left group-title">${group.go_name}</div>
				<div class="float-left">그룹 페이지</div>
				<div class="setting-btn float-right">
					<c:if test="${group.leader == user.me_id}">
						<a class="group-manage-btn">
							<img class="hamburger-btn" src="<c:url value="/resources/img/hamburger-btn.png"/>">
						</a>
					</c:if>
				</div>
				<div class="user-info float-right">
					${user.me_nickname} 님
				</div>
				
			</div>
			<div class="container-row">
				<div class="container-left">
				
					<!-- 그룹 타이머 -->
					<div class="group-timer">
						<label class="group-timer-title">스터디 시계</label>
						<div class="group-timer-box">
							<div class="hour"></div>
							<div class="colon"> : </div>
							<div class="min"></div>
							<div class="colon"> : </div>
							<div class="sec"></div>
						</div>
						<div class="group-timer-btn-group">
							<a class="start-btn">시작</a>
							<a class="pause-btn">중지</a>
						</div>
					</div>
					
					<!-- 그룹 D-DAY -->
					<div class="group-dday box">
						<div class="box-info-bar">
							D-DAY
						</div>
						<div>
							<ul class="dday-list">
								<c:forEach items= "${ddaylist}" var="dday">
									<li>
										<div>D${dday.dday}</div>
										<div>${dday.gocal_title}</div>
									</li>
								</c:forEach>
								
							</ul>					
						</div>
					</div>
				</div>
				<div class="container-right">
					<!-- 그룹 일정 -->
					<div class="group-calendar box">
						<div class="box-info-bar">
							일정
						</div>
						<div class="calendar">
						
						</div>
					</div>
				</div>
			</div>
			<div class="container-bottom">
				<!-- 최근 그룹 게시글 -->
				<div class="group-board box">
					<div class="box-info-bar">
						최근 그룹 게시글
						<c:url value="/group/post" var="url">
							<c:param name="num" value="${group.go_num}"/>
						</c:url>
						<a href="${url}" class="to-post float-right">게시글 목록으로</a>
					</div>
					<div class="group-board-list">
						<c:forEach items="${boardlist}" var="board">
							<div>
								<label class="writer">${board.nickname}</label>
								<div class="content">${board.gopo_content}</div>
								<div class="time">${board.time_ago}</div>
							</div>
						</c:forEach>
						
						
					</div>
				</div>
			</div>
			
		   <!-- 그룹 관리 화면 -->
		   <div id="modal" class="modal apply-mentoring-modal" style="display:none;">
		      <div id="dimmed" class="dimmed apply-mentoring-dimmend"></div>
		      <div class="manage-group_container">
		      	<button class="cancle-btn">X</button>	
	      		<ul class="manage-group-list">
	      			<li>
	      				<c:url var = 'url1' value = '/group/manage/info'>
	      					<c:param name = 'num' value = "${group.go_num }"/>
	      				</c:url>
	      				<a href="${url1}">그룹 정보 변경</a>
	      			</li>
	      			<li>
	      				<c:url var = 'url2' value = '/group/manage/member'>
	      					<c:param name = 'num' value = "${group.go_num }"/>
	      				</c:url>
	      				<a href="${url2}">멤버 관리</a>
	      			</li>
	      			<li>
	      				<c:url var = 'url3' value = '/group/manage/applicant'>
	      					<c:param name = 'num' value = "${group.go_num }"/>
	      				</c:url>
	      				<a href="${url3}">지원자 관리</a>
	      			</li>
	      		</ul>
		      </div>
		   </div>
		</c:otherwise>
	</c:choose> 
</div>

<!-- timer 시간 표시하기 -->
<script type="text/javascript">
	let timerOn = true; // 타이머 작동 여부 결정
	
	setTimer(${time});

	// 그룹 시간을 타이머 형식으로 변환하여 출력하도록 함.
	function setTimer(time){
		let hour = Math.floor(time / 3600)	// 시 구하기
		
		if(${time} < 0){		// 에러시간
			timerOn = false;
			$(".hour").text("-999") 
			$(".min").text("59") 
			$(".sec").text("59") 
		}
		else if (hour > 999){	// 최대시간 초과시,
			timerOn = false;
			$(".hour").text("999") 
			$(".min").text("59") 
			$(".sec").text("59+") 
			
		}else{
			hour = numberPad(hour, 2)
			let min = numberPad(Math.floor(time % 3600 / 60), 2) 		// 분 구하기
			let sec = numberPad(time % 60, 2)					// 초 구하기
			
			$(".hour").text(hour)  
			$(".min").text(min) 
			$(".sec").text(sec) 
		}
		
	}
	
	// lpad 구현
	function numberPad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}
	
</script>

<!-- 매초 타이머가 증가하는 script -->
<script type="text/javascript">
	let timerWork
	let colonToggle
	let isTimerWork = false;
	
	$(".start-btn").click(function(){
		
		// 타이머가 비활성화 되어있을 경우(에러 or 1000시간 이상)
		if(!timerOn){
			alert("기록 가능한 시간을 초과했습니다. '관리자 메뉴 > 그룹 정보 관리 페이지'에서 타이머를 초기화 해주세요.")
			return
		}
		
		if(!isTimerWork){
			isTimerWork = true;
			
			$(".hour, .min, .sec").addClass("timer-on")
			
			 timerWork = setInterval(function(){ // 매 1000미리초(1초)에 1번 실행됨.
				 $.ajax({
						async : true, //비동기 : true(비동기), false(동기)
						url : '<c:url value="/group/timerWork"/>', 
						type : 'post', 
						data : {num : ${group.go_num}}, 
						dataType : "json", 
						success : function (data){
							if(data.data == "ok"){
								setTimer(data.time)
							}
							
						}, 
						error : function(jqXHR, textStatus, errorThrown){

						}
					});
				 
	         }, 1000) // 1초에 한 번 씩 서버와 통신
	         
	         colonToggle = setInterval(function(){
	        	 $(".colon").toggleClass("invisible");
	         }, 500)
		}else{
			alert("이미 타이머가 작동 중입니다.")
		}

	})
	
	$(".pause-btn").click(function(){
		isTimerWork = false;
		
		// 타이머 가동 종료 및 원래 style로 되돌리기
		clearInterval(timerWork)
		$(".hour, .min, .sec").removeClass("timer-on")
		
		// 타이머 깜빡임 종료 및 원래 style로 되돌리기
		clearInterval(colonToggle)
   		 $(".colon").removeClass("invisible");
	})
</script>

<!-- 햄버거 버튼 클릭 script -->
<script type="text/javascript">
$(document).on('click', '.group-manage-btn', function(event){

   $("#modal").css('display','block');
   //스크롤 비활성화
   $("body").css('overflow','hidden');

})

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

</body>
</html>