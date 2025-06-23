// BoardDeleteHandler.java (수정됨)
package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;      // SQLException 임포트
import javax.naming.NamingException; // NamingException 임포트

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardDeleteHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception { 
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String brdID_str = request.getParameter("brdID");
        int brdID = 0;
        try {
            brdID = Integer.parseInt(brdID_str);
        } catch (NumberFormatException e) {
            System.err.println("BoardDeleteHandler - Invalid brdID format: " + brdID_str);
            request.setAttribute("error", "유효하지 않은 게시글 번호입니다.");
            response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=invalid_id");
            return null;
        }

        BoardDAO dao = new BoardDAO();
        BoardDTO existingDto = null;

       
        HttpSession session = request.getSession();
        String loggedInUserId = (String) session.getAttribute("loggedInUserID"); 
                                                                               
        if (loggedInUserId == null) {
            System.err.println("BoardDeleteHandler: 로그인되지 않은 사용자의 삭제 시도.");
            request.setAttribute("error", "로그인 후 게시글을 삭제할 수 있습니다.");
            response.sendRedirect(request.getContextPath() + "/page/logonMain.do?error=login_required");
            return null;
        }

        try {
            existingDto = dao.getBoard(brdID); // 삭제 권한 확인을 위해 기존 게시글 정보 가져옴
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDeleteHandler - 게시글 정보 조회 중 DB/JNDI 오류: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "게시글 정보를 불러오는 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            response.sendRedirect(request.getContextPath() + "/board/boardList.do");
            return null;
        }

        if (existingDto == null) {
            System.err.println("BoardDeleteHandler: 존재하지 않는 게시글 삭제 시도. ID: " + brdID);
            request.setAttribute("error", "삭제하려는 게시글이 존재하지 않습니다.");
            response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=board_not_found");
            return null;
        }

       
        if (!loggedInUserId.equals(existingDto.getKusID()) && !"ADMIN".equalsIgnoreCase(loggedInUserId)) {
            System.err.println("BoardDeleteHandler: 삭제 권한 없음. 로그인 ID: " + loggedInUserId + ", 게시글 작성자 ID: " + existingDto.getKusID());
            request.setAttribute("error", "해당 게시글을 삭제할 권한이 없습니다.");
            response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID + "&error=no_permission");
            return null;
        }
     

        try {
            int result = dao.deleteBoard(brdID);
            if (result > 0) {
                System.out.println("게시글 삭제 성공: ID " + brdID);
                response.sendRedirect(request.getContextPath() + "/board/boardList.do"); // 삭제 후 목록으로 이동
                return null;
            } else {
                System.err.println("BoardDeleteHandler: 게시글 삭제 실패 (영향 받은 행 수 0). ID: " + brdID);
                request.setAttribute("error", "게시글 삭제에 실패했습니다. 데이터베이스 문제일 수 있습니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID); // 삭제 실패 시 상세 페이지 유지
                return null;
            }
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDeleteHandler - 게시글 삭제 중 DB/JNDI 오류: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "게시글 삭제 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요. (에러: " + e.getMessage() + ")");
            response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID);
            return null;
        } catch (Exception e) { // 그 외 예상치 못한 모든 예외 처리
            System.err.println("BoardDeleteHandler - 예상치 못한 오류 발생: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID);
            return null;
        }
    }
}