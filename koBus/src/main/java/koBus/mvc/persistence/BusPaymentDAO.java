package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import koBus.mvc.domain.BusPaymentDTO;

public class BusPaymentDAO {
    private Connection conn;

    public BusPaymentDAO(Connection conn) {
        this.conn = conn;
    }

    public int insertPayment(BusPaymentDTO dto) throws SQLException {
        String sql = "INSERT INTO reservation_payment "
                + "(reservation_payment_id, res_id, kusid, imp_uid, merchant_uid, pay_method, amount, pay_status, pg_tid, paid_at) "
                + "VALUES (reservation_payment_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getResId());
            pstmt.setString(2, dto.getUserId());
            pstmt.setString(3, dto.getImpUid());
            pstmt.setString(4, dto.getMerchantUid());
            pstmt.setString(5, dto.getPayMethod());
            pstmt.setInt(6, dto.getAmount());
            pstmt.setString(7, dto.getPayStatus());
            pstmt.setString(8, dto.getPgTid());
            pstmt.setDate(9, dto.getPaidAt());

            return pstmt.executeUpdate();
        }
    }
}
