<!-- noticeWrite.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<h2>공지 작성</h2>
<form action="save.notice" method="post">
  <p>공지 번호: <input type="text" name="notID"></p>
  <p>제목: <input type="text" name="topic"></p>
  <p>내용:</p>
  <p><textarea name="content" rows="5" cols="50"></textarea></p>
  <p><input type="submit" value="저장"></p>
</form>
<a href="list.notice">[목록으로]</a>
