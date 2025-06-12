package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import koBus.mvc.domain.RegionDTO;

public class RegionDAOImpl implements RegionDAO {

    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    public RegionDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<RegionDTO> selectBySidoCode(String sidoCode) {
        List<RegionDTO> list = new ArrayList<>();

        String sql = " SELECT * FROM region WHERE sidoCode = ? ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, sidoCode);  // 여기에서 사용자가 누른 버튼 값이 전달됨
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RegionDTO dto = new RegionDTO();
                dto.setRegID(rs.getString("regID"));
                dto.setRegName(rs.getString("regName"));
                dto.setSidoCode(rs.getString("sidoCode"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        }

        return list;
    }
}
