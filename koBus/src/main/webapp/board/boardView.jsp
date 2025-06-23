<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 | 고객지원 | 고속버스통합예매</title>
<link rel="shortcut icon" type="image/x-icon"
	href="/koBus/media/favicon.ico">
<link rel="stylesheet" href="/koBus/media/style.css">
<link rel="stylesheet" href="/koBus/media/ui.jqgrid.custom.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />
<style>
/* 필요한 CSS 추가 */
.board-view-container {
	max-width: 800px;
	margin: 40px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
}

.board-view-header {
	border-bottom: 2px solid #114397;
	padding-bottom: 15px;
	margin-bottom: 20px;
}

.board-view-header h2 {
	font-size: 28px;
	color: #2c3e50;
	margin-bottom: 10px;
}

.board-view-meta {
	display: flex;
	justify-content: space-between;
	font-size: 14px;
	color: #777;
}

.board-view-content {
	padding: 20px 0;
	line-height: 1.8;
	color: #333;
	border-bottom: 1px solid #eee;
	margin-bottom: 20px;
	min-height: 150px; /* 내용 영역 최소 높이 */
}

.board-view-actions {
	text-align: right;
	margin-top: 20px;
}

.board-view-actions .btn {
	display: inline-block;
	padding: 10px 20px;
	background-color: #6c757d; /* 회색 계열 */
	color: #fff;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	font-size: 15px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
	margin-left: 10px;
}

.board-view-actions .btn:hover {
	background-color: #5a6268;
	transform: translateY(-2px);
}

.board-view-actions .btn.edit {
	background-color: #007bff; /* 파란색 */
}

.board-view-actions .btn.edit:hover {
	background-color: #0056b3;
}

.board-view-actions .btn.delete {
	background-color: #dc3545; /* 빨간색 */
}

.board-view-actions .btn.delete:hover {
	background-color: #c82333;
}
</style>
</head>
<body class="main KO">
	<%@ include file="../koBusFile/common/header.jsp"%>

	<div class="content-body customer">
		<div class="container board-view-container">

			<div class="board-view-header">
				<h2>${dto.brdTitle}</h2>
				<div class="board-view-meta">
					<span>작성자: ${dto.userId}</span> <span>작성일: <fmt:formatDate
							value="${dto.brdDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span> <span>조회수:
						${dto.brdViews}</span>
				</div>
			</div>

			<div class="board-view-content">
				<p>${dto.brdContent}</p>
			</div>

			<div class="board-view-actions">
				<a href="boardList.do" class="btn">목록</a>
				<c:if test="${loginKusID eq dto.kusID}">
					<a href="boardEdit.do?brdID=${dto.brdID}" class="btn edit">수정</a>
					<a href="boardDelete.do?brdID=${dto.brdID}" class="btn delete"
						onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
				</c:if>
			</div>
			<!-- 댓글 작성 폼 -->
			<div class="comment-write" style="margin-top: 30px;">
<form action="replyWrite.do" method="post">
    <input type="hidden" name="brdID" value="${dto.brdID}">
    <textarea name="content" required></textarea>
    <button type="submit">댓글 등록</button>
</form>


			</div>

			<!-- 댓글 목록 출력 -->
			<div class="comment-list" style="margin-top: 20px;">
				<h4>댓글</h4>
				<c:forEach var="comment" items="${commentList}">
					<div style="border-bottom: 1px solid #ccc; padding: 8px 0;">
						<strong>${comment.kusID}</strong>
 <span
							style="font-size: 12px; color: gray;">${comment.cmtDate}</span>
						<p>${comment.cmtContent}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>