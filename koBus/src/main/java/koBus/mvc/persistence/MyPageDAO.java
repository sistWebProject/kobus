package koBus.mvc.persistence;

import java.sql.SQLException;

public interface MyPageDAO {

	// 예매내역 개수 가져오는 함수
	int reservationCount(String auth) throws SQLException;
	
	// 프리패스/정기권 개수 가져오는 함수
	int couponCount(String auth) throws SQLException;
	
	// 전화번호 가져오는 함수
	String getTelNum(String auth) throws SQLException;
	
	// 비밀번호 가져오는 함수
	String getOldPw(String auth) throws SQLException;
	
	int update(String auth, String changeThings) throws SQLException;
}
