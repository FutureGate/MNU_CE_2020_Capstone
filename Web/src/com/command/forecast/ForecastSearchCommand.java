package com.command.forecast;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ForecastDAO;
import com.dao.ItemDAO;
import com.dto.ForecastDTO;
import com.dto.ItemDTO;

public class ForecastSearchCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		ArrayList<ForecastDTO> forecastList = null;
		ForecastDAO dao = new ForecastDAO();
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		String itemID = req.getParameter("itemID");
	
		// Validation (예외처리)
		if(shopID == null || shopID.equals("") || itemID == null || itemID.equals("")) {
			res.getWriter().write("");
			
		} else {
			try {
				String baseDate = dao.getRecentBaseDate(shopID, itemID);
				
				forecastList = dao.getForecastList(shopID, itemID, baseDate);
				
				// JSON 으로 변환
				String json = convertToJson(forecastList);
				
				res.getWriter().write(json);
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
			
			
		}

		return new ForwardingAction(isRedirect, viewPage);
	}
	
	private String convertToJson(ArrayList<ForecastDTO> list) {
		StringBuffer result = new StringBuffer("");
		
		result.append("{\"result\":[");
		
		if(list.size() == 0) return "";
		
		for(int i=0; i<list.size(); i++) {
			int id = i+1;
			
			result.append("{\"id\": \"" + id + "\",");
			result.append("\"saleDate\": \"" + list.get(i).getSaleDate() + "\",");
			result.append("\"saleCount\": \"" + list.get(i).getSaleCount() + "\"}");
			
			if(i != list.size() -1) result.append(",");
		}
		
		result.append("]}");
		
		return result.toString();
	}
	
}
