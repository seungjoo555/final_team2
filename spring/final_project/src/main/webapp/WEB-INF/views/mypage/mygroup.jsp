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
			<ul class="study-apply-list">
				<c:choose>
					<c:when test="${empty groupList}">
						<ul class="study-list">
							<li class="study-list-title" style="font-weight: 700">내가 생성한 그룹</li>
							<li class="study-list-content">내가 생성한 그룹이 존재하지 않습니다.</li>
						</ul>
					</c:when>
					<c:otherwise>
						<li class="study-list-title"style="font-weight: 700">내가 생성한 그룹</li>
						<ul class="study-list">
							<c:forEach items="${groupList}" var="grouplist">
								<a href="<c:url value="/group/home?num=${grouplist.go_num}"/>" class="study-item-container" style="display: block;">
									<li class="study-item">
										<div class="study-list-item-content">
											<div class="study-list-item-title">
												${grouplist.recu_topic} 
											</div>
											<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
												<c:forEach items="${totalCategory1}" var="cate">
													<c:if test="${grouplist.recu_num == cate.toCt_table_pk}">
														<ul class="cate-list">
															<li class="cate-list-item">${cate.toCt_progCt_name}</li>
														</ul>
													</c:if>
												</c:forEach>
											</div>
											<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
												<c:forEach items="${totalLanguage1}" var="lang">
													<c:if test="${grouplist.recu_num == lang.toLg_table_pk}">
														<ul class="lang-list">
															<li class="lang-list-item">${lang.toLg_lang_name}</li>
														</ul>
													</c:if>
												</c:forEach>
											</div>
											<div class="box-border-line">
												<div class="border-line"></div>
											</div>
											<div class="study-list-item-memberInfo">
												<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
												<div class="member-nickname">${grouplist.recu_gome_me_nickname}</div>
												<div class="member-count">${grouplist.go_member_count} / ${grouplist.recu_count}</div>
											</div>
										</div>
									</li>
								</a>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${empty groupApplyList}">
						<ul class="apply-list">
							<li class="apply-list-title" style="font-weight: 700">내가 지원한 그룹</li>
							<li class="apply-list-content">내가 지원한 그룹이 존재하지 않습니다.</li>
						</ul>
					</c:when>
					<c:otherwise>
						<li class="apply-list-title" style="font-weight: 700">내가 지원한 그룹</li>
							<ul class="apply-list">
							<div class="apply-totalcontainer">
								<c:forEach items="${groupApplyList}" var="applylist">
									<c:if test="${applylist.goap_state == 0 }">
										<a href="<c:url value="/group/apply/detail?num=${applylist.recu_num}"/>" class="apply-item-container">
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
												<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalCategory2}" var="cate">
														<c:if test="${applylist.recu_num == cate.toCt_table_pk}">
															<ul class="cate-list">
																<li class="cate-list-item">${cate.toCt_progCt_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalLanguage2}" var="lang">
														<c:if test="${applylist.recu_num == lang.toLg_table_pk}">
															<ul class="lang-list">
																<li class="lang-list-item">${lang.toLg_lang_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="box-border-line">
													<div class="border-line"></div>
												</div>
												<div class="apply-list-item-memberInfo">
													<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
													<div class="member-nickname">${groupKing}</div>
													<div class="member-count">${applylist.go_member_count} / ${applylist.recu_count}</div>
												</div>
											</li>
										</a>
									</c:if>
									<c:if test="${applylist.goap_state == 1}">
										<a href="<c:url value="/group/apply/detail?num=${applylist.recu_num}"/>" class="apply-item-container">
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
												<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalCategory2}" var="cate">
														<c:if test="${applylist.recu_num == cate.toCt_table_pk}">
															<ul class="cate-list">
																<li class="cate-list-item">${cate.toCt_progCt_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalLanguage2}" var="lang">
														<c:if test="${applylist.recu_num == lang.toLg_table_pk}">
															<ul class="lang-list">
																<li class="lang-list-item">${lang.toLg_lang_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="box-border-line">
													<div class="border-line"></div>
												</div>
												<div class="apply-list-item-memberInfo">
													<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
													<div class="member-nickname">${groupKing}</div>
													<div class="member-count">${applylist.go_member_count} / ${applylist.recu_count}</div>
												</div>
											</li>
										</a>									
									</c:if>
									<c:if test="${applylist.goap_state == 2}">
										<a href="<c:url value="/group/apply/detail?num=${applylist.recu_num}"/>" class="apply-item-container">
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
												<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalCategory2}" var="cate">
														<c:if test="${applylist.recu_num == cate.toCt_table_pk}">
															<ul class="cate-list">
																<li class="cate-list-item">${cate.toCt_progCt_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
													<c:forEach items="${totalLanguage2}" var="lang">
														<c:if test="${applylist.recu_num == lang.toLg_table_pk}">
															<ul class="lang-list">
																<li class="lang-list-item">${lang.toLg_lang_name}</li>
															</ul>
														</c:if>
													</c:forEach>
												</div>
												<div class="box-border-line">
													<div class="border-line"></div>
												</div>
												<div class="apply-list-item-memberInfo">
													<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
													<div class="member-nickname">${groupKing}</div>
													<div class="member-count">${applylist.go_member_count} / ${applylist.recu_count}</div>
												</div>
											</li>
										</a>									
									</c:if>
								</c:forEach>
							</div>
						</ul>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
</div>

<div class="mygroup-mentoring-container">
	<c:if test="${member.me_id == user.me_id }">
		<h3 class="mygroup-mentoring">멘토링</h3>
		<div class="mentoring-list-box">
			<ul class="mentoring-list">
				<c:choose>
					<c:when test="${empty mentoringList}">
						<li>나의 멘토링이 존재하지 않습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach items="${mentoringList}" var="ment">		
							<a href="<c:url value="/mentoring/apply/detail?num=${ment.ment_num}"/>" class="mentoring-item-container">	
								<li class="mentoring-item">
									<!-- 멘토링 허용여부 : mentAp_state -->
									<c:if test="${ment.mentAp_state== '-1'}">
										<div class="mentoring-apply-state">반려</div>
									</c:if>
									<c:if test="${ment.mentAp_state== '0'}">
										<div class="mentoring-apply-state">수락 대기</div>
									</c:if>
									<c:if test="${ment.mentAp_state== '1'}">
										<div class="mentoring-apply-state">진행중</div>
									</c:if>
									<!-- 클래스 이름 : mentoring.ment_title-->
									<div class="mentoring-list-item-title">${ment.ment_title}</div>
									<!-- 직무 : ment_job-->
									<div class="mentoring-list-item-job">직무 : ${ment.ment_mentIf_job}</div>
									
									<!-- 경력 : mentIf_exp-->
									<div class="mentoring-list-item-exp">경력 : ${ment.ment_mentIf_exp}년</div>
									
									<!-- 분야 : 분야모음 -->
									<div class="mentoring-list-item-cate">
										<div>분야</div>
										<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
											<c:forEach items="${mentoCategory}" var="ment_cate">
												<c:if test="${ment.ment_num == ment_cate.toCt_table_pk}">
													<div class="mentoring-list-item-cateitem">
														${ment_cate.toCt_progCt_name}
													</div>
												</c:if>
											</c:forEach>							
										</div>
									</div>
									<div class="box-border-line">
										<div class="border-line"></div>
									</div>
									<div class="apply-list-item-memberInfo">
										<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
										<div class="mentor-nickname">${ment.ment_me_nickname}</div>
									</div>
								</li>
							</a>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('.cate-container').on('click', function(event) {
			event.preventDefault();
		});
	});
	
	let isDragging = false;
    let startPosition = 0;
    let startScrollPosition = 0;

    function startDragging(event) {
        isDragging = true;
        startPosition = event.clientX;
        startScrollPosition = event.currentTarget.scrollLeft;
        event.currentTarget.style.cursor = 'grabbing'; /* 드래그 중일 때의 커서 모양 설정 */
    }

    function stopDragging(event) {
        isDragging = false;
        event.currentTarget.style.cursor = 'grab'; /* 드래그 종료 후 커서 모양 설정 */
    }

    function dragging(event) {
        if (isDragging) {
            const deltaX = event.clientX - startPosition;
            event.currentTarget.scrollLeft = startScrollPosition - deltaX;
        }
    }
	
	$(document).ready(function() {
		$('.lang-container').on('click', function(event) {
			event.preventDefault();
		});
	});
	
	
</script>
</body>
</html>