<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 | 고객지원 | 고속버스통합예매</title>
<link rel="shortcut icon" type="image/x-icon" href="/koBus/media/favicon.ico">
<link rel="stylesheet" href="/koBus/media/style.css">
<link rel="stylesheet" href="/koBus/media/ui.jqgrid.custom.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />
<style>
/* 기존 list.jsp와 유사한 스타일 재활용 또는 추가 */
.board-form-container {
    max-width: 800px;
    margin: 40px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}
.board-form-group {
    margin-bottom: 20px;
}
.board-form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
}
.board-form-group input[type="text"],
.board-form-group textarea,
.board-form-group select { /* select 태그 스타일 추가 */
    width: calc(100% - 22px); /* 패딩 고려 */
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 16px;
    box-sizing: border-box; /* 패딩이 너비에 포함되도록 */
}
.board-form-group textarea {
    resize: vertical;
    min-height: 200px;
}
.board-form-actions {
    text-align: right;
    margin-top: 30px;
}
.board-form-actions .btn {
    display: inline-block;
    padding: 10px 22px;
    background-color: #114397;
    color: #fff;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    margin-left: 10px;
}
.board-form-actions .btn:hover {
    background-color: #0d326f;
    transform: translateY(-2px);
}
.board-form-actions .btn.cancel {
    background-color: #6c757d;
}
.board-form-actions .btn.cancel:hover {
    background-color: #5a6268;
}
</style>
</head>
<body class="main KO">
<%@ include file="../koBusFile/common/header.jsp" %>

<div class="content-body customer">
	<div class="container board-form-container">
		<h2>게시글 작성</h2>
		<form action="boardSave.do" method="post">
			<div class="board-form-group">
				<label for="brdCategory">구분</label>
				<select id="brdCategory" name="brdCategory" required>
					<option value="">선택하세요</option>
					<option value="자유게시판">자유게시판</option>
					<option value="Q&A">Q&A</option>
					<option value="공지사항">공지사항</option>
					</select>
			</div>
			<div class="board-form-group">
				<label for="brdTitle">제목</label>
				<input type="text" id="brdTitle" name="brdTitle" required>
			</div>
			<div class="board-form-group">
				<label for="brdContent">내용</label>
				<textarea id="brdContent" name="brdContent" required></textarea>
			</div>
			<div class="board-form-actions">
				<button type="submit" class="btn">작성</button>
				<a href="boardList.do" class="btn cancel">취소</a>
			</div>
		</form>
	</div>
</div>
</body>
<%@ include file="../koBusFile/common/footer.jsp" %>
</html>