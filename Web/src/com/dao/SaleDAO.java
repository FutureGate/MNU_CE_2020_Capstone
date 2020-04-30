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
	
	public ArrayList<SaleDTO> getSaleList(String userID, String prodCode) {
		ArrayList<SaleDTO> list = new ArrayList<SaleDTO>();
		
		String sql = "select * from sale_table where user_id = ? and prod_code = ? order by sale_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userID);
			pstmt.setString(2, prodCode);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleDTO sale = new SaleDTO();
				
				sale.setSaleID(rs.getInt("sale_id"));
				sale.setUserID(rs.getString("user_id"));
				sale.setSaleDate(rs.getString("sale_date"));
				sale.setProdCode(rs.getString("prod_code"));
				sale.setProdName(rs.getString("prod_name"));
				sale.setSaleCount(rs.getInt("sale_count"));
				
				list.add(sale);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public boolean add(String saleID, String userID, String saleDate, String prodCode, String prodName, String saleCount) {
		
		String sql = "insert into sale_table values (?, ?, ?, ?, ?, ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, saleID);
			pstmt.setString(2, userID);
			pstmt.setString(3, saleDate);
			pstmt.setString(4, prodCode);
			pstmt.setString(5, prodName);
			pstmt.setString(6, saleCount);
			
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
	
	public void modify(String saleID, String userID, String saleDate, String prodCode, String prodName,
			String saleCount) {
		
		delete(saleID);
		add(saleID, userID, saleDate, prodCode, prodName, saleCount);
		
	}
}
