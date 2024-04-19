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
				<div class="check_wrap">
				  <input type="checkbox" id="check_frontend"  class="check-input" onclick='getCheckboxValue(event)' value="프론트엔드" />
				  <label for="check_frontend"><span>프론트엔드</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_backend" class="check-input" onclick='getCheckboxValue(event)' value="백엔드"/>
				  <label for="check_backend"><span>백엔드</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_full" class="check-input" onclick='getCheckboxValue(event)' value="풀스택"/>
				  <label for="check_full"><span>풀스택</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_language" class="check-input" onclick='getCheckboxValue(event)' value="프로그래밍 언어" />
				  <label for="check_language"><span>프로그래밍 언어</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_web" class="check-input" onclick='getCheckboxValue(event)' value="웹 개발" />
				  <label for="check_web"><span>웹 개발</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_db" class="check-input" onclick='getCheckboxValue(event)' value="데이터베이스"/>
				  <label for="check_db"><span>데이터베이스</span></label>
				</div>
				<div class="check_wrap">
				  <input type="checkbox" id="check_publishing" class="check-input" onclick='getCheckboxValue(event)' value="웹 퍼블리싱" />
				  <label for="check_publishing"><span>웹 퍼블리싱</span></label>
				</div>
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
	
</div>

<!-- 리스트 출력 -->
<script type="text/javascript">
	let cri = {
			page : 1,
			type : "",
			search : "",
			typeList : ["프론트엔드","백엔드","풀스택","프로그래밍 언어","웹 개발","데이터베이스","웹 퍼블리싱"]
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
				<a class="mento-item" href="<c:url value="/mento/detail?ment_num=\${mentoing.ment_num}"/>">
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
	var arr = [];
	$(".check-input").each(function(){
	if($(this).prop("checked")){
		arr.push($(this).val());	  
	}  
	})
	if(arr.length == 0){
		arr.push("프론트엔드","백엔드","풀스택","프로그래밍 언어","웹 개발","데이터베이스","웹 퍼블리싱");
	}
	cri.typeList = arr;
	cri.page = 1;
	getMentoList(cri);
}
</script>

<!-- 검색 창 이벤트 -->
<script type="text/javascript">
$(document).on('click', '#mento-totalsearch-btn', function(){
	cri.page = 1;
	cri.search = $("#mento-totalsearch").val();
	getMentoList(cri);
})
$(document).on('keyup', '#mento-totalsearch', function(){
	if(event.keyCode === 13){
		cri.page = 1;
		cri.search = $("#mento-totalsearch").val();
		getMentoList(cri);
	}
})
//ㅇㄴㅇㄴ

</script>









</body>
</html>