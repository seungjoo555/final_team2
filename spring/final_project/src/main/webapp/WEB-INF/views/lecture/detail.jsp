<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h1>강의 상세보기</h1>
<div>
	<label>제목</label>
	<div class="form-control">제목입니다</div>
</div>
<div>
	<label>작성자</label>
	<div class="form-control">작성자 닉네임</div>
</div>
<div>
	<label>강의 소개</label>
	<div class="form-control" style="min-height: 400px">강의 소개란</div>
</div>
<div>
	<c:choose>
		<c:when test="${fileList.size() != 0}">
			<label>첨부파일</label>
			<c:forEach items="${fileList }" var="file">
				<a href="<c:url value="/download${file.fi_name}"/>" 
					class="form-control"
					download="${file.fi_ori_name}">${file.fi_ori_name}</a>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div>첨부파일 없음</div>
		</c:otherwise>
	</c:choose>
</div>

<div class="container-comment mt-3 mb-3">
	<h2>댓글(<span class="comment-total">2</span>)</h2>
	<div class="box-comment-list">
		<div class="box-comment row">
			<div class="col-3">아이디</div>
			<div class="col-9">내용</div>
		</div>
	</div>
	<div class="box-pagination">
		<ul class="pagination justify-content-center"></ul>
	</div>
	<div class="box-comment-insert">
		<div class="input-group mb-3">
			<textarea class="form-control textarea-comment"></textarea>
			<button class="btn btn-outline-success btn-comment-insert">댓글 등록</button>
		</div>
	</div>
	<hr>
</div>

<c:url value="/board/list" var="url">
	<c:param name="page" value="${cri.page}"/>
	<c:param name="type" value="${cri.type}"/>
	<c:param name="search" value="${cri.search}"/>
</c:url>
<a href="${url}" class="btn btn-outline-dark">목록으로</a>
<c:if test="${user.me_id == board.bo_me_id}">
	<a href="<c:url value="/board/delete?boNum=${board.bo_num}"/>" class="btn btn-outline-success">삭제</a>
	<a href="<c:url value="/board/update?boNum=${board.bo_num}"/>" class="btn btn-outline-warning">수정</a>
</c:if>