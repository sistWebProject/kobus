package koBus.mvc.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import koBus.mvc.domain.ItemPurDTO;
import koBus.mvc.domain.ResvDTO;

public class ItemPurDAOImpl implements ItemPurDAO{

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ItemPurDTO dto = null;
	
	public ItemPurDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public Connection getConn() {
		return conn;
	}
	
	public void setConn(Connection conn) {
		this.conn = conn;
	}
	
	// 정기권 결제정보 테이블 내역 가져오기
	@Override
	public List<ItemPurDTO> itemPopPurList(String loginId) throws SQLException {
		// 정기권 구매내역 리스트 나타내기
		List<ItemPurDTO> popItemList = new ArrayList<ItemPurDTO>();
		
		String sql = "SELECT pay_status, startdate, amount FROM PAYMENT py "
				+ "join kobususer ku on py.kusid = ku.kusid "
				+ "WHERE ku.id = ? ";
		
		this.pstmt = this.conn.prepareStatement(sql);
		
		this.pstmt.setString(1, loginId);
		this.rs = pstmt.executeQuery();
		
		while (rs.next()) {
			String couponName = "정기권";
			String payStatus = rs.getString("pay_status");
			Date startDate = rs.getDate("startdate");
			int amount = rs.getInt("amount");
			
			dto = ItemPurDTO.builder()
								.couponName(couponName)
								.payStatus(payStatus)
								.startDate(startDate)
								.amount(amount)
								.build();
			popItemList.add(dto);
		}
		
		return popItemList; // 프리패스 결제내역이 담겨있는값 보내주기
	}
	
	// 프리패스 결제정보 테이블 내역 가져오기
	@Override
	public List<ItemPurDTO> itemFreePurList(String loginId) throws SQLException {
		// 프리패스 구매내역 리스트 나타내기
		List<ItemPurDTO> freeItemList = new ArrayList<ItemPurDTO>();
		
		String sql = "SELECT pay_status, startdate, amount FROM FREE_PASS_PAYMENT frppy "
				+ "join kobususer ku on frppy.kusid = ku.kusid "
				+ "WHERE ku.id = ? ";
		
		this.pstmt = this.conn.prepareStatement(sql);
		
		this.pstmt.setString(1, loginId);
		this.rs = pstmt.executeQuery();
		
		while (rs.next()) {
			String couponName = "프리패스";
			String payStatus = rs.getString("pay_status");
			Date startDate = rs.getDate("startdate");
			int amount = rs.getInt("amount");
			
			dto = ItemPurDTO.builder()
								.couponName(couponName)
								.payStatus(payStatus)
								.startDate(startDate)
								.amount(amount)
								.build();
			freeItemList.add(dto);
		}
		
		return freeItemList;
	}
	
	
}
