<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/media/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/media/ui.jqgrid.custom.css">
<link rel="shortcut icon" type="image/x-icon"
	href="/koBus/media/favicon.ico">
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
.error-message {
    color: red;
    text-align: center;
    margin-bottom: 15px;
}
</style>
</head>
<body class="KO">

	<div class="content-body customer">
		<div class="container">
			<p class="noti"
				style="text-align: center; font-size: 18px; font-weight: bold; margin-bottom: 20px;">
				공지사항을 수정하세요.</p>

            <%-- 에러 메시지 표시 --%>
            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

			<form action="boardEdit.do" method="post" class="board_edit">
				<input type="hidden" name="brdID" value="${dto.brdID}">
                <%-- kusID는 백엔드에서 세션으로 처리하므로 여기서는 굳이 필요 없지만, 기존 구조 유지를 위해 남겨둠 --%>
				<input type="hidden" name="kusID" value="${dto.kusID}">
                <%-- brdCategory 필드를 추가하려면 여기에 input 또는 select 태그를 추가합니다. --%>
                <%-- 예:
                <label for="brdCategory">구분</label>
                <input type="text" name="brdCategory" id="brdCategory" value="${dto.brdCategory}" required>
                --%>
				<label for="brdTitle">제목</label> <input type="text" name="brdTitle"
					id="brdTitle" value="${dto.brdTitle}" required> <label
					for="brdContent">내용</label>
				<textarea name="brdContent" id="brdContent" rows="10"
					style="resize: none; height: 400px;" required>${dto.brdContent}</textarea>

				<div class="btn_wrap">
					<input type="submit" class="btn" value="수정 완료"> <a
						href="boardList.do" class="btn">목록</a>
				</div>
			</form>
		</div>
	</div>

</body>
</html>