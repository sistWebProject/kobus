package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import board.dto.NoticeDTO;

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

    // 글 수정
    public int updateNotice(NoticeDTO dto) {
        String sql = "UPDATE notice SET topic = ?, content = ? WHERE notID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, dto.getTopic());
            ps.setString(2, dto.getContent());
            ps.setString(3, dto.getNotID());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 글 삭제
    public int deleteNotice(String notID) {
        String sql = "DELETE FROM notice WHERE notID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, notID);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
