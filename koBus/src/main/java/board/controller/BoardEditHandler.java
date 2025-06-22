package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession import 추가
import java.sql.SQLException;      // SQLException 임포트
import javax.naming.NamingException; // NamingException 임포트

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import koBus.mvc.command.CommandHandler;

public class BoardEditHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception { // Exception으로 통일
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String method = request.getMethod();
        BoardDAO dao = new BoardDAO(); // DAO 인스턴스 생성

        String brdID_str = request.getParameter("brdID");
        int brdID = 0;
        try {
            brdID = Integer.parseInt(brdID_str);
        } catch (NumberFormatException e) {
            System.err.println("BoardEditHandler - Invalid brdID format: " + brdID_str);
            request.setAttribute("error", "유효하지 않은 게시글 번호입니다.");
            response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=invalid_id");
            return null;
        }

        // --- 권한 검증을 위한 로그인 사용자 ID 가져오기 ---
        HttpSession session = request.getSession();
        String loggedInUserId = (String) session.getAttribute("loggedInUserID"); // 로그인 시 저장된 사용자 ID (예: "user01", "ADMIN")
                                                                                // 'loggedInUserKusID'가 아니라 'loggedInUserID'를 사용한다고 가정

        if (loggedInUserId == null) {
            System.err.println("BoardEditHandler: 로그인되지 않은 사용자의 수정 시도.");
            request.setAttribute("error", "로그인 후 게시글을 수정할 수 있습니다.");
            response.sendRedirect(request.getContextPath() + "/page/logonMain.do?error=login_required");
            return null;
        }
        // --- 권한 검증을 위한 로그인 사용자 ID 가져오기 끝 ---


