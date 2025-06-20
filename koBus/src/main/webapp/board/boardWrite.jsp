<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="/koBus/media/favicon.ico">
    <title>공지사항 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/media/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/media/ui.jqgrid.custom.css">
    <style>
        .board_edit {
            border: 1px solid #ccc;
            padding: 30px;
            margin: 30px 0;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .board_edit input[type="text"],
        .board_edit textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            resize: none;
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

<body class="main KO" style="">
<%@ include file="../koBusFile/common/header.jsp" %>

<div class="content-body customer">
    <div class="container">
        <p class="noti" style="text-align: center; font-size: 18px; font-weight: bold; margin-bottom: 20px;">
            게시글을 작성하세요.
        </p>

        <form action="boardSave.do" method="post" class="board_write">
            <!-- 숨겨진 사용자 ID -->
             <input type="hidden" name="kusID" value="${auth} "> 
<%-- 			<input type="hidden" name="kusID" value="${sessionScope.kusID}">
 --%>
			
            <label for="brdTitle">제목</label>
            <input type="text" name="brdTitle" id="brdTitle" required>

            <label for="brdContent">내용</label>
            <textarea name="brdContent" id="brdContent" rows="10" required></textarea>

            <div class="btn_wrap">
                <input type="submit" class="btn" value="등록">
                <a href="boardList.do" class="btn">목록</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>