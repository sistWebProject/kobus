package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;

//글 상세 보기
public class NoticeViewController extends HttpServlet {
 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     String notID = req.getParameter("notID");
     noticeDAO dao = new noticeDAO();
     NoticeDTO dto = dao.getNotice(notID);
     req.setAttribute("dto", dto);
     req.getRequestDispatcher("/notice/noticeView.jsp").forward(req, resp);
 }
}