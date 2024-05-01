<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	.manage-mentor-container{
		background-color : #F9F9F9;
		height : 100%;
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	    transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.manage-mentor-container:hover {
	  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	.text-wrap{
		margin-left : 35px;
	}
	.text-wrap h2{
		font-weight : bold;
	}
	.select-wrap{
		margin-top : 30px;
		margin-left : 35px;
		margin-bottom : 40px;
	}
	.select-all-wrap *{
		margin-left : 35px;
	}

	
	.select-wrap select{
		background-color: #D9D9D9;
		width : 240px;
		height : 40px;
	}
	.accept-list-wrap ul {
		display: flex;
		font-size: 18px;
		margin-left : 35px;
		margin-top : 30px;
	}
	
	.mentor-info-instance *{
		margin-right : 35px;
	}
	
	.mentor-info-click-box{
		display : flex;
	}
	
	.mentor-info-instance:hover{
		background-color: #4F4F4F;
	}
	
	.mentor-info-click-box:hover{
		cursor : pointer;
	}
	
	.mentor-button-group{
		display : block;
		text-align: right;
	}
	.mentor-button-group button{
		width : 150px;
		height : 50px;
		border-radius : 5px;
		margin-right : 20px;
		margin-bottom : 30px;
	}
	.multi-accept{
		color : white;
		background-color: #649B60;
	}
	.multi-deny{
		color : black
	}
	
	#modalWrap {
	  position: fixed; /* 화면에 고정 */
	  z-index: 1; /* 상위에 위치 */
	  padding-top: 100px;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  overflow: auto;
	  background-color: rgba(0, 0, 0, 0.7); /* 반투명한 배경색 */
	  display: none; /* 초기에는 숨김 */
	}
	
	#modalBody {
	  width: 1000px;
	  height: 750px;
	  padding: 30px 30px;
	  margin: 0 auto;
	  border: 1px solid #777;
	  background-color: #fff;
	}
	
	#closeBtn {
	  float: right;
	  font-weight: bold;
	  color: #777;
	  font-size: 25px;
	  cursor: pointer;
	}
	
	.mentorInfo-detail-input-wrap{
		display : flex;
		justify-content : space-between;
		margin-top : 35px;
	}
	
	.mentorInfo-detail-input-wrap input{
		width : 450px;
		height : 50px;
		border-radius : 5px;
		background-color: #EBEBEB;
		padding : 10px;
	}
	
	.bank-wrap{
		display:flex;
	}
	.bank-wrap .mentorInfo-account{
		width : 330px;
	}
	.bank-wrap .mentorInfo-bank{
		margin-right : 20px;
		width : 100px;
	}
	
	.mentorInfo-intro{
		width : 938px;
		height : 200px;
		border-radius : 5px;
		background-color : #EBEBEB;
	}
	
	.mentorInfo-detail-button-group{
		display : block;
		text-align: center;
		margin-top : 35px;
	}
	
	.mentorInfo-detail-button-group button{
		height : 50px;
		border-radius : 5px;
	}
	
	.button-accept{
		width : 110px;
		background-color : #649B60;
		color : white;
	}
	
	.button-deny{
		width : 110px;
		background-color : #D9D9D9;
	
	}
	
	
</style>
</head>
<body>
<div class="manage-mentor-container">
	<div class="text-wrap">
		<h2>멘토 권한 신청 유저 목록</h2>
	</div>
	<div class="select-wrap">
		<select name="mentorJob" class="mentorJob">
			<option hidden disabled selected>
				직무
			</option>
			<option value="">전체</option>
			<c:forEach var="mentorJob" items="${mentorJobList}">
				<option value="${mentorJob.ment_job}">${mentorJob.ment_job}</option>
			</c:forEach>
		</select>
	</div>
	<div class="select-all-wrap">
		<input type="checkbox" class="select-all">
		<label for="select-all">전체선택</label>
	</div>
	<div class="accept-list-wrap">
		<div class="accept-member">
			<ul class="mentor-info-instance">
				<li><a href="#" class="mentor-info mentor-id">testtesttest</a></li>
				<li class="mentor-info mentor-work">testtesttest</li>
				<li class="mentor-info mentor-content">testtesttest</li>
			</ul>
			<ul class="mentor-info-instance">
				<li><a href="#" class="mentor-info mentor-id">test</a></li>
				<li class="mentor-info mentor-work">test</li>
				<li class="mentor-info mentor-content">test</li>
			</ul>
		</div>
	</div>
	<div class="mentor-button-group">
		<button type="button" class="multi-accept" value="accept">허가</button>
		<button type="button" class="multi-deny" value="deny">거절</button>
	</div>
	<div class="mentor-pagination">
			<ul class="box-pagination justify-content-center">
			</ul>
	</div>
	<div id="modalWrap" class="modalWrap"> <!-- 모달 창을 감싸는 div -->
      <div id="modalBody" class="modalBody">
        <span id="closeBtn" class="modalCloseBtn">&times;</span> <!-- 모달을 닫는 X 버튼 -->
        <div class="mentorInfo-detail-wrap">
	        <h2>dddd</h2>
	        <div class="mentorInfo-detail-input-wrap">
	        	<div class="mentorInfo-print-group">
	        		<label for="mentorInfo-job">멘토직무</label>
	        	</div>
	        </div>
      	</div>
    </div>
	</div>
