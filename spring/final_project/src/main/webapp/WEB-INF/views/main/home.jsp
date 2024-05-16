<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="<c:url value="/resources/css/home.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/grouplist.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/mentorlist.css"/>">
</head>
<body>

<div class="container">
	
	<div class="box-banner">
		<img alt="배너" src="<c:url value="/resources/img/banner.svg"/>">
	</div>
	<div class="box-group-hot">
		<h2>HOT 스터디/프로젝트</h2>
		<div class="box-group-list">
			<ul class="group-list">
				<c:if test="${hotGroupList == null }">
					<h3>등록된 스터디/프로젝트가 없습니다.</h3>
				</c:if>
				<c:forEach items="${hotGroupList}" var="group">
					<a class="group-item" href="<c:url value="/group/detail?num=${group.recu_num}"/>">
						<li>
							<!-- 프로젝트/스터디 구분 -->
							<div class="group-list-item-category" >
								<div class="item-category">
									<c:if test="${group.recu_type == 0}">
										스터디
									</c:if>
									<c:if test="${group.recu_type == 1}">
										프로젝트
									</c:if>
								</div>
							</div>
							<!-- 마감일 -->
							<div class="group-list-item-schedule">
								<p>마감일 |
									<fmt:formatDate value="${group.recu_due}" pattern="yyyy-MM-dd" />
								</p>
							</div>
							<div class="group-list-item-content">
								<!-- 그룹 모집 제목 -->
								<h3 class="group-list-item-title">${group.recu_topic}</h3>
								<!-- 분야 리스트 -->
								<div class="cate-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
									<c:forEach items="${totalCategory}" var="cate">
										<c:if test="${group.recu_num == cate.toCt_table_pk}">
											<ul class="cate-list">
												<li class="cate-list-item">${cate.toCt_progCt_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
								<!-- 사용언어 -->
								<div class="lang-container" onmousedown="startDragging(event)" onmouseup="stopDragging(event)" onmousemove="dragging(event)">
									<c:forEach items="${totalLanguage}" var="lang">
										<c:if test="${group.recu_num == lang.toLg_table_pk}">
											<ul class="lang-list">
												<li class="lang-list-item">${lang.toLg_lang_name}</li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<!-- 구분선 -->
							<div class="box-border-line"><div class="border-line"></div></div>
							<div class="group-list-item-memberInfo" >
								<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
								<div class="memberNickname">${group.recu_gome_me_nickname } </div>
								<div class="groupSituation">
									<c:if test="${group.recu_state == 0}">
										모집완료
									</c:if>
									<c:if test="${group.recu_state == 1}">
										모집 중
									</c:if>
								</div>
							</div>
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div class="box-group-hot">
		<h2>추천 멘토</h2>
		<div class="box-mento-list">
			<ul class="mento-list">
				<c:forEach items="${mentoingList }" var="mentoing">
					<a class="mento-item" data-num="${mentoing.ment_num}">
						<li>
							<!--그룹 모집 내용-->
							<div class="mento-list-item-content">
								<h3 class="mento-list-item-title">${mentoing.ment_title }</h3>
								<!-- 멘토 직무 -->
								<div class="mento-list-item-contentList">
									직무 : ${mentoing.ment_mentIf_job}
								</div>
								<!-- 멘토 경력 -->
								<div class="mento-list-item-languageList">
									경력 : ${mentoing.ment_mentIf_exp}년
								</div>
							</div>
							
							<!-- 구분선 -->
							<div class="box-border-line"><div class="border-line"></div></div>
							<div class="mento-list-item-memberInfo" >
								<img class="basic-profile" style="width: 30px; height: 30px;" src="<c:url value="/resources/img/basic_profile.png"/>">
								<div class="memberNickname">${mentoing.ment_me_nickname } </div>
								<div class="mentoSituation">
									<c:if test="${mentoing.ment_state == 1}">
										모집 중
									</c:if>
									<c:if test="${mentoing.ment_state == -1}">
										모집완료
									</c:if>
								</div>
							</div>
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="box-group-hot">
		<h2>인기 강의</h2>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>강의 제목</th>
					<th>강의 등록멘토</th>
					<th>강의 가격</th>
					<th>강의 게시일</th>
					<th>강의 업데이트일</th>
				</tr>
			</thead>
			<tbody>
		<c:forEach items="${lectureList}" var="lecture">
			<tr>
				<td>
					<c:url value="/lecture/detail" var="url">
						<c:param name="page" value="1"/>
						<c:param name="type" value="all"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="lectNum" value="${lecture.lect_num}"/>
					</c:url>
					<a href="${url}">${lecture.lect_name}</a>
				</td>
				<td>
					<c:url value="/lecture/list" var="url">
						<c:param name="type" value="writer"/>
						<c:param name="search" value="${lecture.lect_mentIf_me_id}"/>
					</c:url>
					<a href="${url}">${lecture.lect_mentIf_me_id}</a>
				</td>
				<td>${lecture.lect_price}</td>
				<td>${lecture.lect_posting}</td>
				<td>${lecture.lect_update}</td>
			</tr>
		</c:forEach>
			</tbody>
		</table>
	</div>
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
