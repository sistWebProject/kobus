package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;

//글 목록 보기
public class NoticeListController extends HttpServlet {
 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 noticeDAO dao = new noticeDAO();
     List<NoticeDTO> list = dao.getNoticeList();
     req.setAttribute("list", list);
     req.getRequestDispatcher("/notice/noticeList.jsp").forward(req, resp);
 }
}