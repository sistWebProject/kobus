<!-- noticeView.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<h2>공지 상세 보기</h2>
<p><strong>제목:</strong> ${dto.topic}</p>
<p><strong>작성일:</strong> ${dto.notDate}</p>
<p><strong>내용:</strong></p>
<p>${dto.content}</p>
<br>
<a href="edit.notice?notID=${dto.notID}">[수정]</a>
<a href="delete.notice?notID=${dto.notID}">[삭제]</a>
<a href="list.notice">[목록으로]</a>
