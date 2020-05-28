package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dto.ShopDTO;
import com.dto.UserDTO;
import com.util.DBConnector;

public class ShopDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public ShopDAO() {
		
	}
	
	public ShopDTO getShop(int shopID) {
		ShopDTO shop = null;
		
		String sql = "select * from shop_table where shop_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, shopID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				shop = new ShopDTO();
				
				shop.setShopID(rs.getInt("shop_id"));
				shop.setShopName(rs.getString("shop_name"));
				shop.setContact(rs.getString("contact"));
				shop.setEmail(rs.getString("email"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return shop;
	}
	
	public boolean add(String shopID, String shopName, String contact, String email) {
		
		String sql = "insert into user_table values (?, ?, ?, ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			pstmt.setString(2, shopName);
			pstmt.setString(3, contact);
			pstmt.setString(4, email);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean delete(int shopID) {
		
		String sql = "delete from shop_table where shop_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, shopID);

			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean modify(int shopID, String shopName, String contact, String email) {

		String sql = "update shop_table set shop_name = ?, contact = ?, email = ? where shop_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopName);
			pstmt.setString(2, contact);
			pstmt.setString(3, email);
			pstmt.setInt(4, shopID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
}
