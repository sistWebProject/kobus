package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import koBus.mvc.domain.SeatDTO;

public class SeatDAOImpl implements SeatDAO{

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private SeatDTO dto = null;

	public SeatDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public Connection getConn() {
		return conn;
	}

	@Override
	public int getTotalSeats(String busId) throws SQLException {
		/* String busId = request.getParameter("BUSID"); */
	    int seatTotal = 0;
	    
	    String sql = "SELECT BUSSEATS FROM BUS WHERE BUSID = ?";

	    try {
	        this.pstmt = conn.prepareStatement(sql);
	        this.pstmt.setString(1, busId);
	        this.rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	seatTotal = rs.getInt("BUSSEATS");
	        }
	        
	        System.out.println("SeatDAOImpl seatTotal : " + seatTotal);


	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        JdbcUtil.close(this.rs);
	        JdbcUtil.close(this.pstmt);
	    }
		
		
		return seatTotal;
	}

	@Override
	public List<SeatDTO> searchSeat(String busId) throws SQLException {
		
		List<SeatDTO> list = null;
		String sql = "select seatid, busid, seatno, seattype, seatable "
				+ " from seat "
				+ " where busid = ? ";
		
		String seatId; 		
		int seatNo; 		
		String seatType; 
		String seatAble;
		
		this.pstmt = conn.prepareStatement(sql);
		this.pstmt.setString(1, busId);
		this.rs = this.pstmt.executeQuery();
		
		System.out.println("SeatDAOImpl busId : " + busId);
		System.out.println(sql);
		
		if (this.rs.next()) {
			list = new ArrayList<SeatDTO>();
			do {
				
				seatId = this.rs.getString("seatId");
				seatNo = this.rs.getInt("seatNo");
				busId = this.rs.getString("busId");
				seatType = this.rs.getString("seatType");
				seatAble = this.rs.getString("seatAble");
				
				this.dto = new SeatDTO().builder().
						seatId(seatId).
						seatNo(seatNo).
						busId(busId).
						seatType(seatType).
						seatAble(seatAble).build();
				list.add(dto);
				
//				System.out.printf("seatId : %s , seatNo : %d , busId : %s", seatId, seatNo, busId);
				
			} while (this.rs.next());
		}
		
		System.out.println("SeatDAOImpl list.size() : " + list.size());
		
		JdbcUtil.close(this.rs);
        JdbcUtil.close(this.pstmt);
		
		return list;
	}

}
