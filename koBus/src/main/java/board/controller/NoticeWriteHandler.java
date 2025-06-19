package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import koBus.mvc.command.CommandHandler;

public class NoticeWriteHandler implements CommandHandler {
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("> writeeeeeeeeeeeeeeee...");

		return "/notice/noticeWrite.jsp"; 
	}
}