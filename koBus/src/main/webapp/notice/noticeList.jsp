<!-- noticeList.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>공지사항 목록</h2>
<table border="1">
  <tr>
    <th>제목</th>
    <th>작성일</th>
  </tr>
  <c:forEach var="dto" items="${list}">
    <tr>
      <td>
        <a href="view.notice?notID=${dto.notID}">${dto.topic}</a>
      </td>
      <td>${dto.notDate}</td>
    </tr>
  </c:forEach>
</table>
<br>
<a href="write.notice">[공지 작성하기]</a>