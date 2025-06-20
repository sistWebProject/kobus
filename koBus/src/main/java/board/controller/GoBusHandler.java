package board.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class GoBusHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 전체 공지 목록만 조회
        List<BoardDTO> list = new BoardDAO().getBoardList();

        // request에 담아서 전달
        request.setAttribute("list", list);

        // 이동할 페이지
        return "/html/go_bus.jsp";
    }
}
