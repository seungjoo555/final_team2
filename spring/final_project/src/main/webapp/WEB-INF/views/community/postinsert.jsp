<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
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
	.post-form-group #post_name{
		height : 50px;
		border-radius : 5px;
		border : 1px solid black;
		margin-bottom: 46px;
	}
	.btn-wrap {
		display : block;
		text-align: center;
		padding : 50px;
	}
	.btn-wrap button{
		width : 433px;
		height : 70px;
		color : white;
		border-radius : 5px;
		background-color: #2D65F2;
	}
	
	.h-wrap option{
		text-align : center;
		font-weight : bold;
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
			<input type="text" name="post_name" id="post_name" placeholder="제목을 입력해주세요.">
		</div>
		<div class="post-form-group">
			<textarea class="post_content" id="post_content" name="post_content"></textarea>
		</div>
		<div class="btn-wrap">
			<button class="post-insert-btn">게시글 등록</button>
		</div>
	</form>
</div>
<script type="text/javascript">
$('[name=post_content]').summernote({
	placeholder: '내용을 입력하세요.',
	tabsize: 2,
	height: 400
});
</script>
</body>
</html>