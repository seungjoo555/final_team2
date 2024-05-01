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

<!-- fullCalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

<style>
	.insertModal{display:none;}
	.insertBtn{;}
	.deleteBtn{display:none;}
	
	
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
								<c:forEach items= "${ddaylist}" var="dday" begin="0" end="10" >
								<!-- 가장 빠른 일정부터 10개만 dday로 표시함 -->
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
						<div class="calendar" id="calendar">
						
						</div>
						
						 <!-- insertModal -->
						  <div class="modal fade insertModal" id="myModal">
						    <div class="modal-dialog">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div class="modal-header">
						          <h4 class="modal-title"></h4>
						          <button type="button" class="close" onclick="initModal('insertModal', g_arg)">&times;</button>
						        </div>
						        
						        <!-- Modal body -->
						        <div class="modal-body">
						          <div class="form-group empl_nm">
									<label for="title">일정 제목:</label>
									<input class="form-control" placeholder="" id="title">
								  </div>
								  <br>
						          <div class="form-group">
									<label for="memo">일정 내용:</label>
									<input class="form-control" placeholder="" id="memo">
								  </div>
								  <!-- 일정 시간 지정 구현 필요 -->
								  <!-- 
								  <div class="form-group">
									<label for="start">시작 날짜:</label>
									<input type="date" class="form-control" placeholder="" id="start">
								  </div>
								  <div class="form-group">
									<label for="end">종료 날짜:</label>
									<input type="date" class="form-control" placeholder="" id="end">
								  </div>
								   -->
						        </div>
						        <!-- Modal footer -->
						        <div class="modal-footer">
								  <button type="button" class="btn btn-outline-danger float-right deleteBtn" onclick="deleteSch('insertModal', g_arg)">삭제</button>
								  <button type="button" class="btn btn-outline-success float-right insertBtn" onclick="insertSch('insertModal', g_arg)">등록</button>
						        </div>
						        
						      </div>
						    </div>
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
						<c:if test="${boardlist.size() != 0 }">
							<c:forEach items="${boardlist}" var="board">
								<div>
									<label class="writer">${board.nickname}</label>
									<div class="content">${board.gopo_content}</div>
									<div class="time">${board.time_ago}</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${boardlist .size() == 0 }">
							<div class="no-board">게시글이 없습니다.</div>
						</c:if>
						
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

<!-- fullCalendar -->
<!--  캘린더 생성하기 -->
<script>
let eventList = []
convertList()

// controller에서 불러온 일정들을 parsing하기
function convertList(){
	
	<c:forEach var="item" items="${calendarlist}">
		var tmp = {
			id: ${item.gocal_num},
			title: "${item.gocal_title}",
			start: "${item.gocal_startdate_str}",
			end: "${item.gocal_enddate_str}",
		 	extendedProps: {
				writer: "${item.gocal_me_id}",
				memo: "${item.gocal_memo}"
	        },
	        
	        // 일정 별 style 지정
	        backgroundColor: "#E6F5E5",
	        textColor : "#000000",
	        borderColor: "transparent"
			
		}
		eventList.push(tmp)
	</c:forEach>
		
}

// 캘린더 생성하기
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      	// 월별로 캘린더 출력
      	initialView: 'dayGridMonth',
      
      	// 캘린더 날짜 제목 형식 변경
      	titleFormat: function (date) {
	        year = date.date.year;
	        month = date.date.month + 1;
	
	        return year + "년 " + month + "월";
        },
        
        // 일정이 너무 많으면 'more' 버튼 활성화
        dayMaxEvents: true, 
        
        // 일정 클릭 이벤트 활성화
        selectable: true,
        selectMirror: true,
        select: function(arg) {
        	window.scrollTo(0,0);
  			insertModalOpen(arg);	//일자 클릭 시 모달 호출
        },
        eventClick: function(arg) {
        	window.scrollTo(0,0);
  			insertModalOpen(arg);	//이벤트 클릭 시 모달 호출
        },
        
        // 일정 데이터 넣기
        events: eventList,
        
    });
    
    // 캘린더 생성하기
    calendar.render();
});

