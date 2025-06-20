<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ include file="../koBusFile/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<link rel="shortcut icon" type="image/x-icon"
	href="/koBus/media/favicon.ico">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/media/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/media/ui.jqgrid.custom.css">
<style>
.board_view {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	padding: 20px 0;
	margin: 30px 0;
	text-align: center;
}

.view_title {
	font-size: 20px;
	font-weight: 600;
	margin-bottom: 10px;
	display: flex;
	justify-content: space-between;
}

.view_content {
	padding: 20px 0;
	font-size: 15px;
	line-height: 1.8;
}

.view_content img {
	max-width: 100%;
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
				고속버스 홈페이지의 새로운 소식을 확인하세요.</p>
			<div class="board_view">
				<!-- 작성자와 날짜 -->
				<div
					style="display: flex; justify-content: space-between; font-size: 14px; margin-bottom: 10px;">
					<span>작성자 : ${dto.kusID}</span> <span>작성일 : ${dto.brdDate}</span>
				</div>

				<!-- 제목 -->
				<h2
					style="text-align: center; font-size: 22px; font-weight: bold; margin: 20px 0; padding-bottom: 10px; border-bottom: 1px solid #ccc;">
					${dto.brdTitle}</h2>

				<!-- 내용 -->
				<div class="view_content"
					style="padding: 20px 0; text-align: center;">
					${dto.brdContent}</div>
			</div>
			<div class="btn_wrap">
				<a href="boardEdit.do?brdID=${dto.brdID}" class="btn">수정</a> <a
					href="boardDelete.do?brdID=${dto.brdID}" class="btn"
					onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a> <a
					href="boardList.do" class="btn">목록</a>
			</div>


		</div>
	</div>

</body>
</html>