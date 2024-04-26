<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/profile.css"/>">
</head>
<body>
	<div>
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
						<c:if test="${empty groupList && empty groupApplyList}">
							<li>나의 스터디 / 프로젝트가 존재하지 않습니다.</li>
						</c:if>
						<c:choose>
							<c:when test="${empty groupList}">
								<li class="" style="font-weight: 700">내가 생성한 그룹</li>
								<li class="">내가 생성한 그룹이 존재하지 않습니다.</li>
							</c:when>
							<c:otherwise>
								<li class=""style="font-weight: 700">내가 생성한 그룹</li>
								<c:forEach items="${groupList}" var="grouplist">
									<li class="study-item">
										<div class="study-list-item-category">
											<c:if test="${grouplist.goap_state == -1}">
												<div class="item-category">
													진행 중
												</div>
											</c:if>
										</div>
										<div class="study-list-item-content">
											<div class="study-list-item-title">
												${grouplist.recu_topic}
											</div>
											<c:forEach items="${totalCategory1}" var="cate">
												<c:if test="${grouplist.recu_num == cate.toCt_table_pk}">
													<li class="recruit-position">${cate.toCt_progCt_name}</li>
												</c:if>
											</c:forEach>
											<div>
												<!-- total_language : toLg_lang_num / programming_language : lang_name -->
												<c:forEach items="${totalLanguage1}" var="lang">
													<c:if test="${grouplist.recu_num == lang.toLg_table_pk}">
														<li class="recruit-position">${lang.toLg_lang_name}</li>
													</c:if>
												</c:forEach>
											</div>
											<div class="box-border-line"><div class="border-line"></div></div>
											<div>
												<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
												${grouplist.recu_gome_me_nickname}
											</div>
											<div>
												${grouplist.go_member_count} / ${grouplist.recu_count}
											</div>
										</div>
									</li>
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
												<div class="item-category">
													수락 대기
												</div>
											</c:if>
											<c:if test="${applylist.goap_state == 1}">
												<div class="item-category">
													진행 중
												</div>
											</c:if>
											<c:if test="${applylist.goap_state == 2}">
												<div class="item-category">
													반려
												</div>
											</c:if>
										</div>
										<div class="apply-list-item-title">
											${applylist.recu_topic}
										</div>
										<div></div>
										<c:forEach items="${totalCategory2}" var="cate">
											<c:if test="${applylist.recu_num == cate.toCt_table_pk}">
												<li class="recruit-position">${cate.toCt_progCt_name}</li>
											</c:if>
										</c:forEach>
										<div>
											<!-- total_language : toLg_lang_num / programming_language : lang_name -->
											<c:forEach items="${totalLanguage2}" var="lang">
												<c:if test="${applylist.recu_num == lang.toLg_table_pk}">
													<li class="recruit-position">${lang.toLg_lang_name}</li>
												</c:if>
											</c:forEach>
										</div>
										<div class="box-border-line"><div class="border-line"></div></div>
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
											경력 : ${ment.ment_mentIf_exp}년
										</div>
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
		</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>