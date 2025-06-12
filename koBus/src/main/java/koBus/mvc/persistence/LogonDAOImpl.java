package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConn;

import koBus.mvc.domain.LogonDTO;

public class LogonDAOImpl implements LogonDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private LogonDTO dto = null;
	
	// 생성자 DI
	public LogonDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	public Connection getConn() {
		return conn;
	}

	// setter DI
	public void setConn(Connection conn) {
		this.conn = conn;
	}

	
	// 회원 아이디, 비밀번호 정보 가져와서 아이디 있으면 1, 없으면 0 넘겨줌
	@Override
	public int logonCheck(String inputId, String inputPasswd) throws SQLException {
		
		int result = 0;
		
		String sql = " SELECT id "
				+ " FROM kobususer "
				+ " WHERE id = ? AND passwd = ? ";
		
		this.pstmt = conn.prepareStatement(sql);
		this.pstmt.setString(1, inputId);
		this.pstmt.setString(2, inputPasswd);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			// 로그인 성공
			result = 1;
		}
		
		return result; // 로그인 성공 : 1, 로그인 실패 : 0
	}
}
