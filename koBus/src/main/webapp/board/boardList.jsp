<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
        content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>공지사항(목록) | 고객지원 | 고속버스통합예매</title>

    <link rel="shortcut icon" type="image/x-icon"
        href="/koBus/media/favicon.ico">
    <link rel="stylesheet" href="/koBus/media/style.css">
    <link rel="stylesheet" href="/koBus/media/ui.jqgrid.custom.css">
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />

    <script src="/koBus/media/jquery-1.12.4.min.js"></script>
    <script src="/koBus/media/jquery-ui.min.js"></script>
    <script src="/koBus/media/jquery.jqGrid.min.js"></script>
    <script src="/koBus/media/common.js"></script>
    <script src="/koBus/media/ui.js"></script>
    <script src="/koBus/media/plugin.js"></script>
    <script src="/koBus/media/security.js"></script>
    <script src="/koBus/media/jquery.number.js"></script>
    <script src="/koBus/media/new-kor-ui.js"></script>

    <style>
    /* --------------------------------------------------------------------------
     * list.jsp의 게시판 목록 관련 CSS만 포함합니다.
     * header.jsp 및 기타 전역 스타일과의 충돌을 최소화하도록 범위를 제한합니다.
     * -------------------------------------------------------------------------- */

    /* body의 기본 글꼴, 색상, 배경색 설정 */
    body {
        font-family: 'Pretendard GOV Variable', sans-serif;
        color: #333;
        background-color: #f8f9fa; /* 부드러운 배경색 */
        line-height: 1.6;
    }

    /* list.jsp의 주요 콘텐츠를 감싸는 컨테이너 */
    .content-body .container {
        max-width: 960px; /* 컨텐츠 최대 너비 */
        margin: 40px auto; /* 중앙 정렬 및 상하 여백 */
        padding: 0 20px; /* 좌우 패딩 */
    }

    /* 상단 알림 문구 */
    .noti_wrap {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 15px;
        border-bottom: 2px solid #114397; /* 강조선 */
    }

    .noti_wrap .noti {
        font-size: 26px;
        font-weight: bold;
        color: #2c3e50;
        display: inline-block;
        position: relative;
    }

    /* 검색 영역 */
    .search_wrap.type2 {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
        padding: 0;
        background-color: transparent;
        box-shadow: none;
        height: 48px;
    }

    .search_wrap.type2 .search_box {
        display: flex;
        width: 100%;
        max-width: 500px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        overflow: hidden;
        background-color: #ffffff;
        height: 100%;
    }

    .search_wrap.type2 .search_box input[type="text"] {
        flex-grow: 1;
        border: none;
        padding: 10px 15px;
        font-size: 16px;
        outline: none;
        background-color: transparent;
        color: #333;
        height: 100%;
        box-sizing: border-box;
    }

    .search_wrap.type2 .search_box input[type="text"]::placeholder {
        color: #888;
    }

    .search_wrap.type2 .search_box button {
        background-color: transparent;
        border: none;
        padding: 0 15px;
        cursor: pointer;
        width: 50px;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: transform 0.2s ease;
        font-size: 0; /* 텍스트 간섭 방지 */
        line-height: 0; /* 텍스트 간섭 방지 */
    }

    .search_wrap.type2 .search_box button:hover {
        transform: scale(1.1);
    }

    .search_wrap.type2 .search_box button img {
        display: block;
        width: 24px;
        height: 24px;
        object-fit: contain;
        margin: 0 !important;
        padding: 0 !important;
        border: none !important;
        vertical-align: middle !important;
    }


    /* 게시판 목록 (테이블 구조) */
    .board_list {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* 부드러운 그림자 */
        overflow: hidden; /* 테이블의 둥근 모서리를 위해 */
    }

    .board_list table {
        width: 100%;
        border-collapse: collapse; /* 셀 경계선 병합 */
    }

    .board_list thead {
        background-color: #114397; /* 헤더 배경색 */
        color: white;
    }

    .board_list th {
        padding: 15px 10px;
        font-size: 15px;
        font-weight: 600;
        text-align: center;
        white-space: nowrap; /* 헤더 텍스트 줄바꿈 방지 */
    }

    .board_list tbody tr {
        border-bottom: 1px solid #eee; /* 각 행 하단 구분선 */
    }

    .board_list tbody tr:last-child {
        border-bottom: none; /* 마지막 행은 하단 테두리 제거 */
    }

    .board_list tbody tr:hover {
        background-color: #f5f5f5; /* 호버 시 배경색 변경 */
    }

    .board_list td {
        padding: 12px 10px;
        font-size: 14px;
        color: #444;
        text-align: center;
        white-space: nowrap; /* 내용 줄바꿈 방지 */
        overflow: hidden;
        text-overflow: ellipsis; /* 넘치는 내용 ... 표시 */
    }

    /* 제목 컬럼 */
    .board_list td.title {
        text-align: left; /* 제목은 왼쪽 정렬 */
        padding-left: 20px;
        width: 60%; /* 제목 컬럼 너비 조정 */
    }

    .board_list td.title a {
        text-decoration: none;
        color: #444;
        font-weight: 500;
    }

    .board_list td.title a:hover {
        color: #114397;
        text-decoration: underline;
    }

    /* 날짜 컬럼 */
    .board_list td.date {
        text-align: right; /* 날짜는 오른쪽 정렬 */
        padding-right: 20px;
        min-width: 100px; /* 날짜 컬럼 최소 너비 */
    }

    /* 버튼 래퍼 (글쓰기/목록 버튼) */
    .btn-wrap {
        display: flex;
        justify-content: flex-end; /* 버튼들을 오른쪽 끝으로 정렬 */
        gap: 15px; /* 버튼 사이 간격 */
        margin-top: 30px; /* 목록과 버튼 사이 여백 */
        padding-top: 20px;
        border-top: 1px solid #eee; /* 목록 아래 구분선 */
    }

    .btn-wrap .btn {
        display: inline-block;
        padding: 10px 22px;
        background-color: #114397; /* 기본 버튼 색상 (파란색 계열) */
        color: #fff;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        font-size: 15px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* 버튼 그림자 */
    }

    .btn-wrap .btn:hover {
        background-color: #0d326f; /* 호버 시 진한 색 */
        transform: translateY(-2px); /* 살짝 위로 */
    }

    /* '글쓰기' 버튼 전용 스타일 (색상 변경) */
    .btn-wrap #write.btn {
        background-color: #28a745; /* 초록색 계열 */
    }
    .btn-wrap #write.btn:hover {
        background-color: #218838;
    }
    </style>

