package board.reply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dao.CommentDAO;
import board.dao.CommentDAOImpl;
import board.dto.CommentDTO;
import koBus.mvc.command.CommandHandler;

public class ReplyWriteHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginKusID") == null) {
            // 로그인 안 된 상태면 로그인 페이지로 리다이렉트
            return "redirect:/page/logonMain.do"; 
        }

        String kusID = (String) session.getAttribute("loginKusID");
        String content = request.getParameter("content");
        String brdIDStr = request.getParameter("brdID");

        // brdID null 또는 숫자 아님
        if (brdIDStr == null || content == null || content.trim().isEmpty()) {
            // 유효하지 않은 접근이면 리스트로 보냄
            return "redirect:/html/boardList.do";
        }

        int brdID = Integer.parseInt(brdIDStr);

        // DTO 세팅
        CommentDTO dto = new CommentDTO();
        dto.setBrdID(brdID);
        dto.setKusID(kusID);
        dto.setContent(content);

        // DAO 호출
        CommentDAO dao = new CommentDAOImpl();
        dao.insertComment(dto);

        // 글 상세로 리다이렉트
        return "redirect:/html/boardView.do?brdID=" + brdID;
    }
}
