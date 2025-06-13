<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="dto" items="${list}">
  <li class="notice-row">
    <span class="notice-icon">📌</span>
    <a href="view.notice?notID=${dto.notID}" class="notice-title">${dto.topic}</a>
    <span class="notice-date">${dto.notDate}</span>
  </li>
</c:forEach>
</body>
</html>