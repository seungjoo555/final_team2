<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.manage-community-container{
		background-color : #F9F9F9;
		height : 1200px;
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	    transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.manage-community-container:hover {
	  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	
	.insert-wrap{
		display : block;
		text-align : right;
		margin-right : 180px;
		margin-top : 50px;
		margin-bottom : 30px;
	}
	.box-pagination{
		margin-top : 50px;
	}
	
	.insert-wrap input{
		width : 450px;
		height : 40px;
		border : 1px solid black;
		border-radius : 5px;
		background-color: #EBEBEB;
	}
	
	.insert-wrap button{
		width : 110px;
		background-color : #649B60;
		color : white;
		height : 40px;
		border : 1px solid black;
		border-radius : 5px;
	}
	
	.h-wrap {
		margin-left : 180px;
		padding-top : 30px;
	}
	.h-wrap h2{
		font-weight: bold;
	}
	
	.community-list{
		margin : 0 auto;
		border : 1px solid black;
		height : 850px;
		width : 70%;
	}
	.instance-wrap{
		margin-top : 28px;
		margin-left : 18px;
		
	}
	.community-instance{
		display : flex;
		height : 50px;
		margin-bottom: 10px;
	}
	.button-wrap{
		width:33%;
		height:50px;
	}
	.boName-box{
		width :33%;
	}
	.boCount-box{
		width:33%;
	}
	
	.btn-update{
		width : 45%;
		height : 60%;
		border : 1px solid black;
		border-radius : 5px;
		background-color : #649B60;
		color : white;
	}
	.btn-delete{
		width : 45%;
		height : 60%;
		border : 1px solid black;
		border-radius : 5px;
		background-color: orange;
		color : black;
	}
	.board-name{
		font-weight: bold;
	}
	
	.community-instance p{
		font-size: 18px;
	}
	
	.board-input{
		width : 530px;
		height : 35px;
		border : 1px solid black;
		border-radius : 5px;
		background-color: white;
	}
	
	.btn-board-complete{
		width : 242px;
		height : 35px;
		border-radius : 5px;
		background-color : #649B60;
		border : 1px solid black;
		margin-left : 10px;
		color : white;
	}
	
	.btn-board-complete:hover{
		background-color : #42D538;
		color : black;
	}
	
	.insert-wrap input::placeholder,
	.board-input::placeholder {
	    padding-left: 10px;
	}


</style>
</head>
<body>
<div class="manage-community-container">
	<div class="h-wrap">
		<h2>커뮤니티 게시판 관리</h2>
	</div>
	<div class="insert-wrap">
		<input type="text" placeholder="추가할 게시판 이름을 입력해주세요" class="insert-board" name="board_name">
		<button type="button" class="btn-insert">추가</button>
	</div>
	<div class="community-list">
		<div class="instance-wrap">
			
		</div>
		<div class="box-pagination">
			<ul class="pagination justify-content-center">
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
let cri = {
		page : 1,
		search : ""
	}
getBoardList();
	
	//게시판 출력
	function getBoardList(){
		let str= '';
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/managecommunity/list"/>", 
			type : 'post', 
			data : JSON.stringify(cri),
			//서버로 보낼 데이터 타입
			contentType : "application/json; charset=utf-8",
			//서버에서 보낸 데이터의 타입
			dataType :"json", 
			success : function (data){
				for(board of data.boardList){
					str +=
						`
						<div class="community-instance">
							<div class="boName-box">
								<p class="board-name">\${board.board_name}</p>
							</div>
							<div class="boCount-box">
								<p class="board-count">게시글 \${board.board_post_count}개</p>
							</div>
							<div class="button-wrap">
								<button type="button" class="btn-update" data-bonum="\${board.board_num}">수정</button>
								<button type="button" class="btn-delete" data-bonum="\${board.board_num}">삭제</button>
							</div>
						</div>
						`
						;
				}
				$('.instance-wrap').html(str);
				displayMentorInfoPagination(data.pm)
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	
	}
	
	<!--페이지네이션 생성-->
	function displayMentorInfoPagination(pm){
		let str = '';
		if(pm.prev){
			str +=
				`<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.startPage - 1}" >이전</a>
			    </li>`;
		}
		
		for(let i = pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active':'';
			str +=
				`
				 <li class="page-item \${active}">
				 	<a class="page-link" href="javascript:void(0)" data-page="\${i}" >\${i}</a>
			    </li>				
				`;
		}
		
		if(pm.next){
			str +=
				`
				<li class="page-item">
					<a class="page-link" href="javascript:void(0)" data-page="\${pm.endPage + 1}" >다음</a>
			    </li>				
				`;
		}
		$('.box-pagination>ul').html(str);
	}
	
	<!-- 페이지네이션 클릭 -->
	$(document).on('click','.box-pagination .page-link',function(){
		cri.page = $(this).data('page');
		getBoardList(cri);
	});
	
	//게시판 등록 클릭
	$('.btn-insert').click(function(){
		let board_name = $('.insert-board').val()
		if(board_name ==null || board_name.trim().length==0 || board_name.trim().length>13){
			alert("게시판 이름은 2글자~13글자만 가능합니다.")
			return false;
		}
		
		$.ajax({
			async : true,
			url :"<c:url value='/admin/managecommunity/insert'/>",
			type : 'post',
			data : {board_name: board_name},
			success : function(data){
				switch(data){
				case "-2" : alert("게시판 등록 실패 : 게시판 이름은 2글자~13글자만 가능합니다."); break;
				case "-1" : alert("게시판 등록 실패 : 이미 존재하는 게시판 이름입니다."); break;
				case "1" : alert("게시판 등록 성공"); location.reload(); break;
				}
				
			},error : function(jqXHR, textStatus, errorThrown){
				
			}
		})
	})
	
	
	//수정버튼 클릭
	$(document).on('click','.btn-update',function(){
		let board_num = $(this).data("bonum");
		initBoard();
		$(this).closest('.community-instance').find('.boName-box').hide();
		$(this).closest('.community-instance').find('.boCount-box').hide();
		let board_name = $(this).closest('.community-instance').find('.boName-box').text();
		let input = 
			 `
			 <input type="text" class="board-input" id="newBo_name" placeholder="수정할 게시판 이름" name="newBo_name" value="\${board_name.trim()}"></input>
			 `;
		$(this).closest('.community-instance').append(input); // 수정된 부분: 입력창이 추가될 위치를 변경
	    $(this).parent().hide();
	    let btn = 
	        `
	       	 	<button class="btn-board-complete" data-bonum="\${board_num}">수정완료</button>
	        `;
	    $(this).closest('.community-instance').append(btn); // 수정된 부분: 수정완료 버튼이 추가될 위치를 변경
	})
	
	//수정완료 버튼 클릭
	$(document).on('click','.btn-board-complete',function(){
		let board_num = $(this).data("bonum");
		let board_name = $('.board-input').val();
		
		if(board_name==null||board_name.trim().length==0 || board_name.trim().length>13){
			alert("게시판 이름은 2글자~13글자만 가능합니다.")
			return false;
		}
		
		$.ajax({
			async : true,
			url : "<c:url value='/admin/managecommunity/update'/>",
			type : 'post',
			data : {board_num: board_num,
					board_name: board_name},
			success : function(data){
				switch(data){
				case "-2" : alert("게시판 수정 실패 : 게시판 이름은 2글자~13글자만 가능합니다."); break;
				case "-1" : alert("게시판 수정 실패 : 이미 존재하는 게시판 이름입니다."); break;
				case "1" : alert("게시판 수정 성공"); location.reload(); break;
				}
				
				
			},error : function(jqXHR, textStatus, errorThrown){
				
			}
			
		})
		
		
	})
	//게시판 수정 초기화
	function initBoard(){
	    //게시판 이름 보여주기
	    $(".boName-box").show();
	    $(".boCount-box").show();
	    //감추었던 수정/삭제 버튼을 보여줌
	    $(".button-wrap").show();
	    //게시판 입력창 삭제
	    $(".board-input").remove();
	    //추가된 버튼 삭제
	    $(".btn-board-complete").remove();
	};
	
	//삭제
	$(document).on('click','.btn-delete',function(){
		
		if(!confirm("게시판을 삭제할시, 게시판 안에 속한 모든 게시글들 또한 삭제됩니다. 진행하시겠습니까?")){
			return false;
		}
		
		let board_num = $(this).data("bonum");
		$.ajax({
			async : true,
			url : "<c:url value='/admin/managecommunity/delete'/>",
			type : 'post',
			data : {board_num: board_num},
			success : function(data){
				if(data=="true"){
					alert("게시판을 삭제하였습니다.");
					location.reload();
				}else if(data=="false"){
					alert("게시판을 삭제하지 못했습니다.");
					
				}
				
			},error : function(jqXHR, textStatus, errorThrown){
				
			}
		})
		
		
	})
	
</script>
</body>
</html>