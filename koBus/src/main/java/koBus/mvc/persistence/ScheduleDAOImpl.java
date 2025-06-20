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
		//25.06.14
		//List<RegionDTO> list = new ArrayList<>();
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
				+ "	BS.DURMIN,	"	
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

		// prepareStatement는 sql이 완성된 후에 실행
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, deprId);
		pstmt.setString(2, arrId);
		pstmt.setString(3, deprDtm);

		if (!busClsCd.equals("전체")) {
		    pstmt.setString(4, busClsCd);
		}
		
		rs = pstmt.executeQuery();
		
		System.out.println(sql);
		
		LocalDateTime departureDate;
		String comName;            
		String busGrade;           
		int adultFare;           
		int stuFare;             
		int childFare;           
		LocalDateTime arrivalDate;  
		int durMin; 			
		String bshId; 			
		String busId; 			
		int remainSeats; 		
	    int busSeats;  
	    
	    	
	    	while (rs.next()) {
	    		departureDate = rs.getTimestamp("departureDate").toLocalDateTime();	
				comName = rs.getString("comName");
				busGrade = rs.getString("busGrade");
				adultFare = rs.getInt("adultFare");
				stuFare = rs.getInt("stuFare");
				childFare = rs.getInt("childFare");
				arrivalDate = rs.getTimestamp("arrivalDate").toLocalDateTime();	
				durMin = rs.getInt("durMin");
				bshId = rs.getString("bshId");
				busId = rs.getString("busId");
				remainSeats = rs.getInt("remainSeats");
				busSeats = rs.getInt("busSeats");
				
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


}
