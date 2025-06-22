package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import board.dto.BoardDTO;

public class BoardDAO {

    public BoardDAO() {
    }

    // 글 저장 (INSERT)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public int insertBoard(BoardDTO dto) throws SQLException, NamingException {
        String sql = "INSERT INTO board (brdId, kusId, brdTitle, brdContent, brdDate, brdViews, brdCategory) "
                + "VALUES (board_seq.nextval, ?, ?, ?, SYSTIMESTAMP, ?, ?)";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dto.getKusID()); // **[수정]** kusID가 String이므로 setString 사용
            ps.setString(2, dto.getBrdTitle());
            ps.setString(3, dto.getBrdContent());
            ps.setInt(4, dto.getBrdViews());
            ps.setString(5, dto.getBrdCategory());
            return ps.executeUpdate();
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - insertBoard 오류: " + e.getMessage());
            e.printStackTrace();
            throw e; // 예외를 다시 던져서 상위 핸들러가 처리하도록 함
        }
    }

    // 글 목록 (SELECT ALL)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public List<BoardDTO> getBoardList() throws SQLException, NamingException {
        List<BoardDTO> list = new ArrayList<>();
        String sql = "SELECT b.brdID, b.kusID, b.brdTitle, b.brdContent, b.brdDate, b.brdViews, b.brdCategory, "
                    + "u.ID AS userId, u.tel, u.RANK "
                    + "FROM board b "
                    + "JOIN kobusUser u ON b.kusID = u.kusID "
                    + "ORDER BY b.brdID DESC";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setBrdID(rs.getInt("brdID"));
                dto.setKusID(rs.getString("kusID")); // **[수정]** kusID가 String이므로 getString 사용
                dto.setBrdTitle(rs.getString("brdTitle"));
                dto.setBrdContent(rs.getString("brdContent"));
                dto.setBrdDate(rs.getTimestamp("brdDate"));
                dto.setBrdViews(rs.getInt("brdViews"));
                dto.setBrdCategory(rs.getString("brdCategory"));

                // 추가된 회원 정보
                dto.setUserId(rs.getString("userId"));
                dto.setUserTel(rs.getString("tel"));
                dto.setUserRank(rs.getString("RANK"));

                list.add(dto);
            }
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - getBoardList 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    // 글 상세 보기 (SELECT ONE)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public BoardDTO getBoard(int brdID) throws SQLException, NamingException {
        BoardDTO dto = null;
        String sql = "SELECT b.brdID, b.kusID, b.brdTitle, b.brdContent, b.brdDate, b.brdViews, b.brdCategory, "
                   + "u.ID AS userId, u.tel, u.RANK "
                   + "FROM board b "
                   + "JOIN kobusUser u ON b.kusID = u.kusID "
                   + "WHERE b.brdID = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brdID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dto = new BoardDTO();
                    dto.setBrdID(rs.getInt("brdID"));
                    dto.setKusID(rs.getString("kusID")); // **[수정]** kusID가 String이므로 getString 사용
                    dto.setBrdTitle(rs.getString("brdTitle"));
                    dto.setBrdContent(rs.getString("brdContent"));
                    dto.setBrdDate(rs.getTimestamp("brdDate"));
                    dto.setBrdViews(rs.getInt("brdViews"));
                    dto.setBrdCategory(rs.getString("brdCategory"));

                    // BoardDTO에 추가된 사용자 정보 필드 설정
                    dto.setUserId(rs.getString("userId"));
                    dto.setUserTel(rs.getString("tel"));
                    dto.setUserRank(rs.getString("RANK"));
                }
            }
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - getBoard 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return dto;
    }

    // 글 수정 (UPDATE)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public int updateBoard(BoardDTO dto) throws SQLException, NamingException {
        String sql = "UPDATE board SET brdTitle = ?, brdContent = ?, brdCategory = ?, brdDate = SYSTIMESTAMP "
                   + "WHERE brdID = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dto.getBrdTitle());
            ps.setString(2, dto.getBrdContent());
            ps.setString(3, dto.getBrdCategory());
            ps.setInt(4, dto.getBrdID());
            return ps.executeUpdate();
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - updateBoard 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // 글 삭제 (DELETE)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public int deleteBoard(int brdID) throws SQLException, NamingException {
        String sql = "DELETE FROM board WHERE brdID = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brdID);
            return ps.executeUpdate();
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - deleteBoard 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // 조회수 증가 (UPDATE)
    // SQLException 또는 NamingException 발생 시 예외를 던지도록 수정
    public int incrementViewCount(int brdID) throws SQLException, NamingException {
        String sql = "UPDATE board SET brdViews = brdViews + 1 WHERE brdID = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brdID);
            return ps.executeUpdate();
        } catch (SQLException | NamingException e) {
            System.err.println("BoardDAO - incrementViewCount 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}