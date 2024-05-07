<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/adminreport.css"/>" >
<title>관리자 - 신고관리</title>

</head>
<body>
<div class="container">	
	<h1>신고 관리</h1>
	<div class="admin-header">
		<form action="<c:url value="/admin/report"/>" method="get" id="typeForm">
			<div class="input-group mb-3">
				<div class="select-box">
					<select name="type" class="form-control" name="type">
						<option value="all" <c:if test="${pm.cri.type == 'all'}">selected</c:if>>전체</option>
						<option value="recruit" <c:if test="${pm.cri.type == 'recruit'}">selected</c:if>>모집공고</option>
						<option value="mentoring" <c:if test="${pm.cri.type == 'mentoring'}">selected</c:if>>멘토링</option>
						<option value="lecture" <c:if test="${pm.cri.type == 'lecture'}">selected</c:if>>강의</option>
						<option value="member" <c:if test="${pm.cri.type == 'member'}">selected</c:if>>유저</option>
						<option value="post" <c:if test="${pm.cri.type == 'post'}">selected</c:if>>게시글</option>
						<option value="comment" <c:if test="${pm.cri.type == 'comment'}">selected</c:if>>댓글</option>
					</select> 
				</div>
				<div class="count-report">신고된 게시글 : </div>
				<div class="check-view-box">
					<input name="search" value="대기중" type="checkbox" id="check-view" <c:if test="${pm.cri.search == '대기중'}">checked</c:if> >
					<label for="check-view" > <span>미처리 된 신고 항목만 보기</span></label>
				</div>
			</div>
		</form>
	</div>
		<table class="table table-hover">
			<thead>
				<tr>
			        <th><input class="total-check-report" type="checkbox"></th>
			        <th>신고횟수</th>
			        <th>신고 대상 타입</th>
			        <th>신고 대상</th>
			        <th>신고상세</th>
			        <th>처리상태</th>
			      </tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(rsList) == 0}">
					<tr>
						<td colspan="6">신고된 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${fn:length(rsList) != 0}">
					<c:forEach items="${rsList}" var="report">
						<tr>
							<td><input class="check-report" type="checkbox"></td>
							<td>${report.repo_count}</td>
							<td>${report.repo_table_str}</td>
							<td>${report.repo_target_str}</td>
							<td><button class="report-detail-btn" type="button" value="${report.repo_table}" data-target="${report.repo_target}">신고상세</button></td>
							<td>${report.repo_repo_state}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		
	<!-- 페이지네이션 -->
	<div class="box-pagination">
		 <ul class="pagination justify-content-center">
		 	<c:if test="${pm.prev}">
		 		<c:url value="/admin/report" var="url">
		 			<c:param name="page" value="${pm.startPage - 1 }"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item">
			    	<a class="page-link" href="${url}">이전</a>
			    </li>
		 	</c:if>
		 	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
		 		<c:url value="/admin/report" var="url">
		 			<c:param name="page" value="${i}"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item <c:if test="${pm.cri.page == i }">active</c:if>">	
			    	<a class="page-link" href="${url}">${i}</a>
			    </li>
		 	</c:forEach>
		    <c:if test="${pm.next}">
		    	<c:url value="/admin/report" var="url">
		 			<c:param name="page" value="${pm.endPage + 1 }"></c:param>
		 			<c:param name="type" value="${pm.cri.type}"></c:param>
		 			<c:param name="search" value="${pm.cri.search}"></c:param>
		 		</c:url>
			    <li class="page-item">
			    	<a class="page-link" href="${url}">다음</a>
			    </li>
		    </c:if>
	 	</ul>
	</div>
  
  <!-- 상세화면 -->
   <div id="modal" class="modal admin-report-modal" style="display:none;">
      <div id="dimmed" class="dimmed admin-report-dimmed"></div>
      <div class="admin-report-container">
      	<div class="admin-report-box"></div>
      </div>
   </div>
  
	<!-- 회원 처리 화면 -->

</div>

