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

</head>
<body>
	<div class="container">
		<div class="container-info-bar">
			<div class="grouplist-title">나의 그룹</div>
		</div>
		<div class="group-list-bg">
				<table class="group-list">
					<thead>
						<tr>
							<th>그룹명</th>
							<th class="text-center">공부 시간</th>
							<th class="text-center">인원</th>
						</tr>
					</thead>
					<tbody>
						<!-- 그룹 목록 출력됨 -->
					</tbody>
				</table>
				<!-- 페이지네이션 -->
				<div class="box-pagination">
					<ul class="pagination justify-content-center">
						<!-- 페이지네이션 출력됨 -->
					</ul>
				</div>
			
			
			
		</div>
	</div>
<!-- 나의 그룹 조회 -->
<script type="text/javascript">
	let cri = {
			page : 1
	}
	
	getGroupList(cri);
	
	function getGroupList(cri){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/mygroup/list"/>", 
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
		});	
	}
	
	
	//리스트 출력
	function displayGroupList(list){
		let str = '';
		let url = `team2/group/home?num=`;
		let time = '';
		
		// 받아온 list가 없을 경우,
		if(list == null  || list.length == 0){
			str = `
				<div class="no-list-page">
					<div>가입한 그룹이 없습니다.</div>
					<a href="<c:url value="/group/list"/>">모집공고 보러 가기</a>
				</div>
				`
			$('.group-list-bg').addClass("text-align-center")
			$('.group-list-bg').html(str);
			return;
		}else{
			for(group of list){
				
				if(group.go_time < 3600){
					time = '0시간'
				}else if(group.go_time / 3600 > 999){
					time = '999+시간'
				}else{
					time = Math.round(group.go_time / 3600) + '시간'
				}
				
				str +=
					`
						<tr class="group-info">
							<td class="group-title">
								<a href="<c:url value="/group/home?num=\${group.go_num}"/>">\${group.go_name}</a>
							</td>
							<td class="group-time text-center">
								\${time}
							</td>
							<td class="text-center">\${group.go_member_count}명</td>
						</tr>
					`
				
			}
			
			$('.group-list tbody').html(str);
		}
		
		
		
	}
		
	
	
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
		getGroupList(cri);
	})
	
</script>
</body>
</html>