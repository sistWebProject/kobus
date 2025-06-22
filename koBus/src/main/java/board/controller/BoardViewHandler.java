package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException; // SQLException 임포트
import javax.naming.NamingException; // NamingException 임포트

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardViewHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

    	System.out.println("VIEW_doit()..");
    	String brdID_str = request.getParameter("brdID");
    	int brdID = 0; // 초기화

    	// brdID 파싱 오류 처리
    	try {
    	    brdID = Integer.parseInt(brdID_str); // String -> int 변환
    	} catch (NumberFormatException e) {
    	    System.err.println("BoardViewHandler - Invalid brdID format: " + brdID_str);
    	    request.setAttribute("error", "잘못된 게시글 번호입니다.");
    	    response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=invalid_brdid"); // 목록 페이지로 리다이렉트
    	    return null;
    	}

    	BoardDAO dao = new BoardDAO();
    	BoardDTO dto = null;

    	try {
            // 💡 추가: 조회수 증가 메서드 호출
            dao.incrementViewCount(brdID);

            // 게시글 정보 가져오기 (조회수 증가 후 최신 데이터 가져옴)
            dto = dao.getBoard(brdID);

            if (dto == null) {
                System.err.println("BoardViewHandler: 해당 brdID(" + brdID + ")의 게시글을 찾을 수 없습니다.");
                request.setAttribute("error", "존재하지 않는 게시글입니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=not_found"); // 목록 페이지로 리다이렉트
                return null;
            }
        } catch (SQLException | NamingException e) { // DAO에서 던진 예외를 여기서 잡음
            System.err.println("BoardViewHandler - 게시글 조회 중 DB/JNDI 오류: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "게시글 조회 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요. (에러: " + e.getMessage() + ")");
            return "/board/boardList.jsp"; // 에러 메시지와 함께 목록 페이지로 포워드
        } catch (Exception e) { // 그 외 예상치 못한 모든 예외 처리
            System.err.println("BoardViewHandler - 예상치 못한 오류 발생: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return "/board/boardList.jsp";
        }

        request.setAttribute("dto", dto);
        return "/board/boardView.jsp";
    }
}