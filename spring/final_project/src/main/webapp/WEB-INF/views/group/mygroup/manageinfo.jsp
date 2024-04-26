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
	
	
	/* ======================================= groupmanage.jsp ============================================ */
	
	.manage-info-bg{padding: 55px 30px;}
	
	.manage-info-option{margin-bottom: 30px;}
	.manage-info-option .info-option-title{width: 100%; font-size: 18px; font-weight: bold; color: #243323; border-bottom: 1px solid #C9C9C9;}
	.manage-info-option .option-sub{font-weight: normal; text-align: right; color: #4F4F4F; width: 70%;
		font-size: 14px; line-height: 28px;}
	.manage-info-option .info-option-content{padding: 20px;}
	
	/* 그룹 정보 관리 관련 style */
	[name=group-name]{border-bottom: 1px solid #C9C9C9;}
	[name=group-name]:focus{outline: none; background-color: #C9C9C9;}
	
	.change-group-name-btn{height: 28px; line-heiht: 28px; padding: 2px 12px;}
	
</style>
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
						<a onclick="" class="btn btn-outline-danger">초기화</a>
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
						멤버리스트 출력
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

</script>

<!-- 그룹 얼리기 script -->
<script type="text/javascript">

</script>


<!-- 그룹 리더 변경 script -->
<script type="text/javascript">

</script>

<!-- 그룹 삭제 script -->
<script type="text/javascript">
$(".delete-group-btn").click(function(){
	alert("삭제")
})
</script>
</body>
</html>