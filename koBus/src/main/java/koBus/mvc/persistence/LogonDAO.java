package koBus.mvc.persistence;

import java.sql.SQLException;

public interface LogonDAO {
	
	// 아이디 비밀번호 체크 함수
	int logonCheck(String inputId, String inputPasswd) throws SQLException; 
	
	// 아이디 중복 함수
	String idDupCheck(String inputId) throws SQLException;
	
	// 아이디에 해당하는 식별번호(kusid)값 가져오기
	String getKusIDById(String id)throws SQLException ;
	
	// 비밀번호 해쉬화하는 함수
	String encrypt(String inputPasswd) throws SQLException; 
}