//모달 초기화
function initModal(modal, arg){
	$('.modal-title').text('')
	
	$('.'+modal+' #title').val('');
	$('.'+modal+' #memo').val('');
	// $('.'+modal+' #start').val('');
	// $('.'+modal+' #end').val('');
	$('.insertModal .deleteBtn').hide()
	
	$('.'+modal).modal('hide');
	g_arg = null;
}

// 모달 show
function insertModalOpen(arg){
	$('.modal-title').text(arg.startStr+' 일정 등록')
	
	g_arg = arg;
	
	// 값이 있는 경우(기존 일정을 클릭했을 경우) 세팅
	if(g_arg.event != undefined){
		let tmp = new Date();
		
		$('.modal-title').text('\"' + g_arg.event.title + '\" 일정 수정')
		
		$('.insertModal .deleteBtn').css('display', 'inline');
		$('.insertModal .memo').css('display', 'inline');
		$('.insertModal #memo').val(g_arg.event.extendedProps.memo);
		$('.insertModal #title').val(g_arg.event.title);
		$('.insertModal .deleteBtn').show()
		// 시작 종료날짜 (작동안됨 수정 필요)
		// $('.insertModal #start').val(g_arg.event.start);
		// $('.insertModal #end').val(g_arg.event.end);
	}
	
	//모달창 show
	$('.insertModal').modal({backdrop: 'static'});
	console.log(arg);
	$('.insertModal #title').focus();
}

//stringFormat date.getMonth() 또는 getDate()가 한자리수 일때 0 추가
function parse(str) {    
	var y = str.substr(0, 4); 
	var m = str.substr(4, 2);
	var d = str.substr(6, 2);
	
	return new Date(y,m-1,d);}

//캘린더 새로고침
function fCalUpdate() {
    calendar.refetchEvents();
}

</script>

<!-- 그룹 일정 등록 -->
<script type="text/javascript">
function insertSch(modal, arg){
	
	if($('.'+modal+' #title').val() == ''){
		alert('제목을 입력해주세요');
		return;
	}
	
	if($('.'+modal+' #title').val().length > 30){
		alert('제목은 30자를 넘을 수 없습니다 현재 ' + $('.'+modal+' #title').val().length + '자');
		return;
	}
	
	// 시작일-종료일 유효성 검사
	/*
	if($('.insertModal input[name="allDay"]:checked').val()!='true'){
		  if(arg.startStr.substring(0, 10) == arg.endStr.substring(0, 10)){
			  if($('.insertModal #end').val() <= $('.insertModal #start').val()){
				  alert('종료시간을 시작시간보다 크게 선택해주세요');
				  $('.insertModal #end').focus();
				  return;
			  }
			}
		}
	*/
	
	var data;
	
	if(arg.startStr.length > 10){
		//일자만 추출
		arg.startStr = arg.startStr.substr(0, 10);
	}
	
	if(arg.endStr.length > 10){
		var m_end = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
		//종일이기에 일+1 (시간은 어차피 00:00)
		m_end.setDate(m_end.getDate()+1);
		arg.endStr = m_end.getFullYear()+'-'+ stringFormat(m_end.getMonth()+1)+'-'+ stringFormat(m_end.getDate());
	}
	
	//DB 삽입	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/group/calendar/insert"/>', 
		type : 'post', 
		data : {
			num : ${group.go_num},
			title : $('.'+modal+' #title').val(),
	  		startdt : new Date(arg.startStr),
	  		enddt : new Date(arg.endStr),
	  		memo :  $('.'+modal+' #memo').val() 
		}, 
		dataType : "json", 
		success : function (data){
			if(data.data = "ok"){
				alert("일정이 등록되었습니다.")
				location.reload();
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
	
		}
	});
				 
	

}

</script>

<!-- 그룹 일정 삭제 -->
<script type="text/javascript">
function deleteSch(modal, arg){
	if(confirm('일정을 삭제하시겠습니까?')){
		console.log(arg)
		//DB 삭제
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : '<c:url value="/group/calendar/delete"/>', 
			type : 'post', 
			data : {
				num : ${group.go_num},
				calNum : Number(arg.event.id)
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data = "ok"){
					alert("일정이 삭제되었습니다.")
					location.reload();
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("일정이 삭제를 하지 못했습니다. 다시 시도 하십시오.")
			}
		});
		
	}else{
		return;
	}
	
}

</script>
</body>
</html>