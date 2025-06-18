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

import board.dto.NoticeDTO;
import board.notce.domain.ReplyBoardDTO;

public class noticeDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public noticeDAO() {
		try {
			conn = ConnectionProvider.getConnection();
		} catch (NamingException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<ReplyBoardDTO> searchBySubject(Connection con, String keyword) throws SQLException {
		String sql = "SELECT * FROM reply_board WHERE subject LIKE ?";
		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + keyword + "%");
			try (ResultSet rs = pstmt.executeQuery()) {
				List<ReplyBoardDTO> list = new ArrayList<>();
				while (rs.next()) {
					// dto 생성해서 list.add()
				}
				return list;
			}
		}
	}

	// 글 저장
	public int insertNotice(NoticeDTO dto) {
		String sql = "INSERT INTO notice (notID, topic, notDate, content) VALUES (?, ?, SYSDATE, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getNotID());
			ps.setString(2, dto.getTopic());
			ps.setString(3, dto.getContent());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// 글 목록
	public List<NoticeDTO> getNoticeList() {
		List<NoticeDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM notice ORDER BY notDate DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setContent(rs.getString("content"));
				dto.setNotDate(rs.getDate("notDate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 글 상세
	public NoticeDTO getNotice(String notID) {
		NoticeDTO dto = null;
		String sql = "SELECT * FROM notice WHERE notID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, notID);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setContent(rs.getString("content"));
				dto.setNotDate(rs.getDate("notDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	// 게시글 수정
	public static int updateNotice(NoticeDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "UPDATE notice SET topic = ?, content = ? WHERE notID = ?";

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTopic());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getNotID());

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
	public int delete(Connection conn, int notID) throws SQLException {
		String sql = "DELETE FROM notice WHERE notID = ?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, notID);
			return pstmt.executeUpdate();
		}
	}

	// 게시글 1개 조회
	public static NoticeDTO selectOne(String notID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT notID, topic, content, notDate FROM notice WHERE notID = ?";

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setContent(rs.getString("content"));
				dto.setNotDate(rs.getDate("notDate"));
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

	public static List<NoticeDTO> getAllNotices() throws SQLException, Exception {
		List<NoticeDTO> list = new ArrayList<>();

		String sql = "SELECT * FROM notice ORDER BY regdate DESC";
		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setNotDate(rs.getDate("regdate"));
				list.add(dto);
			}
		}
		return list;
	}

	public static List<NoticeDTO> searchNotices(String search) {
		List<NoticeDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM notice WHERE topic LIKE ? ORDER BY regdate DESC";

		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, "%" + search + "%");

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					NoticeDTO dto = new NoticeDTO();
					dto.setNotID(rs.getString("notID"));
					dto.setTopic(rs.getString("topic"));
					dto.setNotDate(rs.getDate("regdate"));
					list.add(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static List<NoticeDTO> selectImportantNotices() {
		List<NoticeDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM notice WHERE importance = 1 ORDER BY regdate DESC FETCH FIRST 6 ROWS ONLY";

		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setNotDate(rs.getDate("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public static List<NoticeDTO> selectGeneralNotices() {
		List<NoticeDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM notice WHERE importance = 0 ORDER BY regdate DESC";

		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotID(rs.getString("notID"));
				dto.setTopic(rs.getString("topic"));
				dto.setNotDate(rs.getDate("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	

}
