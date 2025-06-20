package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardViewHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
    	
    	System.out.println("VIEW_doit()..");
    	String brdID = request.getParameter("brdID");
    	
    	BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.getBoard(brdID);
        
        request.setAttribute("dto", dto);
        return "/board/boardView.jsp";
    }
}