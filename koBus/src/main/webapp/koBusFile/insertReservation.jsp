<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConn" %>
<%
    request.setCharacterEncoding("UTF-8");

    String departure = request.getParameter("departure");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DBConn.getConnection();

        String sql = "INSERT INTO reservation (resID, rideDate, resvDate, resvStatus, resvType, qrCode, mileage, seatAble) " +
                     "VALUES ('RS' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'), SYSDATE, SYSDATE, '예약완료', ?, ?, 0, 'N')";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, departure); // 임시로 등급 대신 출발지 저장
        pstmt.setInt(2, (int)(Math.random() * 900000 + 100000));

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("예매 완료! 출발지: " + departure);
        } else {
            out.println("예매 실패!");
        }

    } catch (Exception e) {
        out.println("오류 발생: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>