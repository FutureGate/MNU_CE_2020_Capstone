package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	private static DBConnector instance = new DBConnector();
	
	private final String driver = "oracle.jdbc.driver.OracleDriver";
	private final String url = "jdbc:oracle:thin:@114.70.93.123:1521:orcl";
	private final String user = "root";
	private final String password = "zoqtmxhs";
	
	private Connection connection = null;
	
	public DBConnector() {
		
	}
	
	public static DBConnector getInstance() {
		if(instance == null) {
			instance = new DBConnector();
		}
		
		return instance;
	}
	
	public Connection getConnector() {
		try {
			Class.forName(driver);

			connection = DriverManager.getConnection(url, user, password);

		} catch (ClassNotFoundException e) {
			
			System.out.println("jdbc driver 로드 실패");
			
		} catch (SQLException e) {
			
			System.out.println("오라클 데이터베이스 연결 실패");
		}
		
		return connection;

	}
}
