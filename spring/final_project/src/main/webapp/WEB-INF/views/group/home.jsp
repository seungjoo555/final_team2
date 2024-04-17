<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/grouphome.css"/>">
<body>
<div class="container">
	<!-- 메뉴바 -->
	<form class="menu-bar" action="<c:url value="/group/home"/>" method="get">
		<div class="group-category">
			<span class="group-category-item all" >전체</span>
		</div>
		<div class="group-category" onclick="onStudy()">
			<span class="group-category-item study">스터디</span>
		</div>
		<div class="group-category" onclick="onProject()">
			<span class="group-category-item project">프로젝트</span>
		</div>
		<div class="group-category group-category-insert">
			<a class="btn-outline-success insert" href="<c:url value="/recruit/insert"/>">모집글 작성</a>
		</div>
	</form>
	<!-- 리스트 -->
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>
					<a href="<c:url value="/group/detail?num=1"/>">임시 주소</a>
				</td>
				<td>모름</td>
				<td>1</td>
			</tr>
		</tbody>
	</table>
	
	<!-- 페이지네이션 -->
	<ul class="pagination justify-content-center">
	 	<c:if test="${pm.prev}">
	 		<c:url value="group/home" var="url">
	 			<c:param name="page" value="${pm.startPage - 1 }"></c:param>
	 			<c:param name="type" value="${pm.cri.type}"></c:param>
	 			<c:param name="search" value="${pm.cri.search}"></c:param>
	 		</c:url>
		    <li class="page-item">
		    	<a class="page-link" href="${url}">이전</a>
		    </li>
	 	</c:if>
	 	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
	 		<c:url value="group/home" var="url">
	 			<c:param name="page" value="${i}"></c:param>
	 			<c:param name="type" value="${pm.cri.type}"></c:param>
	 			<c:param name="search" value="${pm.cri.search}"></c:param>
	 		</c:url>
	 		<!-- 부트스트랩에서 page-item옆에 active를 붙이면 현재 페이지에 파란색을 넣어줌 -->
		    <li class="page-item <c:if test="${pm.cri.page == i }">active</c:if>">	
		    	<a class="page-link" href="${url}">${i}</a>
		    </li>
	 	</c:forEach>
	    <c:if test="${pm.next}">
	    	<c:url value="group/home" var="url">
	 			<c:param name="page" value="${pm.endPage + 1 }"></c:param>
	 			<c:param name="type" value="${pm.cri.type}"></c:param>
	 			<c:param name="search" value="${pm.cri.search}"></c:param>
	 		</c:url>
		    <li class="page-item">
		    	<a class="page-link" href="${url}">다음</a>
		    </li>
	    </c:if>
  	</ul>
	
</div>


<!-- 게시글 조회 -->
<script type="text/javascript">
	let cri = {
			page : 1,
			type : "all"
	}
	getGroupList(cri);
	function getGroupList(cri){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/group/home"/>", 
			type : 'post', 
			data : JSON.stringify(cri),
			//서버로 보낼 데이터 타입
			contentType : "application/json; charset=utf-8",
			//서버에서 보낸 데이터의 타입
			dataType :"json", 
			success : function (data){
				displayGroupList(data.list);
				displayGroupPagination(data.pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	//ajax and
	}	//getGroupList(cri); end
	
	
	//클릭이벤트
	$(".all").click(function(){
		textChange('all');
		cri.type = "all";
		getGroupList(cri);
	});
	$(".study").click(function(){
		textChange('study');
		cri.type = "study";
		getGroupList(cri);
	});
	$(".project").click(function(){
		textChange('project');
		cri.type = "project";
		getGroupList(cri);
	});
	

	
	
	//리스트 출력
	function displayGroupList(list){
		let str = '';
		if(list == null || list.length == 0){
			str = '<h3>등록된 모임이 없습니다.</h3>';
			$('.box-group-list').html(str);
			return;
		}
		for(group of list){
			let type = "";
			if(group.recu_type == 0){
				type = "스터디";
			}else if(group.recu_type == 1){
				type = "프로젝트";				
			}
				
			str +=
				`
				<ul class="group-list">
					<!-- 게시글 정보 링크 -->
					<a class="group-list-item"  href="#">
						<li>
							<!-- 프로젝트/스터디 구분 -->
							<div class="group-list-item-category" >
								<div>\${type}</div>
							</div>
							<!-- 마감일 -->
							<div class="group-list-item-schedule">
								<p>마감일 |</p>
								<p>\${group.recu_due }</p>
							</div>
							<!-- 그룹 모집 제목 -->
							<h3 class="group-list-item-title">\${group.recu_topic }</h3>
							<!-- 분야 리스트 -->
							<div class="group-list-item-contentList">
								\${group.recu_required }
							</div>
							<!-- 사용언어 -->
							<div class="group-list-item-languageList">
								\${group.recu_preferred }
							</div>
							<!-- 구분선 -->
							<div class="border-line"></div>
							<div class="group-list-item-memberInfo" >
								<div class="memberNickname">\${group.recu_gome_me_nickname } </div>
								<div class="groupSituation">\${group.recu_state }</div>
							</div>
						</li>
					</a>
				</ul>
				`
		}	//for end
		$('.box-group-list').html(str);
	}	//displayGroupList(list) end
		
	
	
	//페이지네이션
	function displayGroupPagination(pm){
		
	}
	
	
	
	

	//텍스트 색상 변환 함수
	function textChange(type){
		switch (type) {
		case 'all': 
			$(".all").css('color','black');  $(".study").css('color','gray');  $(".project").css('color','gray');
			break;
		case 'study' :
			$(".all").css('color','gray');  $(".study").css('color','black');  $(".project").css('color','gray');
			break;
		case 'project' :
			$(".all").css('color','gray');  $(".study").css('color','gray');  $(".project").css('color','black');
			break;
		default:break;
		};
		
	};
	
</script>












<!-- 메뉴 바 이벤트 -->
<script type="text/javascript">
	textChange('all');

</script>

</body>
</html>