package koBus.mvc.persistence;

import java.sql.SQLException;

// 전화번로 or id 받아서 인증번호 받거나 DB 검색으로 아이디/비밀번호 조회기능 함수 
public interface CertificationCodeDAO {
	
	// 전화번호 입력해서 인증번호받기
	String telCertificationNum(String inputNumber, int randomNumber) throws SQLException; 

}
