package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.SalesDTO;
import com.util.DBConnector;

public class SalesDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public SalesDAO() {
		
	}
	
	public ArrayList<SalesDTO> getSalesList(String userID) {
		ArrayList<SalesDTO> list = new ArrayList<SalesDTO>();
		
		String sql = "select * from sales_table where user_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(0, userID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SalesDTO sales = new SalesDTO();
				
				sales.setUserID(rs.getString("user_id"));
				sales.setSaleDate(rs.getString("sale_date"));
				sales.setProdCode(rs.getString("prod_code"));
				sales.setProdName(rs.getString("prod_name"));
				sales.setSaleCount(rs.getInt("sale_count"));
				
				list.add(sales);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
