<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/profile.css"/>">
</head>
<body>
<div class="mygroup-mutual-container">
	<c:if test="${member.me_id == user.me_id }">
		<h3 class="mygroup-mutual">상호평가</h3>
		<div class="mutual-list-box">
			<ul class="mutual-list">
				<c:choose>
					<c:when test="${empty mutualReviewList}">
						<li class="mutual-no-item">진행된 상호평가가 존재하지 않습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach items="${mutualReviewList}" var="mure">								
							<li class="mutual-item">
								<!-- 프로젝트/스터디 구분 -->
								<c:if test="${mure.recu_type== '0'}">
									<div class="item-study">스터디</div>
								</c:if>
								<c:if test="${mure.recu_type== '1'}">
									<div class="item-project">프로젝트</div>
								</c:if>
								<!-- 상호평가 내용 -->
								<div class="mutual-item-category" >
									<div class="item-category">${mure.mure_content}</div>
								</div>  
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
</div>

<div class="mygroup-study-container">	
	<c:if test="${member.me_id == user.me_id }">
		<h3 class="mygroup-study">스터디 / 프로젝트</h3>
		<div class="study-list-box">
			<ul class="study-list">
				<c:choose>
					<c:when test="${empty groupList}">
						<li class="" style="font-weight: 700">내가 생성한 그룹</li>
						<li class="">내가 생성한 그룹이 존재하지 않습니다.</li>
					</c:when>
					<c:otherwise>
						<li class=""style="font-weight: 700">내가 생성한 그룹</li>
						<c:forEach items="${groupList}" var="grouplist">
							<a class="study-item-container" data-num="${grouplist.recu_num}" style="display: block;">
								<li class="study-item">
									<div class="study-list-item-category">
										<c:if test="${grouplist.goap_state == -1}">
											<div class="item-category">진행 중</div>
										</c:if>
									</div>
									<div class="study-list-item-content">
										<div class="study-list-item-title">
											${grouplist.recu_topic} 
										</div>
										<div>
											<c:forEach items="${totalCategory1}" var="cate">
												<c:if test="${grouplist.recu_num == cate.toCt_table_pk}">
													<ul>
														<li class="recruit-position">${cate.toCt_progCt_name}</li>
													</ul>
												</c:if>
											</c:forEach>
										</div>
										<div>
											<c:forEach items="${totalLanguage1}" var="lang">
												<c:if test="${grouplist.recu_num == lang.toLg_table_pk}">
													<ul>
														<li class="recruit-position">${lang.toLg_lang_name}</li>
													</ul>
												</c:if>
											</c:forEach>
										</div>
										<div class="box-border-line">
											<div class="border-line"></div>
										</div>
										<div>
											<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
											${grouplist.recu_gome_me_nickname}
										</div>
										<div>
											${grouplist.go_member_count} / ${grouplist.recu_count}
										</div>
									</div>
								</li>
							</a>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${empty groupApplyList}">
						<li class="" style="font-weight: 700">내가 지원한 그룹</li>
						<li class="">내가 지원한 그룹이 존재하지 않습니다.</li>
					</c:when>
					<c:otherwise>
						<li class="" style="font-weight: 700">내가 지원한 그룹</li>
						<c:forEach items="${groupApplyList}" var="applylist">
							<li class="apply-item">
								<div class="apply-list-item-category">
									<c:if test="${applylist.goap_state == 0}">
										<div class="item-category">수락 대기</div>
									</c:if>
									<c:if test="${applylist.goap_state == 1}">
										<div class="item-category">진행 중</div>
									</c:if>
									<c:if test="${applylist.goap_state == 2}">
										<div class="item-category">반려</div>
									</c:if>
								</div>
								<div class="apply-list-item-title">
									${applylist.recu_topic}
								</div>
								<div>
									<c:forEach items="${totalCategory2}" var="cate">
										<c:if test="${applylist.recu_num == cate.toCt_table_pk}">
											<ul>
												<li class="recruit-position">${cate.toCt_progCt_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
								<div>
									<c:forEach items="${totalLanguage2}" var="lang">
										<c:if test="${applylist.recu_num == lang.toLg_table_pk}">
											<ul>
												<li class="recruit-position">${lang.toLg_lang_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
								<div class="box-border-line">
									<div class="border-line"></div>
								</div>
								<div>
									<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
									${groupKing}
								</div>
								<div>
									${applylist.go_member_count} / ${applylist.recu_count}
								</div>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
</div>

<div class="mygroup-mentoring-container">
	<c:if test="${member.me_id == user.me_id }">
		<h3 class="mygroup-mentoring">멘토링</h3>
		<div class="mutual-list-box">
			<ul class="mutual-list">
				<c:choose>
					<c:when test="${empty mentoringList}">
						<li>나의 멘토링이 존재하지 않습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach items="${mentoringList}" var="ment">			
							<li class="mutual-item">
								<!-- 멘토링 허용여부 : mentAp_state -->
								<c:if test="${ment.mentAp_state== '-1'}">
									<div class="item-project">반려</div>
								</c:if>
								<c:if test="${ment.mentAp_state== '0'}">
									<div class="item-study">수락 대기</div>
								</c:if>
								<c:if test="${ment.mentAp_state== '1'}">
									<div class="item-project">진행중</div>
								</c:if>
								<!-- 클래스 이름 : mentoring.ment_title-->
								<div>${ment.ment_title}</div>
								<!-- 직무 : ment_job-->
								<div>직무 : ${ment.ment_mentIf_job}</div>
								
								<!-- 경력 : mentIf_exp-->
								<div>경력 : ${ment.ment_mentIf_exp}년</div>
								
								<!-- 분야 : 분야모음 -->
								<div>
									분야 : <br/>
									<c:forEach items="${mentoCategory}" var="ment_cate">
										<c:if test="${ment.ment_num == ment_cate.toCt_table_pk }">
											${ment_cate.toCt_progCt_name}
										</c:if>
									</c:forEach>							
								</div>
								
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
	<!-- 스터디/프로젝트 지원자 리스트 상세화면 -->
   <div id="modal" class="modal apply-study-modal" style="display:none;">
      <div id="dimmed" class="dimmed apply-study-dimmend"></div>
      <div class="apply-study_container">
      	<div class="apply-study_box">
      	</div>
      </div>
   </div>
</div>

<script type="text/javascript">

	/* 리스트 출력 */
	let cri = {
			page : 1,
			type : "",
			search : ""
	}


	/* 스터디/프로젝트 지원자 리스트 - 상세화면 */
	
	$(document).on('click', '.study-item-container', function(event) {
		let recu_num = $(this).data("num");
		console.log(recu_num);
		
		$('#modal').css('display', 'block');
		
		 //스크롤 비활성화
	   	$('body').css('overflow','hidden');
		 
		getStudy(recu_num);
		function getStudy(recu_num){
			console.log(recu_num);
			$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : "<c:url value="/applyList/detail"/>", 
					type : 'get', 
					data : {
						recu_num : recu_num
					},
					dataType :"json", 
					success : function (data){
						console.log(data);
						displayStudyDetail(data.recruit, data.groupApply);
					}, 
					error : function(jqXHR, textStatus, errorThrown){
					}
				});	//ajax end
		}
	});
	
	function displayStudyDetail(recruit, groupApply) {
		let str="";
		
		if(!groupApply || groupApply.length === 0 || groupApply.goap_me_id == "" || groupApply.goap_me_nickname == "") {
			str += 
				`
				<div class="apply-study_header">
		      		<div class="header-title"><h3>지원자 리스트</h3></div>
		      		<div class="btn-cancel"><button>X</button></div>
		      	</div>
		      	<div class="apply-study_body-no">
					<div class="no-apply">지원자가 없습니다.</div>
				<div>
				`
			$('.apply-study_box').html(str);
			return;
		}
		
		str += 
			   `
				<div class="apply-study_header">
					<div class="header-title"><h3>지원자 리스트</h3></div>
					<div class="btn-cancel"><button>X</button></div>
				</div>
				`;
				
		$.each(groupApply, function(index, item) {
			str +=
				`
				<div class="apply-study_body">
					<div class="memberInfo" >
						<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
						<div class="memberNickname" value="${item.goap_me_id}">\${item.goap_me_nickname}</div>
					</div>
				</div>
				<div class="apply-study_footer">
				`;
			
			if(item.goap_state == 0) {
				str += 
					`
					<div class="btn-apply-box">
						<div class="btn-accept-box"><button type="button" class="btn-accept" value="\${recruit.recu_num}">수락</button></div>
						<div class="btn-refuse-box"><button type="button" class="btn-refuse" value="\${recruit.recu_num}">거절</button></div>
					</div>
					`;
			}
			
			str += 
				`
					<div class="apply-box-border-line"><div class="apply-border-line"></div></div>
				</div>
				
		   `;
		});
		
		$('.apply-study_box').html(str);
	}
	
	/* dimmed 클릭 시 창 없애기 */
	$(document).on('click', '#dimmed', function(){
	   $("#modal").css('display','none');
	   $("body").css('overflow','visible');
	});
	
	/* X 클릭 시 창 없애기 */
	$(document).on('click', '.btn-cancel', function(){
	   $("#modal").css('display','none');
	   $("body").css('overflow','visible');
	});
	
	/* 수락 버튼 클릭 이벤트*/
	$(document).on('click', '.btn-accept', function() {
		// confirm('수락하면 같은 그룹이 됩니다. 정말 수락하시겠습니까?')
		if (confirm("수락하면 같은 그룹이 됩니다. 정말 수락하시겠습니까?") == true) {
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : "<c:url value="/group/apply"/>", 
				type : 'post', 
				data : JSON.stringify(groupApVo), 
				contentType : "application/json; charset=utf-8",
				dataType : "json", 
				success : function (data){
					if(data.result){
						alert("수락했습니다.");
						$("#modal").css('display','none');
					   $("body").css('overflow','visible');
					}else{
						alert("멘토링을 신청하지 못했습니다.");
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){	//errorThrown얘는 거의 비어있음(굳이 체크 안하기로)
					console.log(jqXHR);
					console.log(textStatus);
				}
			});
		} else {
			return;
		}
		
		// 공고번호에 맞는 지원자 아이디 찾아서 goap_state를 1로 수정
	});
	
	/* 거절 버튼 클릭 이벤트*/
	$(document).on('click', '.btn-refuse', function(event) {
		
	
	})
</script>
</body>
</html>