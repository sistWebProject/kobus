package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import board.dto.BoardDTO;

public class BoardDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public BoardDAO() {
		try {
			conn = ConnectionProvider.getConnection();
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
	}

	// 글 저장
	public int insertBoard(BoardDTO dto) {
		String sql = "INSERT INTO board (brdID, kusID, brdTitle, brdDate, brdContent) VALUES (board_seq.NEXTVAL, ?, ?, SYSDATE, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getKusID());
			ps.setString(2, dto.getBrdTitle());
			ps.setString(3, dto.getBrdContent());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// 글 목록
	public List<BoardDTO> getBoardList() {
		List<BoardDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM board ORDER BY brdDate DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBrdID(rs.getInt("brdID"));
				dto.setKusID(rs.getString("kusID"));
				dto.setBrdTitle(rs.getString("brdTitle"));
				dto.setBrdContent(rs.getString("brdContent"));
				dto.setBrdDate(rs.getDate("brdDate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 글 상세
	public BoardDTO getBoard(String brdID) {
		BoardDTO dto = null;
		String sql = "SELECT * FROM board WHERE brdID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brdID);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setBrdID(rs.getInt("brdID"));
				dto.setKusID(rs.getString("kusID"));
				dto.setBrdTitle(rs.getString("brdTitle"));
				dto.setBrdContent(rs.getString("brdContent"));
				dto.setBrdDate(rs.getDate("brdDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	// 글 수정
	public static int updateBoard(BoardDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "UPDATE board SET brdTitle = ?, brdContent = ? WHERE brdID = ?";

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBrdID());
			pstmt.setString(2, dto.getBrdTitle());
			pstmt.setString(3, dto.getBrdContent());

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}

		return 0;
	}

	// 글 삭제
	public int delete(Connection conn, String brdID) throws SQLException {
		String sql = "DELETE FROM board WHERE brdID = ?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, brdID);
			return pstmt.executeUpdate();
		}
	}

	// 게시글 1개 조회
	public static BoardDTO selectOne(String brdID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT brdID, kusID, brdTitle, brdContent, brdDate FROM board WHERE brdID = ?";

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brdID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBrdID(rs.getInt("brdID"));
				dto.setKusID(rs.getString("kusID"));
				dto.setBrdTitle(rs.getString("brdTitle"));
				dto.setBrdContent(rs.getString("brdContent"));
				dto.setBrdDate(rs.getDate("brdDate"));
				return dto;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}

		return null;
	}

	public BoardDTO getBoardWithUserInfo(String brdID) {
		BoardDTO dto = null;
		String sql = "SELECT b.brdID, b.kusID, b.brdTitle, b.brdContent, b.brdDate, "
				+ "       u.id AS userId, u.tel, u.rank " + "FROM board b " + "JOIN kobusUser u ON b.kusID = u.kusID "
				+ "WHERE b.brdID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brdID);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setBrdID(rs.getInt("brdID"));
				dto.setKusID(rs.getString("kusID"));
				dto.setBrdTitle(rs.getString("brdTitle"));
				dto.setBrdContent(rs.getString("brdContent"));
				dto.setBrdDate(rs.getDate("brdDate"));

				// 추가 회원 정보
				dto.setUserId(rs.getString("userId"));
				dto.setUserTel(rs.getString("tel"));
				dto.setUserRank(rs.getString("rank"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
