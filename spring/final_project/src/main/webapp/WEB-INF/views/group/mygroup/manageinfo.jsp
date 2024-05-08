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
	<c:choose>
		<c:when test="${group == null }">
				<div class="not-authorized text-align-center">
				<div>접근 권한이 없는 페이지 입니다.</div>
				<a href="<c:url value="/"/>">홈으로 가기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container-info-bar">
				<div class="float-left group-title">${group.go_name}</div>
				<div class="float-left">그룹 정보 관리</div>
			</div>
			<div class="manage-info-bg">
				<div class="manage-info-option">
					<div class="info-option-title">
						그룹 정보 변경
						<div class="option-sub float-right">그룹의 정보를 변경합니다.</div>
					</div>
					<div class="info-option-content">
						<label>그룹 이름: </label>
						<input name="group-name" value="${group.go_name }">
						<a class="change-group-name-btn btn btn-outline-success">변경</a>
					</div>
				</div>
				<div class="manage-info-option">
					<div class="info-option-title">타이머
						<div class="option-sub float-right">그룹타이머를 관리합니다.</div>
					</div>
					<div class="info-option-content">
						<a onclick="resetTimer()" class="btn btn-outline-danger">초기화</a>
					</div>
				</div>
				<div class="manage-info-option">
					<div class="info-option-title">
						그룹 얼리기
						<div class="option-sub float-right">일정관리, 게시글 작성, 타이머 등을 비활성화 하여 그룹 활동 내역을 보존합니다.</div>
					</div>
					<div class="info-option-content">
						<label for="freeze">그룹 얼리기</label>
						<input type="checkbox" id="freeze">
					</div>
				</div>
				<div class="manage-info-option">
					<div class="info-option-title">리더 변경</div>
					<div class="info-option-content">
						<div class="member-list-bg">
							<c:choose>
								<c:when test="${list.size() == 0}">
									멤버없음
								</c:when>
								<c:otherwise>
									<table>
										<thead>
											<tr>
												<th class="nickname">닉네임</th>
												<th class="id">아이디</th>
												<th class="leader"></th>
											</tr>
										</thead>
										<tbody class="member-list">
											<c:forEach var="member" items="${list }">
												<tr>
													<td>${member.nickname }</td>
													<td>${member.gome_me_id}</td>
													<td class="member-manage-btn">
														<a class="btn btn-outline-danger set-leader" data-id="${member.gome_me_id}">리더 만들기</a>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<div class="manage-info-option">
					<div class="info-option-title">그룹 삭제</div>
					<div class="info-option-content">
						<c:url var = 'url' value = '/group/delete'>
	      					<c:param name = 'groupNum' value = "${group.go_num }"/>
	      				</c:url>
						<a class="btn btn-outline-danger delete-group-btn">그룹 삭제</a>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<!-- 그룹이름 변경 script -->
<script type="text/javascript">
$(".change-group-name-btn").click(function(){
	$.ajax({
		async : false, 
		url : '<c:url value="/group/manage/info/update"/>', 
		type : 'post', 
		data : {
			num : ${group.go_num},
			name: $("[name=group-name]").val()
		}, 
		dataType : "json", 
		success : function (data){
			if(data.data == "ok"){
				alert("그룹 이름이 수정되었습니다.")
				$(".group-title").text($("[name=group-name]").val())
			}else{
				alert("권한이 없습니다.")
			}
			
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("그룹 이름을 수정하지 못했습니다. (에러발생)")
		}
	});
})
</script>

<!-- 타이머 초기화 script -->
<script type="text/javascript">
function resetTimer(){
	if(confirm('타이머를 초기화 하시겠습니까? 복구할 수 없습니다.')){
		$.ajax({
			async : false, 
			url : '<c:url value="/group/manage/info/timereset"/>', 
			type : 'post', 
			data : {
				num : ${group.go_num}
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data == "ok"){
					alert("타이머가 초기화되었습니다.")
				}else{
					alert("권한이 없습니다.")
				}
				
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("타이머를 초기화하지 못했습니다. (에러발생)")
			}
		});
	}
	return;
}
</script>

<!-- 그룹 얼리기 script -->
<script type="text/javascript">

</script>


<!-- 그룹 리더 변경 script -->
<script type="text/javascript">

$(".set-leader").click(function(){
	if(confirm($(this).data("id") + '님에게 현재 사용자가 가진 리더 권한을 위임합니다. 진행하시겠습니까?')){
		$.ajax({
			async : true, 
			url : '<c:url value="/group/manage/info/changeleader"/>', 
			type : 'post', 
			data : {
				num : ${group.go_num},
				id : $(this).data("id")
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data == "ok"){
					alert("그룹 리더가 변경되었습니다.")
					location.href = '<c:url value="/group/home?num=${group.go_num}"/>'					
				}else{
					alert("권한이 없습니다.")
				}
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("그룹 리더를 수정하지 못했습니다. (에러발생)")
			}
		});
		
	}else{
		return
	}
	
})

<!-- 멤버 리스트 hover 설정 -->
$(document).on("mouseover",".member-list tr", function(){
	$(this).children('.member-manage-btn').css("visibility", "visible")
})

$(document).on("mouseout",".member-list tr", function(){
	$(this).children('.member-manage-btn').css("visibility", "hidden")
})
</script>

<!-- 그룹 삭제 script -->
<script type="text/javascript">
$(".delete-group-btn").click(function(){
	if(confirm('그룹을 삭제하시겠습니까? 삭제된 그룹은 복구할 수 없습니다.')){
		$.ajax({
			async : false, 
			url : '<c:url value="/group/manage/info/deletegroup"/>', 
			type : 'post', 
			data : {
				num : ${group.go_num}
			}, 
			dataType : "json", 
			success : function (data){
				if(data.data == "ok"){
					alert("그룹이 삭제되었습니다.")
					location.href = '<c:url value="/mygroup/list"/>'
				}else{
					alert("권한이 없습니다.")
				}
				
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert("그룹을 삭제하지 못했습니다. (에러발생)")
			}
		});
	}
	return
})
</script>
</body>
</html>