
package board.controller;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import board.dao.BoardDAO;
import koBus.mvc.command.CommandHandler;

public class BoardDeleteHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    request.setCharacterEncoding("UTF-8");

	    String brdID = request.getParameter("brdID");

	    Connection conn = null;
	    try {
	        conn = ConnectionProvider.getConnection();
	        BoardDAO dao = new BoardDAO();
	        int result = dao.delete(conn, brdID);  // ★ 여기서도 그대로 String 넘김

	        if (result > 0) {
	            response.sendRedirect("/koBus/board/boardDelete.jsp");
	            return null;
	        } else {
	            request.setAttribute("error", "삭제 실패");
	            return "/html/boardDelete.jsp";
	        }
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    } finally {
	        JdbcUtil.close(conn);
	    }
	}


}