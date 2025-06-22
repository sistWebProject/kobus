package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import koBus.mvc.domain.ResvDTO;

public class ResvDAOImpl implements ResvDAO {
	
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ResvDTO dto = null;
	
	public ResvDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public Connection getConn() {
		return conn;
	}
	
	public void setConn(Connection conn) {
		this.conn = conn;
	}

	@Override
	public List<ResvDTO> searchResvList(String loginId) throws SQLException {
		
		List<ResvDTO> resvList = new ArrayList<>();
		
		System.out.println("loginId " + loginId);
		
		String sql = 
			    "SELECT  " +
			    "    R.resID, " +
			    "    COUNT(S.seatNO) AS totalCount,  " +  // 인원 수 (좌석 수)
			    "    LISTAGG(S.seatNO, ',') WITHIN GROUP (ORDER BY S.seatNO) AS seatNO,  " +
			    "    COUNT(CASE WHEN RS.seatType = 'ADULT' THEN 1 END) AS aduCount,  " +  // 일반 좌석 수
			    "    COUNT(CASE WHEN RS.seatType = 'STUDENT' THEN 1 END) AS stuCount,  " +  // 학생 좌석 수
			    "    COUNT(CASE WHEN RS.seatType = 'CHILD' THEN 1 END) AS chdCount,  " +  // 아이 좌석 수
			    "    R.rideDate,  " +
			    "    R.resvDate,  " +
			    "    R.resvStatus,  " +
			    "    R.resvType,  " +
			    "    R.qrCode,  " +
			    "    RGD.regId AS deprRegCode,  " +
			    "    RGD.regName AS deprRegName,  " +
			    "    RGA.regId AS arrRegCode,  " +
			    "    RGA.regName AS arrRegName,  " +
			    "    C.comName, " +
			    "    B.busGrade,  " +
			    "    BS.durMin,  " +
			    "    PM.amount,  " +
			    "    P.payType  " +
			    " FROM reservation R " +
			    " JOIN ReservedSeats RS ON R.resID = RS.resID " +
			    " JOIN seat S ON RS.seatID = S.seatID " +
			    " JOIN busSchedule BS ON R.bshID = BS.bshID " +
			    " JOIN kobusUser KU ON R.kusID = KU.kusID " +
			    " JOIN bus B ON BS.busID = B.busID " +
			    " JOIN company C ON B.comID = C.comID " +
			    " JOIN route RT ON BS.rouID = RT.rouID " +
			    " JOIN departure D ON RT.depID = D.depID " +
			    " JOIN arrival A ON RT.arrID = A.arrID " +
			    " JOIN region RGD ON D.regID = RGD.regID " +
			    " JOIN region RGA ON A.regID = RGA.regID " +
			    " JOIN paymentmethod PM ON R.resID = PM.resID " +
			    " JOIN payment P ON PM.PMTID = P.PMTID " +
			    " WHERE KU.id = ? " + 
			    " GROUP BY " +
			    "    R.resID, R.rideDate, R.resvDate, R.resvStatus, R.resvType, R.qrCode, " +
			    "    RGD.regId, RGD.regName, RGA.regId, RGA.regName, " +
			    "    C.comName, B.busGrade, BS.durMin, PM.amount, P.payType " +
			    " ORDER BY R.resvDate DESC";


		
		this.pstmt = this.conn.prepareStatement(sql);
		
		this.pstmt.setString(1, loginId);
		this.rs = pstmt.executeQuery();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd HHmmss");

		
		 while (rs.next()) {
		        String resID = rs.getString("resID");
		        int totalCount = rs.getInt("totalCount"); // 좌석 수
		        String seatNo = rs.getString("seatNO"); // "1,2,3" 등
		        int aduCount = rs.getInt("aduCount"); // "1,2,3" 등
		        int stuCount = rs.getInt("stuCount"); // "1,2,3" 등
		        int chdCount = rs.getInt("chdCount"); // "1,2,3" 등
		        LocalDateTime rideDate = rs.getTimestamp("rideDate").toLocalDateTime();
		        String rideDateStr = rideDate.format(formatter);
		        LocalDateTime resvDate = rs.getTimestamp("resvDate").toLocalDateTime();
		        String resvDateStr = resvDate.format(formatter);
		        String resvStatus = rs.getString("resvStatus");
		        String resvType = rs.getString("resvType");
		        String qrCode = rs.getString("qrCode");
		        String deprRegCode = rs.getString("deprRegCode");
		        String deprRegName = rs.getString("deprRegName");
		        String arrRegCode = rs.getString("arrRegCode");
		        String arrRegName = rs.getString("arrRegName");
		        String comName = rs.getString("comName");
		        String busGrade = rs.getString("busGrade");
		        int durMin = rs.getInt("durMin");
		        int amount = rs.getInt("amount");
		        int totalcount = rs.getInt("totalCount");
		        String payType = rs.getString("payType");

		        this.dto = new ResvDTO().builder()
		                .resId(resID)
		                .totalCount(totalCount)
		                .seatNo(seatNo)
		                .aduCount(aduCount)
		                .stuCount(stuCount)
		                .chdCount(chdCount)
		                .rideDateStr(rideDateStr)
		                .resvDateStr(resvDateStr)
		                .resvStatus(resvStatus)
		                .resvType(resvType)
		                .qrCode(qrCode)
		                .deprRegCode(deprRegCode)
		                .deprRegName(deprRegName)
		                .arrRegCode(arrRegCode)
		                .arrRegName(arrRegName)
		                .comName(comName)
		                .busGrade(busGrade)
		                .durMin(durMin)
		                .amount(amount)
		                .totalCount(totalcount)
		                .payType(payType)
		                .build();

		        resvList.add(dto);
		    }

		
		return resvList;
	}
	
	

}
