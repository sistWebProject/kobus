package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardEditHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String method = request.getMethod();

        if (method.equalsIgnoreCase("GET")) {
        	String brdID = request.getParameter("brdID");
        	BoardDTO dto = BoardDAO.selectOne(brdID);

            request.setAttribute("dto", dto);
            return "/board/boardEdit.jsp";

        } else if (method.equalsIgnoreCase("POST")) {
            request.setCharacterEncoding("UTF-8");

            int brdID = Integer.parseInt(request.getParameter("brdID"));
            String kusID = request.getParameter("kusID");
            String brdTitle = request.getParameter("brdTitle");
            String brdContent = request.getParameter("brdContent");

            BoardDTO dto = new BoardDTO();
            dto.setBrdID(brdID);
            dto.setKusID(kusID); 
            dto.setBrdTitle(brdTitle);
            dto.setBrdContent(brdContent);

            int result = BoardDAO.updateBoard(dto);
            return "/board/boardList.jsp";
        }

        return null;
    }
}
