package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dto.UserDTO;
import com.util.DBConnector;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public UserDAO() {
		
	}
	
	public UserDTO getUser(String userID) {
		UserDTO user = null;
		
		String sql = "select * from USER_TABLE where user_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				user = new UserDTO();
				
				user.setUserID(rs.getString("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setShopID(rs.getInt("shop_id"));
				user.setRegisteredDate(rs.getString("registered_date"));
				user.setUserLevel(rs.getInt("user_level"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public boolean userNameCheck(String userName) {
		UserDTO user = null;
		
		String sql = "select * from USER_TABLE where user_name = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userName);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean login(String userID, String password) {
		
		try {
			UserDTO user = getUser(userID);
			
			if(user == null) {
				return false;
			}
			
			if(user.getPassword().equals(password)) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean add(String userID, String userName, String password, String shopID, String registeredDate, String userLevel) {
		
		String sql = "insert into user_table values (?, ?, ?, ?, ?, ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userID);
			pstmt.setString(2, userName);
			pstmt.setString(3, password);
			pstmt.setString(4, shopID);
			pstmt.setString(5, registeredDate);
			pstmt.setString(6, userLevel);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean delete(String userID) {
		String sql = "delete from user_table where user_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean modify(String userID, String userName, String password, String shopID, String registeredDate, String userLevel) {
		
		String sql = "update user_table set user_name = ?, password = ? where user_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userName);
			pstmt.setString(2, password);
			pstmt.setString(3, userID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
}
