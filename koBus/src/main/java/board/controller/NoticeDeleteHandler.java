
package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import koBus.mvc.command.CommandHandler;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import java.sql.Connection;

public class NoticeDeleteHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String param = request.getParameter("notID");

        if (param == null || param.trim().equals("")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "삭제할 게시글 ID가 없습니다.");
            return null;
        }

        int notID = Integer.parseInt(param);
        Connection conn = null;

        try {
            conn = ConnectionProvider.getConnection();
            noticeDAO dao = new noticeDAO(); // ✅ getInstance() 없이 직접 생성
            dao.delete(conn, notID);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            JdbcUtil.close(conn);
        }

        return "/notice/noticeDelete.jsp";
    }
}
