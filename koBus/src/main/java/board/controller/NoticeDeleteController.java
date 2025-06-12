package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;

//글 삭제 처리
public class NoticeDeleteController extends HttpServlet {
 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     String notID = req.getParameter("notID");
     noticeDAO dao = new noticeDAO();
     dao.deleteNotice(notID);
     resp.sendRedirect("list.notice");
 }
}
