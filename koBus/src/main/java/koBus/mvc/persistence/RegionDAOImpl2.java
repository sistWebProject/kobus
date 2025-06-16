package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import koBus.mvc.domain.RegionDTO2;

public class RegionDAOImpl2 implements RegionDAO2 {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public RegionDAOImpl2(Connection conn) {
		this.conn = conn;
	}

	@Override
	public List<RegionDTO2> selectBySidoCode(int sidoCode) {
		//25.06.14
		//List<RegionDTO> list = new ArrayList<>();
		List<RegionDTO2> list = new ArrayList<>();

		String sql = "SELECT * FROM region WHERE sidoCode = ?";



		try {
			System.out.println(">>> [DAO] sidoCode 파라미터: " + sidoCode);

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidoCode); 
			rs = pstmt.executeQuery();

			//25.06.14 ajh
			while (rs.next()) {
				String regID = rs.getString("regID");
				String regName = rs.getString("regName");
				int sc = rs.getInt("sidoCode");

				RegionDTO2 dto = new RegionDTO2().builder()
						.regID(regID)
						.regName(regName)
						.sidoCode(sc)
						.build();

				list.add(dto);
			}

			/* 25.06.14
           while(rs.next()) {


                dto.setRegID(rs.getString("regID"));
                dto.setRegName(rs.getString("regName"));
                dto.setSidoCode(rs.getInt("sidoCode"));


            } 
			 */
			System.out.println(">>> [DAO] 조회된 행 수: " + list.size());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
		}

		return list;
	}

	@Override
	public List<RegionDTO2> selectByRegion() {
		List<RegionDTO2> list = new ArrayList<>();

		String sql = "SELECT * FROM region ";

		try {

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			//25.06.14 ajh
			while (rs.next()) {
				String regID = rs.getString("regID");
				String regName = rs.getString("regName");
				int sc = rs.getInt("sidoCode");

				RegionDTO2 dto = new RegionDTO2().builder()
						.regID(regID)
						.regName(regName)
						.sidoCode(sc)
						.build();

				list.add(dto);
			}

			System.out.println(">>> [DAO] 조회된 행 수: " + list.size());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
		}

		return list;
	}

}
