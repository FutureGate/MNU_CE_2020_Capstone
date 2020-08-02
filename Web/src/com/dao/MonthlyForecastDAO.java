package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.ForecastDTO;
import com.dto.MonthlyForecastDTO;
import com.util.DBConnector;

public class MonthlyForecastDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public MonthlyForecastDAO() {
		
	}
	
	public String getRecentBaseDate(String shopID, String itemID) {
		
		String sql = "select * from monthly_forecast_table where shop_id = ? and item_id = ? order by base_date desc";
		
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
	
	public ArrayList<MonthlyForecastDTO> getForecastList(String shopID, String itemID, String baseDate) {
		
		ArrayList<MonthlyForecastDTO> list = null;
		
		String sql = "select * from monthly_forecast_table where shop_id = ? and item_id = ? and base_date = ? order by sale_date";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, shopID);
			pstmt.setString(2, itemID);
			pstmt.setString(3, baseDate);
			
			ResultSet rs = pstmt.executeQuery();
			
			list = new ArrayList<MonthlyForecastDTO>();
			
			while(rs.next()) {
				MonthlyForecastDTO forecast = new MonthlyForecastDTO();
				
				forecast.setForecastID(rs.getInt("forecast_id"));
				forecast.setBaseDate(baseDate);
				forecast.setSaleDate(rs.getString("sale_date"));
				forecast.setSeason(rs.getString("season"));
				forecast.setShopID(Integer.parseInt(shopID));
				forecast.setItemID(Integer.parseInt(itemID));
				forecast.setSaleCount(rs.getFloat("sale_count"));
				
				list.add(forecast);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
