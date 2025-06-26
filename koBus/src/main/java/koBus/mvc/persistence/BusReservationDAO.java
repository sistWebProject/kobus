package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.util.DBConn;

import koBus.mvc.domain.BusReservationDTO;

public class BusReservationDAO {
    private Connection conn;

    public BusReservationDAO(Connection conn) {
        this.conn = conn;
    }

    public int insertReservation(BusReservationDTO dto) throws SQLException {
        String sql = "INSERT INTO reservation " +
                "(resID, bshID, seatID, kusID, rideDate, resvDate, resvStatus, resvType, qrCode, mileage, seatAble) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getResId());
            pstmt.setString(2, dto.getBshID());
            pstmt.setString(3, dto.getSeatNumber());
            pstmt.setString(4, dto.getUserId());
            pstmt.setTimestamp(5, dto.getBoardingDt());
            pstmt.setDate(6, new Date(System.currentTimeMillis()));
            pstmt.setString(7, "결제대기");
            pstmt.setString(8, "일반");
            pstmt.setInt(9, (int) (Math.random() * 900000) + 100000);
            pstmt.setInt(10, 0);
            pstmt.setString(11, "Y");

            return pstmt.executeUpdate();
        }
    }
    
    public int updateReservationStatus(String resId, String status) throws SQLException {
        String sql = "UPDATE reservation SET resvStatus = ? WHERE resID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status); // 예: "결제완료"
            pstmt.setString(2, resId);
            return pstmt.executeUpdate();
        }
    }

}
