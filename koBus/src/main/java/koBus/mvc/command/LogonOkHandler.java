package koBus.mvc.command;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.ConnectionProvider;

import koBus.mvc.persistence.LogonDAO;
import koBus.mvc.persistence.LogonDAOImpl;

public class LogonOkHandler implements CommandHandler {
	
	String id = null;
	String passwd = null;
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String location = "/koBusFile/kobus_main.jsp";
		System.out.println("> LogonOkHandler.process() ... Get");
		
		HttpSession session = request.getSession();
		String referer = (String)session.getAttribute("referer");
		System.out.println("> referer : " + referer);
		
		id = request.getParameter("id");
		passwd = request.getParameter("passwd");
		
		Connection conn = ConnectionProvider.getConnection();
		LogonDAO dao = new LogonDAOImpl(conn); 
			
	
		try {
			if (dao.logonCheck(id, passwd) == 1) {
				System.out.println("로그인 성공"); // dao에서의 정보를 못읽어옴
				
				session.setAttribute("auth", id);
				if(referer != null) {
					location += "?logon=success";
				}
				
			} else {
				System.out.println("로그인 실패");
				location = "/koBusFile/logonMain.jsp?logon=fail";
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
		
		return location;
		
	} // process

} // LogonOkHandler
