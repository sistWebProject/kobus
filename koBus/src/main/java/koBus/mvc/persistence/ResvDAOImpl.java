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
				+ "    S.seatNO,  "
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
				+ " JOIN busSchedule BS ON R.bshID = BS.bshID "
				+ " JOIN kobusUser KU ON R.kusID = KU.kusID "
				+ " JOIN seat S ON R.seatID = S.seatID "
				+ " JOIN bus B ON BS.busID = B.busID "
				+ " JOIN company C ON B.comID = C.comID "
				+ " JOIN route RT ON BS.rouID = RT.rouID "
				+ " JOIN departure D ON RT.depID = D.depID "
				+ " JOIN arrival A ON RT.arrID = A.arrID "
				+ " JOIN region RGD ON D.regID = RGD.regID "
				+ " JOIN region RGA ON A.regID = RGA.regID "
				+ " JOIN paymentmethod PM ON R.resID = PM.resID "
				+ " JOIN payment P ON PM.PMTID = P.PMTID "
				+ " where KU.id = ? "
				+ " ORDER BY R.resvDate DESC ";
		
		System.out.println(sql);
		
		this.pstmt = this.conn.prepareStatement(sql);
		
		this.pstmt.setString(1, loginId);
		this.rs = pstmt.executeQuery();
		
		System.out.println(sql);
		
		String resID;         // 예매번호
		String seatNo;        // 좌석번호
		LocalDateTime rideDate;   // 탑승일
		LocalDateTime resvDate;   // 예약일
		String resvStatus;    // 예약 상태
		String resvType;      // 예약 경로
		String qrCode;        // QR 코드
		String deprRegName;   // 출발지명
		String arrRegName;    // 도착지명
		String comName;       // 고속사
		String busGrade;      // 버스 등급
		int durMin;
		int amount;           // 총 결제금액
		String payType;
		
		while (rs.next()) {
			resID = rs.getString("resId");
			seatNo = rs.getString("seatNo");
			rideDate = rs.getTimestamp("rideDate").toLocalDateTime();
			resvDate = rs.getTimestamp("resvDate").toLocalDateTime();
			resvStatus = rs.getString("resvStatus");
			resvType = rs.getString("resvType");
			qrCode = rs.getString("qrCode");
			deprRegName = rs.getString("deprRegName");
			arrRegName = rs.getString("arrRegName");
			comName = rs.getString("comName");
			busGrade = rs.getString("busGrade");
			durMin = rs.getInt("durMin");
			amount = rs.getInt("amount");
			payType = rs.getString("payType");
			
			
			this.dto = new ResvDTO().builder().
					resId(resID).seatNo(seatNo).rideDate(rideDate).
					resvDate(resvDate).resvStatus(resvStatus).resvType(resvType).
					qrCode(qrCode).deprRegName(deprRegName).arrRegName(arrRegName).
					comName(comName).busGrade(busGrade).durMin(durMin).amount(amount).payType(payType).build();
			
			resvList.add(dto);
			
		}

		
		return resvList;
	}
	
	

}
