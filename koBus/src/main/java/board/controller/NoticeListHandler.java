package board.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

//글 목록 보기
public class NoticeListHandler implements CommandHandler  {
	public String process(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html; charset=UTF-8");

		System.out.println("> NoticeListHandler...");
		noticeDAO dao = new noticeDAO();
		List<NoticeDTO> list = dao.getNoticeList();

		System.out.println("list : " + list.toString());
		request.setAttribute("list", list);
		return "go_bus.jsp";
	}
}