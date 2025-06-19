package koBus.mvc.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogonMyPageHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception, Throwable {
		// 세션에 담겨있는 auth를 이용해 
		// 예매내역 행갯수, 프리패스/정기권 행개수, 휴대폰번호를 가져와서 페이지에 뿌려줌 
		
		
		return "/koBusFile/logonMyPage.jsp";
	}
	
}
