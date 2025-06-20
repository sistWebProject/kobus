package board.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

// 글 목록 보기
public class BoardListHandler implements CommandHandler {
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html; charset=UTF-8");

		System.out.println("> boardListHandler...");

		List<BoardDTO> list = null;

		BoardDAO dao = new BoardDAO();
		list = dao.getBoardList(); // 전체 목록

		request.setAttribute("list", list);
		return "/board/boardList.jsp"; // 원래 페이지 유지
	}
}
