<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.form-wrap{
		width : 1200px;
		padding : 100px;
		margin : 0 auto;

	}

	.post-form-group{
		margin : 0 auto;
	}
	
	.h-wrap{
		display : flex;
	}
	.h-wrap select{
		width : 20%;
		height : 39px;
		margin-left : 30px;
	}
	

	.post-form-group input{
		margin-top : 46px;
		width : 100%;
	}
	.post-form-group #title{
		height : 50px;
		border-radius : 5px;
		border : 1px solid black;
	}
</style>
</head>
<body>
<div class="form-wrap">
	<form action="<c:url value="/post/insert"/>" method="post">
		<div class="h-wrap">
			<h2>게시판</h2>
			<select name="post_board_num" class="board-form-control">
				<c:forEach items="${boardList}" var="board">
					<option value="${board.board_num}">${board.board_name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="post-form-group">
			<input type="text" name="title" id="title" placeholder="제목을 입력해주세요.">
		</div>
	</form>
</div>

</body>
</html>