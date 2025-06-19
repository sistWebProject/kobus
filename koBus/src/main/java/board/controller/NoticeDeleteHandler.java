
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
	    request.setCharacterEncoding("UTF-8");

	    String notID = request.getParameter("notID");  // ★ 여기서 바로 String으로 받아야 함

	    Connection conn = null;
	    try {
	        conn = ConnectionProvider.getConnection();
	        noticeDAO dao = new noticeDAO();
	        int result = dao.delete(conn, notID);  // ★ 여기서도 그대로 String 넘김

	        if (result > 0) {
	            response.sendRedirect("/koBus/notice/noticeDelete.jsp");
	            return null;
	        } else {
	            request.setAttribute("error", "삭제 실패");
	            return "/html/noticeDelete.jsp";
	        }
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    } finally {
	        JdbcUtil.close(conn);
	    }
	}


}