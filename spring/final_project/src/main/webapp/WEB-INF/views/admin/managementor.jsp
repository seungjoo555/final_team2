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
	.select-wrap select{
		background-color: #D9D9D9;
		width : 240px;
		height : 40px;
	}
	.accept-list-wrap ul{
		display: flex;
		font-size: 24px;
		margin-left : 35px;
		margin-top : 30px;
		width: 100%;
	}
</style>
</head>
<body>
<div class="manage-mentor-container">
	<div class="text-wrap">
		<h2>멘토 권한 신청 유저 목록</h2>
	</div>
	<div class="select-wrap">
		<select name="toCt_progCt" class="toCt_progCt">
			<option hidden disabled selected>
				직무
			</option>
			<c:forEach var="progCt" items="${progCtList}">
				<option value="${progCt.progCt_name}">${progCt.progCt_name}</option>
			</c:forEach>
		</select>
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
	<div class="mentor-pagination-wrap">
		<div class="mentor-pagination">
			<ul class="box-pagination justify-content-center"></ul>
		</div>
	</div>
</div>
<script type="text/javascript">
	let cri = {
		page : 1,
		search : ""
	}
	
	
	$('.toCt_progCt').change(function(){
		cri.page = 1;
		cri.search = $(this).val();
		getMentorInfoList(cri);
	})
	
	getMentorInfoList(cri);
	
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
	
	function displayMentorInfoList(mentorInfoList){
		let str ='';
		if(mentorInfoList == null || mentorInfoList.length ==0){
			str += "<h2>멘토 신청을 한 유저가 존재하지 않습니다.</h2>"
			$('.accept-member').html(str);
			return;
		}
		
		for(mentorInfo in mentorInfoList){
			str += `<li><a href="#" class="mentor-info mentor-id">\${mentorInfo.mentIf_me_id}</a></li>
					<li class="mentor-info mentor-work">\${mentorInfo.mentIf_ment_job}</li>
			        <li class="mentor-info mentor-content">\{mentorInfo.mentIf_intro}</li>`;
		}
		$('.accept-member').html(str);
		
		
	}
	
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
		$('.box-pagination>ul').html(str);
	}
	
</script>
</body>
</html>