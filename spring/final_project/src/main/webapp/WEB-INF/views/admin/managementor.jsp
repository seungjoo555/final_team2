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
		if(mentorInfoList == null || mentorInfoList.length ==0){
			str += "<h2>조회된 유저가 없습니다.</h2>"
			$('.accept-member').html(str);
			return;
		}

		for(mentorInfo of mentorInfoList){
			str += `<ul class="mentor-info-instance">
						<input type="checkbox" class="mentor-info-checkbox" value="\${mentorInfo.mentIf_me_id}">
						<li><a href="<c:url value='/mypage/profile?me_id=\${mentorInfo.mentIf_me_id}'/>" class="mentor-info mentor-id">\${mentorInfo.mentIf_me_id}</a></li>
						<div class="mentor-info-click-box">
							<li class="mentor-info mentor-work">\${mentorInfo.mentIf_ment_job}</li>
					        <li class="mentor-info mentor-content">\${mentorInfo.mentIf_intro}</li>
					    <div>
			        </ul>`;
		}
		$('.accept-member').html(str);
		
		
	}
	
	<!--신청정보 클릭 이벤트-->
	$(document).on('click','.mentor-info-click-box',function(){
		alert("ㅇㅇ")
	})
	
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
		
		 $('.mentor-info-checkbox:checked').each(function(){
		        checkedIds.push($(this).val()); // 체크된 체크박스의 값(멘토의 ID)을 배열에 추가
		    });

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
	            // 요청이 실패한 경우의 동작
	            console.error('요청을 처리하는 중 에러가 발생했습니다:', error);
	        }
	    });
		
	})
	
</script>
</body>
</html>