</div>

<script type="text/javascript">
	let cri = {
		page : 1,
		search : ""
	}
	
	<!--검색어 설정-->
	$('.mentorJob').change(function(){
		cri.page = 1;
		cri.search = $(this).val();
		getMentorInfoList(cri);
	})
	getMentorInfoList(cri);
	
	<!-- 멘토신청 가져오기 -->
	function getMentorInfoList(cri){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/managementor/list"/>", 
			type : 'post', 
			data : JSON.stringify(cri),
			//서버로 보낼 데이터 타입
			contentType : "application/json; charset=utf-8",
			//서버에서 보낸 데이터의 타입
			dataType :"json", 
			success : function (data){
				displayMentorInfoList(data.mentorInfoList);
				displayMentorInfoPagination(data.pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	
	}	
	
	<!-- 멘토신청 출력 -->
	function displayMentorInfoList(mentorInfoList){
		let str ='';
		let mentIf_intro = '';
		let changeNull ='';
		let subId ='';
		let subContent ='';
		if(mentorInfoList == null || mentorInfoList.length ==0){
			str += "<h2>조회된 유저가 없습니다.</h2>"
			$('.accept-member').html(str);
			return;
		}

		for(mentorInfo of mentorInfoList){
			mentIf_intro = mentorInfo.mentIf_intro;
			//아이디가 7글자를 넘어갈 때 처리
			if(mentorInfo.mentIf_me_id.length>7){
				subId = mentorInfo.mentIf_me_id.substr(0,7) +"...";
			}else{
				subId = mentorInfo.mentIf_me_id;
			}
			//자기소개가 null일 때 처리
			if(mentIf_intro == null || mentIf_intro.trim().length==0){
				mentIf_intro = "등록된 자기소개가 없습니다.";
			}
			//자기소개가 35글자를 넘어갈 때 처리
			if(mentIf_intro.trim().length>35){
				subContent = mentIf_intro.substr(0,35) + "...";
			}else{
				subContent = mentIf_intro;
			}
			str += `<ul class="mentor-info-instance">
						<input type="checkbox" class="mentor-info-checkbox" value="\${mentorInfo.mentIf_me_id}">
						<li>
							<a href="<c:url value='/mypage/profile?me_id=\${mentorInfo.mentIf_me_id}'/>" class="mentor-info mentor-id" >`+subId+`</a>
						</li>
						<div class="mentor-info-click-box">
							<input type="hidden" class="hiddenId" value="\${mentorInfo.mentIf_me_id}">
							<li class="mentor-info mentor-work">\${mentorInfo.mentIf_ment_job}</li>
					        <li class="mentor-info mentor-content">`+subContent+`</li>
					    <div>
			        </ul>
			        `;
		}
		$('.accept-member').html(str);
		
		
	}
	
	<!--신청정보 클릭 이벤트-->
	$(document).on('click','.mentor-info-click-box',function(){
		$('.modalWrap').css('display','block')
		let mentIf_me_id = $(this).find('.hiddenId').val();
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/managementor/detail"/>", 
			type : 'get', 
			data : { mentIf_me_id: mentIf_me_id },
			dataType :"json", 
			success : function (data){
				displayMentorInfo(data.mentorInfo)
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});
	});
	
	<!--mentorInfo detail 출력-->
	function displayMentorInfo(mentorInfo){
		//자기소개가 null일 때 처리
		if(mentorInfo.mentIf_intro==null){
			mentorInfo.mentIf_intro = "등록된 자기소개가 없습니다.";
		}
		let str = `
			<h2>\${mentorInfo.mentIf_me_id}</h2>
	        <div class="mentorInfo-detail-input-wrap">
	        	<div class="mentorInfo-print-group">
	        		<label for="mentorInfo-job">멘토직무</label>
	        		<br>
	        		<input type="text" value="\${mentorInfo.mentIf_ment_job}" readonly>
	        	</div>
	        	<div class="mentorInfo-print-group">
	        		<label for="mentorInfo-exp">경력</label>
	        		<br>
	        		<input type="text" value="\${mentorInfo.mentIf_exp}" readonly>
        		</div>
	        </div>
	        <div class="mentorInfo-detail-input-wrap">
	        	<div class="mentorInfo-print-group">
			        <label for="mentorInfo-account">계좌 정보</label>
					<br>
					<div class="bank-wrap">
						<input type="text" value ="\${mentorInfo.mentIf_bank}" class="mentorInfo-bank" readonly>
						<input type="text" value ="\${mentorInfo.mentIf_account}" class="mentorInfo-account" readonly>
					</div>
				</div>
				<div class="mentorInfo-print-group">
					<label for="mentorInfo-portfolio">포트폴리오</label>
					<br>
					<input type="button" value="\${mentorInfo.mentIf_portfolio}" onClick="window.open('\${mentorInfo.mentIf_portfolio}')" class="mentIf_portfolio" readonly>
				</div>
       		</div>
       		<div class="mentorInfo-detail-input-wrap">
	       		<div class="mentorInfo-print-group">
					<label for="mentorInfo-intro">자기소개</label>
					<br>
					<textarea readonly class="mentorInfo-intro">\${mentorInfo.mentIf_intro}</textarea>
				</div>
			</div>
			<div class="mentorInfo-detail-button-group">
				<button type="button" class="request-button button-accept" data-me_id="\${mentorInfo.mentIf_me_id}" value="accept">허가</button>
				<button type="button" class="request-button button-deny" data-me_id="\${mentorInfo.mentIf_me_id}"  value="deny">거절</button>
			</div>
      	`
      	$('.mentorInfo-detail-wrap').html(str);
		
	}
	
	<!--디테일 - 허가/거절 버튼 클릭 이벤트-->
	$(document).on('click','.request-button',function(){
		let btnType ="";
		let mentIf_me_id = $(this).data('me_id');
		if($(this).val()=="accept"){
			btnType = $(this).val();
		}else{
			btnType = $(this).val();
		}
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/managementor/request"/>", 
			type : 'post', 
			data : { mentIf_me_id: mentIf_me_id,
					 btnType: btnType},
			dataType :"json", 
			success : function (data){
				if(data.res==="true"){
	          		alert("정상적으로 처리 되었습니다.")
	          		location.reload();
	          	}else if(data.res==="false"){
	          		alert("정상적으로 처리하지 못하였습니다.")
	          		location.reload();
	          	}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});
	})
	
	$('.modalCloseBtn').click(function(){
		$('.modalWrap').css('display','none')
	})
	window.onclick = function(event) {
	  var modalWrap = document.getElementById('modalWrap');
	  if (event.target == modalWrap) {
	    modalWrap.style.display = "none"; // 모달 외부를 클릭하면 모달을 숨김
	  }
	};
	
	<!--페이지네이션 생성-->
	function displayMentorInfoPagination(pm){
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
		$('.box-pagination').html(str);
	}
	
	<!-- 페이지네이션 클릭 -->
	$(document).on('click','.box-pagination .page-link',function(){
		cri.page = $(this).data('page');
		getMentorInfoList(cri);
	});
	
	<!--전체선택 이벤트-->
	$('.select-all').change(function(){
		if($(this).is(":checked")){
			$('.mentor-info-checkbox').prop('checked', true);
		}else{
			$('.mentor-info-checkbox').prop('checked', false);
		}
		
	})
	
	<!--일괄 허가/거절 이벤트-->
	$('.mentor-button-group>button').click(function(){
		let checkedIds = [];
		let btnType = "";
		let count =0;
		
		 $('.mentor-info-checkbox:checked').each(function(){
		        checkedIds.push($(this).val()); // 체크된 체크박스의 값(멘토의 ID)을 배열에 추가
		        count ++;
		    });
		 
		 if (count ===0){
			 alert("승인/거절 처리할 유저를 먼저 선택해주세요.")
			 return false;
		 }

		if($(this).val()=="accept"){
			btnType ="accept";
		}else{
			btnType ="deny";
		}
		
		$.ajax({
	        url: '<c:url value="/admin/managementor/multirequest"/>', 
	        type: 'post',
	        data: JSON.stringify({
	            btnType: btnType,
	            checkedIds: checkedIds
	        }),
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function(data){
	          	if(data.res==="true"){
	          		alert("정상적으로 처리 되었습니다.")
	          		location.reload();
	          	}else if(data.res==="false"){
	          		alert("정상적으로 처리하지 못하였습니다.")
	          		location.reload();
	          	}
	        },
	        error: function(xhr, status, error){
	            console.error('요청을 처리하는 중 에러가 발생했습니다:', error);
	        }
	    });
		
	})
	
</script>
</body>
</html>