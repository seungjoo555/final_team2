<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/grouplist.css"/>">
<body>
<div class="container">
	<!-- 메뉴바 -->
	<form class="menu-bar" action="<c:url value="/group/list"/>" method="get">
		<div class="group-category">
			<span class="group-category-item all"  data-category="all" >전체</span>
		</div>
		<div class="group-category">
			<span class="group-category-item study"  data-category="study">스터디</span>
		</div>
		<div class="group-category" >
			<span class="group-category-item project"  data-category="project">프로젝트</span>
		</div>
		<div class="group-category group-category-insert">
			<a class="btn-outline-success insert" href="<c:url value="/recruit/insert"/>">모집글 작성</a>
		</div>
	</form>
	<!-- 리스트 -->
	<div class="box-group-list"></div>
	
	<!-- 페이지네이션 -->
	<div class="box-pagination">
		<ul class="pagination justify-content-center"></ul>
	</div>
	
</div>


<!-- 게시글 조회 -->
<script type="text/javascript">
	let cri = {
			page : 1,
			type : "all"
	}
	textChange(cri.type);
	getGroupList(cri);
	function getGroupList(cri){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/group/list"/>", 
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
					<a class="group-list-item"  href="<c:url value="/group/detail?recu_num=\${group.recu_num}"/>">
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
		let str = '';
		if(pm.prev){
			str +=
				`<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.startPage - 1}" data-type="\${pm.cri.type}">이전</a>
			    </li>`;
		}
		
		for(let i = pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active':'';
			str +=
				`
				 <li class="page-item \${active}">
				 	<a class="page-link" href="javascript:void(0)" data-page="\${i}" data-type="\${pm.cri.type}">\${i}</a>
			    </li>				
				`;
		}
		
		if(pm.next){
			str +=
				`
				<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.endPage + 1}" data-type="\${pm.cri.type}">다음</a>
			    </li>				
				`;
		}
		$('.box-pagination>ul').html(str);
	}
	
	
	
	//클릭이벤트
	$(document).on('click', '.box-pagination .page-link', function(){
		cri.page = $(this).data('page');
		cri.type = $(this).data('type');
		console.log(cri);
		getGroupList(cri);
	})

	$(".group-category-item").click(function(){
		textChange($(this).data('category'));
		cri.page = 1;
		cri.type = $(this).data('category');
		category ="study"; 
		getGroupList(cri);
	})
	
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


</body>
</html>