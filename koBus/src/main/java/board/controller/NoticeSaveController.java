package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;

//글 저장 처리
public class NoticeSaveController extends HttpServlet {
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     req.setCharacterEncoding("UTF-8");
     NoticeDTO dto = new NoticeDTO();
     dto.setNotID(req.getParameter("notID"));
     dto.setTopic(req.getParameter("topic"));
     dto.setContent(req.getParameter("content"));

     noticeDAO dao = new noticeDAO();
     dao.insertNotice(dto);

     resp.sendRedirect("list.notice");
 }
}
