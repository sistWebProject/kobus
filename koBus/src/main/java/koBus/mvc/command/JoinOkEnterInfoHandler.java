package koBus.mvc.command;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;

import koBus.mvc.domain.JoinDTO;
import koBus.mvc.persistence.CertificationCodeDAO;
import koBus.mvc.persistence.CertificationCodeDAOImpl;


public class JoinOkEnterInfoHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception, Throwable {
		
		// 받아온 회원정보 db에 값 넘겨주기
		System.out.println("> JoinOkEnterInfoHandler.process()...");
		
		String tel = request.getParameter("usrTel");
		String subEmail = request.getParameter("emi");
		String id = request.getParameter("usrId");
		String passwd = request.getParameter("usrPwd");
		String birth = request.getParameter("ageYear");
		String gender = request.getParameter("hpNo");
		int genderNum=0;
		
		if(gender.equals("남자")) {
			genderNum=1;
		} else {
			genderNum=2;
		}
		
		JoinDTO dto = new JoinDTO(tel, subEmail, id, passwd, birth, genderNum);
		
		Connection conn = ConnectionProvider.getConnection();
		CertificationCodeDAO dao = new CertificationCodeDAOImpl(conn);
		
		int rowCount = 0;
		
		try {
			rowCount = dao.insert(dto);
			if (rowCount <= 0) {
				System.out.println("회원가입 정보 입력 실패");
			} else {
				System.out.println("회원가입 정보 입력 성공");
			}
		} catch (Exception e) {
			System.out.println("> JoinOkEnterInfoHandler.process() Exception...");
			e.printStackTrace();
		} finally {
			conn.close();
		}
		
		String location = "/koBus/main.do";
		response.sendRedirect(location);
		return null;
	}

}
