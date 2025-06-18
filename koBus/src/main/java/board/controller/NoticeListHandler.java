package board.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

// 글 목록 보기
public class NoticeListHandler implements CommandHandler {
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html; charset=UTF-8");

		System.out.println("> NoticeListHandler...");

		String search = request.getParameter("search");
		List<NoticeDTO> list = null;

		if (search != null && !search.trim().equals("")) {
			list = noticeDAO.searchNotices(search);  // 검색 조건 처리
		} else {
			noticeDAO dao = new noticeDAO();
			list = dao.getNoticeList();  // 전체 목록
		}

		request.setAttribute("list", list);
		return "go_bus.jsp";  // 원래 페이지 유지
	}
}
