package koBus.mvc.persistence;

import java.sql.SQLException;

public interface LogonDAO {
	
	int logonCheck(String inputId, String inputPasswd) throws SQLException; 
	
	String idDupCheck(String inputId) throws SQLException;

	String getKusIDById(String id)throws SQLException ;
}