        if (method.equalsIgnoreCase("GET")) {
            // GET 요청: 게시글 수정 폼 보여주기
            BoardDTO dto = null;
            try {
                dto = dao.getBoard(brdID); // 기존 게시글 정보 가져오기
            } catch (SQLException | NamingException e) {
                System.err.println("BoardEditHandler (GET) - 게시글 정보 조회 중 DB/JNDI 오류: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "게시글 정보를 불러오는 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                return "/board/boardList.jsp"; // 또는 적절한 에러 페이지
            }

            if (dto == null) {
                System.err.println("BoardEditHandler (GET): 존재하지 않는 게시글 수정 폼 요청. ID: " + brdID);
                request.setAttribute("error", "수정하려는 게시글이 존재하지 않습니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=board_not_found");
                return null;
            }

            // --- GET 요청 시 권한 검증 ---
            // dto.getKusID()는 String 타입 (DB의 VARCHAR2)
            if (!loggedInUserId.equals(dto.getKusID()) && !"ADMIN".equalsIgnoreCase(loggedInUserId)) {
                System.err.println("BoardEditHandler (GET): 수정 권한 없음. 로그인 ID: " + loggedInUserId + ", 게시글 작성자 ID: " + dto.getKusID());
                request.setAttribute("error", "해당 게시글을 수정할 권한이 없습니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID + "&error=no_permission");
                return null;
            }
            // --- GET 요청 시 권한 검증 끝 ---

            request.setAttribute("dto", dto);
            return "/board/boardEdit.jsp"; // 수정 폼으로 포워드

        } else if (method.equalsIgnoreCase("POST")) {
            // POST 요청: 게시글 수정 처리
            String brdTitle = request.getParameter("brdTitle");
            String brdContent = request.getParameter("brdContent");
            String brdCategory = request.getParameter("brdCategory");

            // 제목이나 내용이 비어있는 경우 유효성 검사
            if (brdTitle == null || brdTitle.trim().isEmpty() || brdContent == null || brdContent.trim().isEmpty()) {
                request.setAttribute("error", "제목과 내용을 모두 입력해주세요.");
                // 기존 게시글 정보를 다시 불러와서 폼에 채워주기 위해 DAO 호출
                BoardDTO existingDto = null;
                try {
                    existingDto = dao.getBoard(brdID);
                } catch (SQLException | NamingException e) {
                    System.err.println("BoardEditHandler (POST-Validation) - 게시글 정보 조회 중 DB/JNDI 오류: " + e.getMessage());
                    e.printStackTrace();
                }
                request.setAttribute("dto", existingDto); // 에러 발생 시 기존 데이터 유지
                return "/board/boardEdit.jsp";
            }

            BoardDTO existingDto = null;
            try {
                existingDto = dao.getBoard(brdID); // 수정 전 기존 게시글 정보를 다시 가져옴 (작성자 ID 확인용)
            } catch (SQLException | NamingException e) {
                System.err.println("BoardEditHandler (POST) - 기존 게시글 정보 조회 중 DB/JNDI 오류: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "게시글 정보를 불러오는 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                return "/board/boardEdit.jsp";
            }

            if (existingDto == null) {
                System.err.println("BoardEditHandler (POST): 존재하지 않는 게시글 수정 시도. ID: " + brdID);
                request.setAttribute("error", "수정하려는 게시글이 존재하지 않습니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardList.do?error=board_not_found");
                return null;
            }

            // --- POST 요청 시 권한 검증 ---
            // existingDto.getKusID()는 String 타입
            if (!loggedInUserId.equals(existingDto.getKusID()) && !"ADMIN".equalsIgnoreCase(loggedInUserId)) {
                System.err.println("BoardEditHandler (POST): 수정 권한 없음. 로그인 ID: " + loggedInUserId + ", 게시글 작성자 ID: " + existingDto.getKusID());
                request.setAttribute("error", "해당 게시글을 수정할 권한이 없습니다.");
                response.sendRedirect(request.getContextPath() + "/board/boardView.do?brdID=" + brdID + "&error=no_permission");
                return null;
            }
            // --- POST 요청 시 권한 검증 끝 ---

            // DTO에 수정된 정보 설정 (작성자 ID는 기존 게시글의 작성자 ID를 그대로 유지)
            BoardDTO dto = new BoardDTO();
            dto.setBrdID(brdID);
            dto.setKusID(existingDto.getKusID()); // 기존 작성자 ID를 그대로 유지
            dto.setBrdTitle(brdTitle);
            dto.setBrdContent(brdContent);
            // JSP에서 brdCategory를 입력받지 않았다면, 기존 값을 유지하는 것이 더 적절할 수 있습니다.
            // 여기서는 JSP에서 새로운 brdCategory를 입력받는다고 가정하고 설정합니다.
            // 만약 JSP에서 brdCategory를 수정하지 않는다면, `existingDto.getBrdCategory()`를 사용하세요.
            dto.setBrdCategory(brdCategory != null ? brdCategory : existingDto.getBrdCategory()); // 새 카테고리 없으면 기존 유지

            try {
                int result = dao.updateBoard(dto);

                if (result > 0) {
                    System.out.println("게시글 수정 성공: ID " + brdID);
                    String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/board/boardView.do?brdID=" + brdID); // 수정 후 상세 페이지로 리다이렉트
                    return null;
                } else {
                    System.err.println("BoardEditHandler (POST): 게시글 수정 실패 (영향 받은 행 수 0). ID: " + brdID);
                    request.setAttribute("error", "게시글 수정에 실패했습니다. 데이터베이스 문제일 수 있습니다.");
                    request.setAttribute("dto", dto); // 실패 시 현재 입력된 값으로 폼 유지
                    return "/board/boardEdit.jsp";
                }
            } catch (SQLException | NamingException e) {
                System.err.println("BoardEditHandler (POST) - 게시글 수정 중 DB/JNDI 오류: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "게시글 수정 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요. (에러: " + e.getMessage() + ")");
                request.setAttribute("dto", dto); // 에러 발생 시 현재 입력된 값으로 폼 유지
                return "/board/boardEdit.jsp";
            } catch (Exception e) { // 그 외 예상치 못한 모든 예외 처리
                System.err.println("BoardEditHandler (POST) - 예상치 못한 오류 발생: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                request.setAttribute("dto", dto); // 에러 발생 시 현재 입력된 값으로 폼 유지
                return "/board/boardEdit.jsp";
            }
        }
        return null; // Should not reach here
    }
}