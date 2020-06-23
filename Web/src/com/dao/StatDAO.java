package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.ForecastDTO;
import com.dto.StatDTO;
import com.util.DBConnector;

public class StatDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public StatDAO() {
		
	}
	
	public String getRecentBaseDate(String shopID, String itemID) {
		
		String sql = "select * from stat_table where shop_id = ? and item_id = ? order by base_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			pstmt.setString(2, itemID);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString("base_date");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ArrayList<StatDTO> getForecastList(String shopID, String itemID, String baseDate) {
		
		ArrayList<StatDTO> list = null;
		
		String sql = "select * from stat_table where shop_id = ? and item_id = ? and base_date = ? order by stat_date";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			pstmt.setString(2, itemID);
			pstmt.setString(3, baseDate);
			
			ResultSet rs = pstmt.executeQuery();
			
			list = new ArrayList<StatDTO>();
			
			while(rs.next()) {
				StatDTO stat = new StatDTO();
				
				stat.setStatID(rs.getInt("stat_id"));
				stat.setBaseDate(baseDate);
				stat.setStatDate(rs.getString("stat_date"));
				stat.setShopID(Integer.parseInt(shopID));
				stat.setItemID(Integer.parseInt(itemID));
				stat.setSum(rs.getInt("sum"));
				stat.setAvg(rs.getFloat("avg"));
				
				list.add(stat);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
