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
	    
	    String sql = "SELECT id FROM kobususer WHERE id = ? AND passwd = ? ";
	    
	    try {
	        this.pstmt = conn.prepareStatement(sql);
	        this.pstmt.setString(1, inputId.trim());
	        this.pstmt.setString(2, inputPasswd.trim());
	        
	        this.rs = this.pstmt.executeQuery();
	        
	        System.out.println(rs.next()); // rs.next()가 false로 받아져옴 -> 오류해결할것
	        
	        if (this.rs.next()) {
	            result = 1; 
	        }	     
	       
	    } catch(SQLException e){
	    	e.printStackTrace();
	    }finally {
	        try { if (this.rs != null) this.rs.close(); } catch (SQLException e) { e.printStackTrace(); }
	        try { if (this.pstmt != null) this.pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
	    }
	    
	    return result;
	}

}
