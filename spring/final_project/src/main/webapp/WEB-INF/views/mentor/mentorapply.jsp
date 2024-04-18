<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.mentor-container{
		width : 1200px;
		margin : 0 auto;
	}
	
	.mentor-container img{
		display : block;
		margin : 100px auto;
	}
	.text-wrap{
		text-align : center;
	}
	.mentor-container button{
		display: block;
		margin : 100px auto;
		width : 550px;
		height : 60px;
		border-radius : 5px;
		background-color: #E6F5E5;
		color : #497C36;
		font-weight : bold;
		font-size : 24px;
	}
</style>
</head>
<body>
<div class="mentor-container">
	<img alt="mentor-img" src="<c:url value="/resources/img/mentor.png"/>">
	<div class="text-wrap">
		<h2>Mentoring</h2>
		<p style="margin-top : 60px; margin-bottom: 60px;">
			업계 후배들 혹은 동료들과 지식을 나눠 보세요.<br>
			멘토가 되어 당신의 후배, 동료들이<br>
		  	더 빨리, 더 멀리 갈 수 있도록 도와주세요.<br>
			<br>
		    지식을 나누며 커리어를 쌓아보세요.<br>
		    멘토가 되어 전문성을 향상할 수 있습니다.<br>
			<br>
			지식공유자라면 누구나 멘토가 될 수 있습니다.<br>
			<br>
			멘토링을 통해 성장했다면 강의를 올릴 수 있게됩니다.</p>
	</div>
	<button class="btn-apply-link">멘토 신청하러 가기</button>
</div>

<script type="text/javascript">
$('.btn-apply-link').click(function(){
	$.ajax({
		url : '<c:url value="/mentor/check"/>',
		type : 'get',
		beforeSend : function(xmlHttpRequest){
			xmlHttpRequest.setRequestHeader("AJAX", "true");
			},
		success : function(data, textStatus, jqXHR){

			if(data==="true"){
				location.href="<c:url value='/mentor/insert'/>";
			}else if(data ==="false"){
				alert("이미 멘토신청을 완료한 계정입니다.")
				location.href = "<c:url value='/mentor/apply'/>"
			}else if(jqXHR.getResponseHeader("SESSION_EXPIRED") === "true"){
				if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까?')){
					location.href = "<c:url value='/login'/>";
				}
			}
		},error : function(xhr, textStatus, errorThrown){
			console.log(xhr)
		}
		
	})
	
})

</script>

</body>
</html>