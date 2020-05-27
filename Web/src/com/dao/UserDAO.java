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
}
