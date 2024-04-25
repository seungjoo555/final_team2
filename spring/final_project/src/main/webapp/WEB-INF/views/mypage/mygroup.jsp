<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/mygroup.css"/>">
</head>
<body>
	<div>
		<div class="mygroup-mutual-container">
			<c:if test="${member.me_id == user.me_id }">
				<h3 class="mygroup-mutual">상호평가</h3>
				<div class="mutual-list-box">
					<ul class="mutual-list">
						<c:forEach items="${mutualReviewList}" var="mure">								
							<li class="mutual-item">
								<!-- 프로젝트/스터디 구분 -->
								<c:if test="${mure.recu_type== '0'}">
									<div class="item-study">
										스터디
									</div>
								</c:if>
								<c:if test="${mure.recu_type== '1'}">
									<div class="item-project">
										프로젝트
									</div>
								</c:if>
								<!-- 상호평가 내용 -->
								<div class="mutual-item-category" >
									<div class="item-category">
											${mure.mure_content}
									</div>
								</div>  
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
		</div>
		<div class="mygroup-study-container">	

				<h3 class="mygroup-study">스터디 / 프로젝트</h3>
				<div class="mutual-list-box">
					<ul class="mutual-list">
						<c:forEach items="${groupList}" var="grouplist">
							<li class="mutual-item">
								<div class="item-category">
									<c:if test="${grouplist.goap_state == 0}">
										수락 대기
									</c:if>
									<c:if test="${grouplist.goap_state == 1}">
										진행 중
									</c:if>
									<c:if test="${grouplist.goap_state == 2}">
										진행 종료
									</c:if>
								</div>
								<div>
									${grouplist.recu_topic}
								</div>
								<div></div>
								<c:forEach items="${totalCategory}" var="cate">
									<li class="recruit-position">${cate.toCt_progCt_name}</li>
								</c:forEach>
								<div>
									<!-- total_language : toLg_lang_num / programming_language : lang_name -->
									<c:forEach items="${totalLanguage}" var="lang">
										<li class="recruit-position">${lang.toLg_lang_name}</li>
									</c:forEach>
								</div>
								<div>
									<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
									${grouplist.recu_gome_me_nickname}
								</div>
								<div>
									${grouplist.go_member_count} / ${grouplist.recu_count}
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
		</div>
		<div class="mygroup-mentoring-container">
			<h3 class="mygroup-mentoring">멘토링</h3>
			<div class="mutual-list-box">
				<ul class="mutual-list">
					<c:forEach items="${mentoringList}" var="ment">								
						<li class="mutual-item">
							<!-- 멘토링 허용여부 : mentAp_state -->
							<c:if test="${ment.mentAp_state== '-1'}">
								<div class="item-project">
									반려
								</div>
							</c:if>
							<c:if test="${ment.mentAp_state== '0'}">
								<div class="item-study">
									수락 대기
								</div>
							</c:if>
							<c:if test="${ment.mentAp_state== '1'}">
								<div class="item-project">
									진행중
								</div>
							</c:if>
							<!-- 클래스 이름 : mentoring.ment_title-->
							<div>
								${ment.ment_title}
							</div>
							<!-- 직무 : ment_job-->
							<div>
								직무 : ${ment.ment_mentIf_job}
							</div>
							<!-- 경력 : mentIf_exp-->
							<div>
								경력 : ${ment.ment_mentIf_exp}
							</div>
							<!-- 분야 : 분야모음 -->
							<div>
								<c:forEach items="${mentoCategory}" var="ment_cate">
									분야 : ${ment_cate.toCt_progCt_name}
								</c:forEach>							
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>