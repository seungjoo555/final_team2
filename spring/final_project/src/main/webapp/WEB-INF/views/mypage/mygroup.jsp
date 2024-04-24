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
		<!-- 여기부터 해라 -->
		<div class="mygroup-study-container">	

				<h3 class="mygroup-study">스터디 / 프로젝트</h3>
				<div class="mutual-list-box">
					<ul class="mutual-list">
						<c:forEach items="${groupList}" var="grouplist" varStatus="status">								
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
								<div>
									<!-- total_category : toCt_progCt_num / programming_category : progCt_name -->
									${grouplist.progCt_name}
								</div>
								<div>
									<!-- total_language : toLg_lang_num / programming_language : lang_name -->
									${grouplist.lang_name}
								</div>
								<div>
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
		</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>