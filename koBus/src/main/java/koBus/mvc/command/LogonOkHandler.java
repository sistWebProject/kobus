package koBus.mvc.command;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.ConnectionProvider;

import koBus.mvc.persistence.LogonDAO;
import koBus.mvc.persistence.LogonDAOImpl;

public class LogonOkHandler implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String location = "/koBus/koBusFile/kobus_main.jsp";
		System.out.println("> LogonOkHandler.process() ... Get");
		
		HttpSession session = request.getSession();
		// String referer = (String)session.getAttribute("referer");
		// System.out.println("> referer : " + referer);
		
		String id = request.getParameter("usrId").trim();
		String passwd = request.getParameter("usrPwd").trim();
		
		System.out.println("id : " + id);
		System.out.println("passwd : " + passwd);
		
		Connection conn = ConnectionProvider.getConnection();
		LogonDAOImpl dao = new LogonDAOImpl(conn); 
		
		try {
			if (dao.logonCheck(id, passwd) == 1) {
				System.out.println("로그인 성공");
				
				session.setAttribute("auth", id);
				session.setAttribute("id", id);
				
				session.setAttribute("result", dao.logonCheck(id, passwd));
				location += "?logon=success";	
				
				System.out.println("location" + location); 
				
				// 로그인 성공 : 리다이렉트
				response.sendRedirect(location);
				return null;
				
			} else {
				System.out.println("로그인 실패");
				request.setAttribute("result", dao.logonCheck(id, passwd));
				location = "/koBusFile/logonMain.jsp?logon=fail";
				
				System.out.println("location" + location);
				
				// 로그인 실패 : 포워딩
				return location;
			}
		} catch (SQLException e) {
			System.out.println("> LogonOkHandler.process() ... Exception");
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("location" + location);
		return location;
		
	} // process

} // LogonOkHandler
