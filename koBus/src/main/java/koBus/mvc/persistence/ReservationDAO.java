package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.util.DBConn;

import koBus.mvc.domain.ReservationDTO;

public class ReservationDAO {
	public boolean insertReservation(ReservationDTO dto) {
	    String sql = "INSERT INTO reservation (resID, bshID, seatID, kusID, rideDate, resvDate, resvStatus, resvType, qrCode, mileage, seatAble) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBConn.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, dto.getResID());
	        pstmt.setString(2, dto.getBshID());
	        pstmt.setString(3, dto.getSeatID());
	        pstmt.setString(4, dto.getKusID());
	        pstmt.setDate(5, dto.getRideDate());
	        pstmt.setDate(6, dto.getResvDate());
	        pstmt.setString(7, dto.getResvStatus());
	        pstmt.setString(8, dto.getResvType());
	        pstmt.setInt(9, dto.getQrCode());
	        pstmt.setInt(10, dto.getMileage());
	        pstmt.setString(11, dto.getSeatAble());
	        int cnt = pstmt.executeUpdate();
	        return cnt == 1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}
