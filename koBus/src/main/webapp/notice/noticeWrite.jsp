<%@ page contentType="text/html;charset=UTF-8" %>
<h2>공지사항 작성</h2>
<style>
	
</style>
<form action="noticeSave.do" method="post" class="notice-form">
  <table class="notice-write-table">
    <tr>
      <th>공지 번호</th>
      <td><input type="text" name="notID" required></td>
    </tr>
    <tr>
      <th>제목</th>
      <td><input type="text" name="topic" required></td>
    </tr>
    <tr>
      <th>내용</th>
      <td><textarea name="content" rows="10" cols="80" required></textarea></td>
    </tr>
  </table>

  <div class="btn-area">
    <input type="submit" value="저장" class="btn-submit">
    <a href="noticeList.do" class="btn-back">[목록으로]</a>
  </div>
</form>
