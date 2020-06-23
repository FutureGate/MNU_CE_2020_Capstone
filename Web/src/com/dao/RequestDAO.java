package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dto.RequestDTO;
import com.util.DBConnector;

public class RequestDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public RequestDAO() {
		
	}
	
	public RequestDTO getRecentRequest(String shopID) {
		
		RequestDTO request = null;
		
		String sql = "select * from request_table where shop_id = ? order by request_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				request = new RequestDTO();
				
				request.setRequestID(rs.getInt("request_id"));
				request.setRequestDate(rs.getString("request_date"));
				request.setShopID(rs.getInt("shop_id"));
				request.setItemID(rs.getInt("item_id"));
				request.setState(rs.getString("state"));
				request.setTrained(rs.getInt("trained"));
				
				return request;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
