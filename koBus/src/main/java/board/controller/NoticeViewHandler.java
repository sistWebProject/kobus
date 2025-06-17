package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

public class NoticeViewHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
    	
    	System.out.println("VIEW_doit()..");
    	String notID = request.getParameter("notID");
    	
        noticeDAO dao = new noticeDAO();
        NoticeDTO dto = dao.getNotice(notID);
        
        request.setAttribute("dto", dto);
        return "/notice/noticeView.jsp";
    }
}