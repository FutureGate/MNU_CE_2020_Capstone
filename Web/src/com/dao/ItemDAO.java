package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.ItemDTO;
import com.dto.SaleDTO;
import com.util.DBConnector;

public class ItemDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public ItemDAO() {
		
	}
	
	public ArrayList<ItemDTO> getItemList(int shopID) {
		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		
		String sql = "select * from item_table where shop_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, shopID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemDTO item = new ItemDTO();
				
				item.setItemID(rs.getInt("item_id"));
				item.setItemName(rs.getString("item_name"));
				item.setShopID(rs.getInt("shop_id"));
				
				list.add(item);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public boolean add(int item_id, String itemName, int shop_id) {
		
		String sql = "insert into item_table values (?, ?, ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, item_id);
			pstmt.setString(2, itemName);
			pstmt.setInt(3, shop_id);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean delete(int itemID) {
		String sql = "delete from item_table where item_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, itemID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public void modify(int itemID, String itemName) {
		
		delete(saleID);
		add(saleID, userID, saleDate, prodCode, prodName, saleCount);
		
	}
}
