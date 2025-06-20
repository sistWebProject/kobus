<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/ui.jqgrid.custom.css">
	<link rel="shortcut icon" type="image/x-icon" href="/koBus/media/favicon.ico">
<style>
.board_edit {
	border: 1px solid #ccc;
	padding: 30px;
	margin: 30px 0;
	border-radius: 8px;
	background-color: #f9f9f9;
}

.board_edit input[type="text"] {
	width: 100%;
	height: 40px;
	padding: 10px;
	font-size: 14px;
	border-radius: 4px;
	border: 1px solid #ccc;
	box-sizing: border-box;
	resize: none;
	max-width: 100%;
}

.board_edit textarea {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

.btn_wrap {
	text-align: center;
	margin-top: 30px;
}

.btn_wrap .btn {
	display: inline-block;
	padding: 10px 20px;
	margin: 0 5px;
	background: #444;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
	font-size: 14px;
}
</style>
</head>
<body class="KO">

	<div class="content-body customer">
		<div class="container">
			<p class="noti"
				style="text-align: center; font-size: 18px; font-weight: bold; margin-bottom: 20px;">
				공지사항을 수정하세요.</p>

			<form action="noticeEdit.do" method="post" class="board_edit">
				<input type="hidden" name="notID" value="${dto.notID}"> <label
					for="topic">제목</label> <input type="text" name="topic" id="topic"
					value="${dto.topic}" required> <label for="content">내용</label>
				<textarea name="content" id="content" rows="10" style="resize: none; height: 400px;">${dto.content}</textarea>
				
				<div class="btn_wrap">
					<input type="submit" class="btn" value="수정 완료"> <a
						href="noticeList.do" class="btn">목록</a>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
