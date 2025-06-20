package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
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
		
		String sql = " SELECT  "
		        + "    R.resID, "
		        + "    COUNT(S.seatNO) AS totalCount, "  // 인원 수 (좌석 수)
		        + "    LISTAGG(S.seatNO, ',') WITHIN GROUP (ORDER BY S.seatNO) AS seatNO,  "
		        + "    R.rideDate,  "
		        + "    R.resvDate,  "
		        + "    R.resvStatus,  "
		        + "    R.resvType,  "
		        + "    R.qrCode,  "
		        + "    RGD.regName AS deprRegName,  "
		        + "    RGA.regName AS arrRegName,  "
		        + "    C.comName, "
		        + "    B.busGrade,  "
		        + "    BS.durMin,  "
		        + "    PM.amount,  "
		        + "    P.payType  "
		        + " FROM reservation R "
		        + " JOIN ReservedSeats RS ON R.resID = RS.resID "
		        + " JOIN seat S ON RS.seatID = S.seatID "
		        + " JOIN busSchedule BS ON R.bshID = BS.bshID "
		        + " JOIN kobusUser KU ON R.kusID = KU.kusID "
		        + " JOIN bus B ON BS.busID = B.busID "
		        + " JOIN company C ON B.comID = C.comID "
		        + " JOIN route RT ON BS.rouID = RT.rouID "
		        + " JOIN departure D ON RT.depID = D.depID "
		        + " JOIN arrival A ON RT.arrID = A.arrID "
		        + " JOIN region RGD ON D.regID = RGD.regID "
		        + " JOIN region RGA ON A.regID = RGA.regID "
		        + " JOIN paymentmethod PM ON R.resID = PM.resID "
		        + " JOIN payment P ON PM.PMTID = P.PMTID "
		        + " WHERE KU.id = ? "
		        + " GROUP BY R.resID, R.rideDate, R.resvDate, R.resvStatus, R.resvType, R.qrCode, "
		        + "          RGD.regName, RGA.regName, C.comName, B.busGrade, BS.durMin, PM.amount, P.payType "
		        + " ORDER BY R.resvDate DESC ";

		
		System.out.println(sql);
		
		this.pstmt = this.conn.prepareStatement(sql);
		
		this.pstmt.setString(1, loginId);
		this.rs = pstmt.executeQuery();
		
		System.out.println(sql);
		
		 while (rs.next()) {
		        String resID = rs.getString("resID");
		        int totalCount = rs.getInt("totalCount"); // 좌석 수
		        String seatNo = rs.getString("seatNO"); // "1,2,3" 등
		        LocalDateTime rideDate = rs.getTimestamp("rideDate").toLocalDateTime();
		        LocalDateTime resvDate = rs.getTimestamp("resvDate").toLocalDateTime();
		        String resvStatus = rs.getString("resvStatus");
		        String resvType = rs.getString("resvType");
		        String qrCode = rs.getString("qrCode");
		        String deprRegName = rs.getString("deprRegName");
		        String arrRegName = rs.getString("arrRegName");
		        String comName = rs.getString("comName");
		        String busGrade = rs.getString("busGrade");
		        int durMin = rs.getInt("durMin");
		        int amount = rs.getInt("amount");
		        String payType = rs.getString("payType");

		        this.dto = new ResvDTO().builder()
		                .resId(resID)
		                .totalCount(totalCount)
		                .seatNo(seatNo)
		                .rideDate(rideDate)
		                .resvDate(resvDate)
		                .resvStatus(resvStatus)
		                .resvType(resvType)
		                .qrCode(qrCode)
		                .deprRegName(deprRegName)
		                .arrRegName(arrRegName)
		                .comName(comName)
		                .busGrade(busGrade)
		                .durMin(durMin)
		                .amount(amount)
		                .payType(payType)
		                .build();

		        resvList.add(dto);
		    }

		
		return resvList;
	}
	
	

}
