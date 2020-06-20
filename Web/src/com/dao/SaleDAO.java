package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.SaleDTO;
import com.util.DBConnector;

public class SaleDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public SaleDAO() {
		
	}
	
	public SaleDTO getSaleByInfo(String saleDate, String shopID, String itemID) {
		String sql = "select * from sale_table where sale_date = ? and shop_id = ? and item_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleDate);
			pstmt.setString(2, shopID);
			pstmt.setString(3, itemID);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				SaleDTO sale = new SaleDTO();
				
				sale.setSaleID(rs.getInt("sale_id"));
				sale.setSaleDate(rs.getString("sale_date"));
				sale.setShopID(rs.getInt("shop_id"));
				sale.setItemID(rs.getInt("item_id"));
				sale.setSaleCount(rs.getInt("sale_count"));
				
				return sale;
			} else {
				return null;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ArrayList<SaleDTO> getSaleList(String shopID) {
		ArrayList<SaleDTO> list = new ArrayList<SaleDTO>();
		
		String sql = "select * from sale_table where shop_id = ? order by sale_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleDTO sale = new SaleDTO();
				
				sale.setSaleID(rs.getInt("sale_id"));
				sale.setSaleDate(rs.getString("sale_date"));
				sale.setShopID(rs.getInt("shop_id"));
				sale.setItemID(rs.getInt("item_id"));
				sale.setSaleCount(rs.getInt("sale_count"));
				
				list.add(sale);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public ArrayList<SaleDTO> getSaleListByItemName(String shopID, String itemName) {
		ArrayList<SaleDTO> list = new ArrayList<SaleDTO>();
		
		String sql = "select * from sale_table where shop_id = ? and item_name = ? order by sale_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			pstmt.setString(2, itemName);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleDTO sale = new SaleDTO();
				
				sale.setSaleID(rs.getInt("sale_id"));
				sale.setSaleDate(rs.getString("sale_date"));
				sale.setShopID(rs.getInt("shop_id"));
				sale.setItemID(rs.getInt("item_id"));
				sale.setSaleCount(rs.getInt("sale_count"));
				
				list.add(sale);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean add(String saleID, String saleDate, String shopID, String itemID, String saleCount) {
		
		String sql = "insert into sale_table values (?, ?, ?, ?, ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleID);
			pstmt.setString(2, saleDate);
			pstmt.setString(3, shopID);
			pstmt.setString(4, itemID);
			pstmt.setString(5, saleCount);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean delete(String saleID) {
		String sql = "delete from sale_table where sale_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean modify(String saleID, String saleDate, String itemID, String saleCount) {
		
		String sql = "update sale_table set sale_date = ?, item_id = ?, sale_count = ? where sale_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleDate);
			pstmt.setString(2, itemID);
			pstmt.setString(3, saleCount);
			pstmt.setString(4, saleID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}
	
	public boolean addSaleCount(String saleID, String saleCount) {
		
		String sql = "update sale_table set sale_count = sale_count + ? where sale_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleCount);
			pstmt.setString(2, saleID);
			
			pstmt.executeUpdate();
		
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}

}
