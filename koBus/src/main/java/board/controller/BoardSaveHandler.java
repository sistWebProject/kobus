package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardSaveHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 인코딩
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 파라미터 수집
        String kusID = request.getParameter("kusID");         // 작성자 ID
        String brdTitle = request.getParameter("brdTitle");   // 제목
        String brdContent = request.getParameter("brdContent"); // 내용

        // DTO 설정
        BoardDTO dto = new BoardDTO();
        dto.setKusID(kusID);
        dto.setBrdTitle(brdTitle);
        dto.setBrdContent(brdContent);

        // DAO 호출
        BoardDAO dao = new BoardDAO();
        dao.insertBoard(dto);

        // 저장 후 목록으로 이동
        response.sendRedirect("boardList.do");
        return null;
    }
}
