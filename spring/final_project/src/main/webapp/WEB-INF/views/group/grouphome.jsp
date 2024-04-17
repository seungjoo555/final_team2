<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.container{width:1570px; background-color: #F9F9F9; margin: 100px auto 200px auto; padding: 60px 0; box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);}
	
	/* info-bar style*/
	.container-info-bar{height: 90px; width: 90%; margin: 0 auto;}
	
	.container-info-bar>*{line-height: 90px; float:left; color: #243323; font-size: 36px;}
	.container-info-bar::after{content: ''; display: block;  clear:both;}

	.container-info-bar [class$=title]{font-weight: 900;}
	
	[class$=-bg]{width: 90%; margin: 30px auto; background-color: white; padding: 55px 0; 
		display:flex; flex-direction: column; justify-content: center; align-items: center;}
	
	/*list 내부 요소 style*/
		[class$=list]{width: 90%;}
		
		/*list 내부 info 요소 style*/
		[class$=list] [class$=info] *{float:left}
		[class$=list] [class$=info]::after{content: ''; display: block;  clear:both;}
		
		[class$=list] [class$=info] .image{width: 60px; height: 60px; border: solid black 1px;}
	/* =================================================================================== */
	
	.group-title{width: 100%; height: 50px; font-size: 24px; border-bottom: 1px solid #9C9C9C;}
	.group-title a{color: black; font-weight: bold; text-decoration: none;}
	
</style>
</head>
<body>
	<div class="container">
		그룹홈
	</div>
</body>
</html>