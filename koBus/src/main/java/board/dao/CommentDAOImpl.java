package board.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import board.dto.CommentDTO;

public class CommentDAOImpl implements CommentDAO {

    private Connection conn;

    public CommentDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public int insertComment(CommentDTO dto) throws Exception {
        String sql = "INSERT INTO brdComment (bcmID, brdID, kusID, comContent, comDate) "
                   + "VALUES (brdComment_seq.NEXTVAL, ?, ?, ?, SYSTIMESTAMP)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dto.getBrdID());
            pstmt.setString(2, dto.getKusID());
            pstmt.setString(3, dto.getComContent());

            return pstmt.executeUpdate();
        }
    }

    @Override
    public List<CommentDTO> getCommentsByBoardID(int brdID) throws Exception {
        String sql = "SELECT * FROM brdComment WHERE brdID = ? ORDER BY comDate ASC";
        List<CommentDTO> list = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, brdID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentDTO dto = new CommentDTO();
                dto.setBcmID(rs.getInt("bcmID"));
                dto.setBrdID(rs.getInt("brdID"));
                dto.setKusID(rs.getString("kusID"));
                dto.setComContent(rs.getString("comContent"));
                dto.setComDate(rs.getTimestamp("comDate"));
                list.add(dto);
            }
        }

        return list;
    }
}
