<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="comment" items="${commentList}">
	<div class="comment-box">
		<p class="comment-meta">
			<strong>${comment.kusID}</strong> | 
			<span>${comment.cmtDate}</span>
			<!-- 삭제 버튼: 로그인 사용자와 동일할 때만 노출 -->
			<c:if test="${sessionScope.userID == comment.kusID}">
				<button class="delete-btn" data-id="${comment.cmtID}">삭제</button>
			</c:if>
		</p>
		<p class="comment-content">${comment.content}</p>
	</div>
</c:forEach>

<c:if test="${empty commentList}">
	<p>등록된 댓글이 없습니다.</p>
</c:if>
