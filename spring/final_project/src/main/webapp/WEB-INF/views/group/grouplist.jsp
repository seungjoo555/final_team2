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
   <section class="menu-bar">
      <div class="group-category" onclick="">
         <span class="group-category-item all" >전체</span>
      </div>
      <div class="group-category">
         <span class="group-category-item study">스터디</span>
      </div>
      <div class="group-category">
         <span class="group-category-item project">프로젝트</span>
      </div>
      <div class="group-category group-category-insert">
         <a class="btn-outline-success insert" href="<c:url value="/recruit/insert"/>">모집글 작성</a>
      </div>
   </section>
</div>

</body>
</html>