
<!-- noticeEdit.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<h2>공지 수정</h2>
<form action="noticeEdit.do" method="post">
  <input type="hidden" name="notID" value="${dto.notID}">
  <p>제목: <input type="text" name="topic" value="${dto.topic}"></p>
  <p>내용:</p>
  <p><textarea name="content" rows="5" cols="50">${dto.content}</textarea></p>
  <p><input type="submit" value="수정 완료"></p>
</form>
<a href="noticeList.do">[목록으로]</a>
