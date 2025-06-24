package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import board.dto.CommentDTO;
import com.util.ConnectionProvider;

public class CommentDAOImpl implements CommentDAO {

    @Override
    public List<CommentDTO> getCommentsByBrdID(int brdID) throws Exception {
        List<CommentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM brdcomment WHERE brdID = ? ORDER BY cmtDate ASC";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, brdID);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CommentDTO dto = new CommentDTO();
                    dto.setCmtID(rs.getInt("cmtID"));
                    dto.setBrdID(rs.getInt("brdID"));
                    dto.setKusID(rs.getString("kusID"));
                    dto.setContent(rs.getString("content"));
                    dto.setCmtDate(rs.getTimestamp("cmtDate"));
                    list.add(dto);
                }
            }
        }
        return list;
    }

    @Override
    public int insertComment(CommentDTO dto) throws Exception {
        int result = 0;

        String sql = "INSERT INTO brdcomment (cmtID, brdID, kusID, content, cmtDate) "
                   + "VALUES (brdcomment_seq.NEXTVAL, ?, ?, ?, SYSTIMESTAMP)";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dto.getBrdID());
            pstmt.setString(2, dto.getKusID());
            pstmt.setString(3, dto.getContent());

            result = pstmt.executeUpdate();
        }

        return result;
    }


    @Override
    public int deleteComment(int cmtID) throws Exception {
        String sql = "DELETE FROM brdcomment WHERE cmtID = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, cmtID);
            return pstmt.executeUpdate();
        }
    }

    @Override
    public int updateComment(CommentDTO dto) throws Exception {
        String sql = "UPDATE brdcomment SET content = ? WHERE cmtID = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getContent());
            pstmt.setInt(2, dto.getCmtID());
            return pstmt.executeUpdate();
        }
    }
}
