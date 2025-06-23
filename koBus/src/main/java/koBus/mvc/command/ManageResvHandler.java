package koBus.mvc.command;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.ConnectionProvider;

import koBus.mvc.domain.ResvDTO;
import koBus.mvc.persistence.ResvDAO;
import koBus.mvc.persistence.ResvDAOImpl;

public class ManageResvHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception, Throwable {
		
		System.out.println("> ManageResvHandler.process() ...");
		
		Connection conn = ConnectionProvider.getConnection();
		ResvDAO dao = new ResvDAOImpl(conn);
		HttpSession session = request.getSession(false);
		String mainParam = request.getParameter("mainParam");
		
		 if (session == null || session.getAttribute("id") == null) {
		        // 로그인 안 된 상태
		        response.sendRedirect("/koBus/koBusFile/logonMain.jsp");
		        return null;
		}
		
		String loginId = (String) session.getAttribute("id");
		System.out.println("현재 로그인한 사용자 ID: " + loginId);
		
		List<ResvDTO> resvList = dao.searchResvList(loginId);
		

;
		
		request.setAttribute("resvList", resvList);
		
		return "/koBusFile/kobusManageResv.jsp";
	}

}
