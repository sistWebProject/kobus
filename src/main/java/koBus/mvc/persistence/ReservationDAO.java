package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConn;

import koBus.mvc.domain.ReservationDTO;

public class ReservationDAO {
	public boolean insertReservation(ReservationDTO dto) {
		String sql = "INSERT INTO reservation (resID, bshID, seatID, kusID, rideDate, resvDate, resvStatus, resvType, qrCode, mileage, seatAble, reservation_no) " +
	             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
	        pstmt.setString(12, dto.getReservationNo()); // ★ 예매번호
	        int cnt = pstmt.executeUpdate();
	        return cnt == 1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public ReservationDTO selectReservationDetail(String resid) {
        String sql = "SELECT * FROM reservation WHERE resid = ?";
        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, resid);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ReservationDTO dto = new ReservationDTO();
                    dto.setResID(rs.getString("resid"));
                    dto.setBshID(rs.getString("bshid"));
                    dto.setSeatID(rs.getString("seatid"));
                    dto.setKusID(rs.getString("kusid"));
                    dto.setRideDate(rs.getDate("ridedate"));
                    dto.setResvDate(rs.getDate("resvdate"));
                    dto.setResvStatus(rs.getString("resvstatus"));
                    dto.setResvType(rs.getString("resvtype"));
                    dto.setQrCode(rs.getInt("qrcode"));
                    dto.setMileage(rs.getInt("mileage"));
                    dto.setSeatAble(rs.getString("seatable"));
                    dto.setReservationNo(rs.getString("reservation_no"));
                    return dto;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

}
