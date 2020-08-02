package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	private static DBConnector instance = new DBConnector();
	
	private final String driver = "com.mysql.cj.jdbc.Driver";
	private final String url = "jdbc:mysql://127.0.0.1:11081/demand_prediction?serverTimezone=UTC&characterEncoding=utf8";
	private final String user = "capstone";
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
			
			System.out.println("데이터베이스 연결 실패");
		}
		
		return connection;

	}
}