<!-- 신고 상세 버튼 클릭 이벤트 -->
<script type="text/javascript">
$(document).on('click', '.report-detail-btn', function(){
	//모달창 활성화 
	$("#modal").css('display','block');
   //스크롤 비활성화
	$("body").css('overflow','hidden');
   //테이블과 타켓 정보 받아오기
   let repo_target = $(this).data("target");
   let repo_table =$(this).val();
   
	getReportList(repo_target, repo_table);
	function getReportList(repo_target, repo_table){
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : "<c:url value="/admin/report/detail"/>", 
			type : 'post', 
			data : {
				repo_target :  repo_target,
				repo_table :  repo_table
			},
			dataType :"json", 
			success : function (data){
				displayReportList(data.rpList);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			}
		});	//ajax end
	}	//getReportList(repo); end
	
   
	function displayReportList(rpList){
		let str = '', table='';
		
		if(rpList == null || rpList.length == 0){
			table +=
				`
				<tr>
					<td colspan="3">신고된 내역이 없습니다.</td>
				</tr>
				`;
		}else{
			for(var i=0; i< rpList.length; i++){
				report = rpList[i];
				let dateStr = convertDate(report.repo_date);
				table += 
					`
					<tr>
						<td>\${report.repo_me_id}</td>
						<td>\${report.repo_detail}</td>
						<td>\${dateStr}</td>
					</tr>
					`
			}
		}
		
		//바로가기 주소 가져오기
		
		
		
		str += 
			`
			<div class="amidn-report-header">
		      		<div class="header-title"><h1>신고 내역</h1></div>
		      		<div class="btn-cancel"> <button>X</button> </div>
		      	</div>
		      	<div class="amidn-report-body">
		      		<div class="box-targe-link">
		      			<div class="report-target-title">신고대상</div>
		      			<a href="<c:url value=""/>" class="report-target-link">바로가기(클릭)</a>
		      		</div>
		      		<div class="box-report-table">
		      		<table class="table table-hover">
						<thead>
							<tr>
						        <th>신고자 ID</th>
						        <th>신고 사유</th>
						        <th>신고 일자</th>
					       </tr>
						</thead>
						<tbody class="tdoby-scroll">
		      `
		      +
		      table
		      +
		      `
						</tbody>
					</table>
		      		</div>
		      	</div>
		      	<div class="amidn-report-footer">
		      		<div class="box-report-process-btn"><button class="report-process-btn">신고 처리하기</button></div>
				</div>
			`
      $('.admin-report-box').html(str);
	}
   
   
   
})

//날짜 변경 함수
function convertDate(milliSecond) {
  const days = ['일', '월', '화', '수', '목', '금', '토'];
  const data = new Date(milliSecond);  //Date객체 생성

  const year = data.getFullYear();    //0000년 가져오기
  const month = data.getMonth() + 1;  //월은 0부터 시작하니 +1하기
  const date = data.getDate();        //일자 가져오기
  const day = days[data.getDay()];    //요일 가져오기

  //return `${year}.${month}.${date}. (${day})`;
  return `\${year}.\${month}.\${date}`;
}


/* dimmed 클릭 시 모달창 비활성화 */
$(document).on('click', '#dimmed', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})
/* X 클릭 시 창 없애기 */
$(document).on('click', '.btn-cancel', function(){
   $("#modal").css('display','none');
   $("body").css('overflow','visible');
})
</script>


<script type="text/javascript">
$("[name=type]").change(function(){
	$("#typeForm").submit();
})
$("#check-view").change(function(){
	if($("#check-view").prop("checked")){
		${pm.cri.search == '대기중'}
		$("#typeForm").submit();
	}else{
		${pm.cri.search == ''}
		$("#typeForm").submit();
	}
})

$(document).on('click', '.total-check-report', function(){
	if($(".total-check-report").prop("checked")){
		$("input:checkbox[id='check-report']").prop('checked',true);
	}else{
		$("input:checkbox[id='check-report']").prop('checked',false);
	}
})
</script>
</body>
</html>