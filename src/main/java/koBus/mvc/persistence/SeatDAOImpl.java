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
	public String getBusId(String deprId, String arrId, String deprDtm) {
		
		String busId = null;
		
		System.out.printf("deprId = %s, arrId = %s, deprDtm = %s\n", deprId, arrId, deprDtm);
		
		String sql = "SELECT b.BUSID "
				+ "	FROM BUSSCHEDULE b "
				+ "	JOIN ROUTE r ON b.ROUID = r.ROUID "
				+ "	JOIN DEPARTURE d ON r.DEPID = d.DEPID "
				+ "	JOIN ARRIVAL a ON r.ARRID = a.ARRID "
				+ "	JOIN BUS bu ON b.BUSID = bu.BUSID "
				+ "	WHERE d.REGID = ? "
				+ "  AND a.REGID = ? "
				+ "  AND b.DEPARTUREDATE = TO_TIMESTAMP(?, 'YYYYMMDD HH24:MI') ";
		
		 try {
			 if (deprDtm.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")) {
			        String datePart = deprDtm.substring(0, 10).replace("-", "");
			        String timePart = deprDtm.substring(11, 16);  // HH:mm
			        deprDtm = datePart + " " + timePart;


			    // Case 2: "yyyy-MM-dd"
			    }   
			 
			 this.pstmt = conn.prepareStatement(sql);
		        this.pstmt.setString(1, deprId);
		        this.pstmt.setString(2, arrId);
		        this.pstmt.setString(3, deprDtm);
		        this.rs = pstmt.executeQuery();
		        
		        if (rs.next()) {
		        	busId = rs.getString("BUSID");
		        }
		        


		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        JdbcUtil.close(this.rs);
		        JdbcUtil.close(this.pstmt);
		    }
		
		return busId;
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
		
//		System.out.println("SeatDAOImpl list.size() : " + list.size());
		
		JdbcUtil.close(this.rs);
        JdbcUtil.close(this.pstmt);
		
		return list;
	}



}