</head>
<body class="main KO" style="">
<%@ include file="../koBusFile/common/header.jsp" %>
<div class="content-body customer">
	<div class="container">

		<input type="hidden" id="ntcNo" name="ntcNo">
		<input type="hidden" id="pageIdx" name="pageIdx" value="1">

		<div class="noti_wrap hide_mo">
			<p class="noti">고속버스 홈페이지의 새로운 소식을 확인하세요.</p>
		</div>

		<div class="search_wrap type2">
			<form action="boardList.do" method="get">
				<div class="search_box">
					<input type="text" name="search" value="${param.search}"
						placeholder="검색어를 입력하세요" title="검색어">
					<button type="submit" aria-label="검색">
                         <img src="/kobus/media/ico_search.png" alt="검색 아이콘">
                     </button>
				</div>
			</form>
		</div>

		<div class="board_list">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>구분</th> <%-- 💡 추가: 구분 컬럼 헤더 --%>
						<th>제목</th>
						<th>작성자</th>
						<th style="text-align: right;">작성일</th>
						<th>조회수</th> <%-- 💡 추가: 조회수 컬럼 헤더 --%>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.brdID}</td>
							<%-- <td>${dto.brdCategory}</td> --%> <%-- 💡 추가: 구분 데이터 출력 --%>
							<td class="title">
								<a href="boardView.do?brdID=${dto.brdID}">${dto.brdTitle}</a>
							</td>
							<td>${dto.kusID}</td>
							<td class="date">${dto.brdDate}</td>
							<td>${dto.brdViews}</td> <%-- 💡 추가: 조회수 데이터 출력 --%>
						</tr>
					</c:forEach>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6">게시글이 없습니다.</td> <%-- 컬럼 수 조정 --%>
                        </tr>
                    </c:if>
				</tbody>
			</table>

			<div class="btn-wrap">
				<a id="list" href="/koBus/html/boardList.do" class="btn">List</a>
				<a id="write" href="/koBus/html/boardWrite.do" class="btn">글쓰기</a>
			</div>
		</div>

	</div>
</div>

</body>
<%@ include file="../koBusFile/common/footer.jsp" %>
</html>