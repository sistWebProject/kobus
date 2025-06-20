package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import koBus.mvc.domain.ScheduleDTO;

public class ScheduleDAOImpl implements ScheduleDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public ScheduleDAOImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public List<ScheduleDTO> selectBySidoCode(int sidoCode) {
		List<ScheduleDTO> list = new ArrayList<>();

		String sql = "SELECT * FROM region WHERE sidoCode = ?";

		try {
			System.out.println("sidoCode " + sidoCode);

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidoCode); 
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String regID = rs.getString("regID");
				String regName = rs.getString("regName");
				int sc = rs.getInt("sidoCode");

				ScheduleDTO dto = new ScheduleDTO().builder()
						.regID(regID)
						.regName(regName)
						.sidoCode(sc)
						.build();

				list.add(dto);
			}

			System.out.println("list.size() " + list.size());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
		}

		return list;
	}

	@Override
	public List<ScheduleDTO> selectByRegion() {
		List<ScheduleDTO> list = new ArrayList<>();

		String sql = "SELECT * FROM region ";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String regID = rs.getString("regID");
				String regName = rs.getString("regName");
				int sc = rs.getInt("sidoCode");

				ScheduleDTO dto = new ScheduleDTO().builder()
						.regID(regID)
						.regName(regName)
						.sidoCode(sc)
						.build();

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

	@Override
	public List<ScheduleDTO> searchBusSchedule(String deprId, String arrId, String deprDtm, String busClsCd) throws SQLException {
		List<ScheduleDTO> schList = new ArrayList<>();

		System.out.printf("deprId : %s, arrId : %s, deprDtm : %s, busClsCd :  %s\n", deprId, arrId, deprDtm, busClsCd);

		String sql = "SELECT "
				+ " BS.BSHID, "
				+ " BS.ROUID, "
				+ " BS.BUSID,  "
				+ " BS.DEPARTUREDATE, "
				+ " C.COMNAME, "
				+ " B.BUSGRADE, "
				+ " BS.DURMIN, "
				+ " BS.ADULTFARE, "
				+ " BS.STUFARE, "
				+ " BS.CHILDFARE, "
				+ " BS.ARRIVALDATE, "
				+ " BS.REMAINSEATS,  "
				+ " B.BUSSEATS  "
				+ " FROM busschedule BS "
				+ " JOIN BUS B ON BS.BUSID = B.BUSID "
				+ " JOIN COMPANY C ON B.COMID = C.COMID "
				+ " JOIN ROUTE R ON BS.ROUID = R.ROUID "
				+ " JOIN arrival A ON A.ARRID = R.ARRID "
				+ " JOIN departure D ON D.DEPID = R.DEPID "
				+ " JOIN REGION RGD ON D.REGID = RGD.REGID  "
				+ " JOIN REGION RGA ON A.REGID = RGA.REGID "
				+ " WHERE RGD.REGID = ? AND RGA.REGID = ? "
				+ " AND TRUNC(BS.DEPARTUREDATE) = TO_DATE( ? , 'YYYYMMDD') ";

		if (!busClsCd.equals("전체")) {
			sql += " AND B.BUSGRADE = ? ";
		}

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, deprId);
		pstmt.setString(2, arrId);
		pstmt.setString(3, deprDtm);

		if (!busClsCd.equals("전체")) {
			pstmt.setString(4, busClsCd);
		}

		rs = pstmt.executeQuery();

		System.out.println(sql);

		while (rs.next()) {
			LocalDateTime departureDate = rs.getTimestamp("departureDate").toLocalDateTime();	
			String comName = rs.getString("comName");
			String busGrade = rs.getString("busGrade");
			int adultFare = rs.getInt("adultFare");
			int stuFare = rs.getInt("stuFare");
			int childFare = rs.getInt("childFare");
			LocalDateTime arrivalDate = rs.getTimestamp("arrivalDate").toLocalDateTime();	
			int durMin = rs.getInt("durMin");
			String bshId = rs.getString("bshId");
			String busId = rs.getString("busId");
			int remainSeats = rs.getInt("remainSeats");
			int busSeats = rs.getInt("busSeats");

			ScheduleDTO schDto = new ScheduleDTO().builder()
					.departureDate(departureDate)
					.comName(comName)
					.busGrade(busGrade)
					.adultFare(adultFare)
					.stuFare(stuFare)
					.childFare(childFare)
					.arrivalDate(arrivalDate)
					.durMin(durMin)
					.bshId(bshId)
					.busId(busId)
					.remainSeats(remainSeats)
					.busSeats(busSeats)
					.build();

			schList.add(schDto);
		}

		return schList;
	}

	@Override
	public int getDurationFromRoute(String deprRegId, String arvlRegId) throws SQLException {
	    int duration = 0;

	    String sql = "SELECT R.duration " +
	                 "FROM route R " +
	                 "JOIN departure D ON R.depid = D.depid " +
	                 "JOIN arrival A ON R.arrid = A.arrid " +
	                 "JOIN region RG_D ON D.regid = RG_D.regid " +
	                 "JOIN region RG_A ON A.regid = RG_A.regid " +
	                 "WHERE RG_D.regid = ? AND RG_A.regid = ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, deprRegId);
	        pstmt.setString(2, arvlRegId);

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            duration = rs.getInt("duration");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
	    }

	    return duration;
	}
}
