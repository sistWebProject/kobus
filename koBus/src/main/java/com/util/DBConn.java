package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// 싱글톤 (Singleton)
public class DBConn {

	private static Connection conn = null;

	private DBConn() {

	}

	public static synchronized Connection getConnection() {
		if (conn == null) {

			String className = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "KOBUS";
			String password = "1234";

			try {
				Class.forName(className);
				conn = DriverManager.getConnection(url, user, password);

			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
	
	public static void close() {
		try {
			if (conn != null || !conn.isClosed()) {
				conn.close();				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		conn = null; // close 하고 초기화 필수!!!!!!!!!!!!
	}
	
	
	public static synchronized Connection getConnection(String url, String user, String password) {
		if (conn == null) {

			String className = "oracle.jdbc.driver.OracleDriver";

			try {
				Class.forName(className);
				conn = DriverManager.getConnection(url, user, password);

			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
}
