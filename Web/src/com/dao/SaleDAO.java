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
	
	public ArrayList<SaleDTO> getSalesList(String userID, String prodCode) {
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
}
