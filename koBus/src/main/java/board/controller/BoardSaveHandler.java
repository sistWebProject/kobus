package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession import 추가
import java.sql.SQLException; // SQLException 임포트
import javax.naming.NamingException; // NamingException 임포트

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardSaveHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println(">>> BoardSaveHandler.process() 호출됨 <<<"); // 디버깅용

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        // 로그인 시 세션에 저장한 사용자 ID(kusID) 속성 이름을 확인하세요.
        // 현재는 Integer로 저장된다고 가정하고 String으로 변환합니다.
        Integer loggedInUserKusID_Integer = (Integer) session.getAttribute("loggedInUserKusID");

        String kusID = null; // DTO에 설정할 String 타입의 kusID
        if (loggedInUserKusID_Integer != null) {
            kusID = String.valueOf(loggedInUserKusID_Integer); // Integer를 String으로 변환
        } else {
            // 로그인된 사용자가 없는 경우 처리
            System.err.println("BoardSaveHandler: 세션에 로그인된 사용자(kusID) 정보 없음. 로그인 페이지로 리다이렉트.");
            request.setAttribute("error", "로그인 후 게시글을 작성할 수 있습니다.");
            response.sendRedirect(request.getContextPath() + "/page/logonMain.do?error=login_required");
            return null;
        }

        // JSP 폼에서 넘어오는 kusID 파라미터는 더 이상 사용하지 않지만, 만약을 위해 주석 처리하거나 제거
        // String kusID_str = request.getParameter("kusID");
        // if (kusID_str != null && !kusID_str.isEmpty()) {
        //     // 세션의 kusID와 JSP 파라미터의 kusID가 일치하는지 검증하는 로직을 여기에 추가할 수 있음
        // }


        String brdTitle = request.getParameter("brdTitle");
        String brdContent = request.getParameter("brdContent");
        String brdCategory = request.getParameter("brdCategory"); // JSP 폼에서 넘어오는 구분값

        // 제목이나 내용이 비어있는 경우 유효성 검사
        if (brdTitle == null || brdTitle.trim().isEmpty() || brdContent == null || brdContent.trim().isEmpty()) {
            request.setAttribute("error", "제목과 내용을 모두 입력해주세요.");
            return "/board/boardWrite.jsp"; // 작성 페이지로 다시 포워드
        }

        // brdCategory가 null이거나 비어있을 경우 기본값 설정
        if (brdCategory == null || brdCategory.trim().isEmpty()) {
            brdCategory = "일반"; // 또는 "미분류" 등 적절한 기본값
        }

        // DTO 설정
        BoardDTO dto = new BoardDTO();
        dto.setKusID(kusID);        // **[수정]** String 타입의 kusID 설정
        dto.setBrdTitle(brdTitle);
        dto.setBrdContent(brdContent);
        dto.setBrdCategory(brdCategory);
        dto.setBrdViews(0);         // 새 글이므로 조회수 0으로 초기화

        BoardDAO dao = new BoardDAO();
        try {
            int result = dao.insertBoard(dto);
            if (result > 0) {
                System.out.println("게시글 저장 성공: " + dto.getBrdTitle());
                response.sendRedirect("boardList.do"); // 저장 성공 후 목록으로 이동
                return null;
            } else {
                System.err.println("BoardSaveHandler: 게시글 저장 실패 (영향 받은 행 수 0).");
                request.setAttribute("error", "게시글 저장에 실패했습니다. 데이터베이스 문제일 수 있습니다.");
                return "/board/boardWrite.jsp";
            }
        } catch (SQLException | NamingException e) { // DAO에서 던진 예외를 여기서 잡음
            System.err.println("BoardSaveHandler - 게시글 저장 중 DB/JNDI 오류: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "게시글 저장 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요. (에러: " + e.getMessage() + ")");
            return "/board/boardWrite.jsp";
        } catch (Exception e) { // 그 외 예상치 못한 모든 예외 처리
            System.err.println("BoardSaveHandler - 예상치 못한 오류 발생: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return "/board/boardWrite.jsp";
        }
    }
}