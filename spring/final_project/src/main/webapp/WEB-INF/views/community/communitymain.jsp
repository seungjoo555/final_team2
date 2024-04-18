<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.community-wrap{
		width : 1200px;
	}
	.community-content-wrap{
		
	}
	.h-wrap{
		margin-top : 100px;
		text-align: left;
	}
	.hot-wrap{
		width : 100%;
		height : 275px;
		border-radius : 5px;
		border : 1px solid black;
	}
	
	.hot-head-wrap{
		padding : 20px;
		display:flex;
		justify-content: space-between;
	}
	
	.contents-wrap {
		height: 1200px;
	}
	.board-button-wrap{
		margin-top: 100px;
		float:left;
		box-sizing: border-box;
		width: 15%;
	}
	
	.board-btn{
		width : 140px;
		padding : 10px;
		border: 1px solid black;
		border-radius : 5px;
		margin-right: 10px;
		margin-bottom: 10px;
		background-color : white;
	}
	
	.contentsssssss {
		margin-top: 100px;
		width: 70%;
		float: right;
		box-sizing: border-box;
	}

</style>
</head>
<body>
<div class="community-wrap">
	<div class="community-content-wrap">
		<div class="h-wrap">
			<h2>스모 커뮤니티</h2>
			<p>소통을 위한 공간입니다.</p>
		</div>
		<div class="hot-wrap">
			<div class="hot-head-wrap">
				<p>HOT 이번주 전체 인기글</p>
				<a href="">더보기></a>
			</div>
		</div>
		<div class="contents-wrap">
			<div class="board-button-wrap"></div>
			<span class="contentsssssss">dksjldkjfslkdfjalfdafdsa</span>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			url : "<c:url value='/community/board'/>",
			type : 'get',
			success : function (data){
				
				let str = `<button class="board-btn">전체글</button>`;
				for(board of data.boardList){
					console.log(board);
					str += '<button class="board-btn" value="board.board_num">' + board.board_name + '</button>' 
				}
				$('.board-button-wrap').html(str);
			}, error : function(){
				
			}
		})
	});

</script>
</body>
</html>