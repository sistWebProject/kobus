package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;
import koBus.mvc.persistence.LogonDAOImpl;
import com.util.ConnectionProvider;

import java.sql.Connection;

public class BoardViewHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        System.out.println("VIEW_doit()..");

        String brdIDstr = request.getParameter("brdID");
        int brdID = 0;
        if (brdIDstr != null && !brdIDstr.isEmpty()) {
            brdID = Integer.parseInt(brdIDstr);
        }

        // 게시글 조회
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.getBoard(brdID);

        // 조회수 증가
        if (dto != null) {
            dao.incrementViewCount(brdID);
        }

        // 세션에서 로그인 ID 가져오기
        HttpSession session = request.getSession();
        String loginId = (String) session.getAttribute("id");

        // loginId -> kusID 변환
        String kusID = null;
        if (loginId != null) {
            Connection conn = ConnectionProvider.getConnection();
            LogonDAOImpl logonDAO = new LogonDAOImpl(conn);
            kusID = logonDAO.getKusIDById(loginId);
            conn.close();
        }

        request.setAttribute("dto", dto);
        request.setAttribute("authKusID", kusID); // 비교용

        return "/board/boardView.jsp";
    }
}
