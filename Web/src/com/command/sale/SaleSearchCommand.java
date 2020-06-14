package com.command.sale;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;
import com.dao.SaleDAO;
import com.dto.SaleDTO;

public class SaleSearchCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		ArrayList<SaleDTO> saleList = null;
		SaleDAO dao = new SaleDAO();
		
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		String itemName = req.getParameter("itemName");
		
		// Validation (예외처리)
		if(shopID == null || shopID.equals("")) {
			res.getWriter().write("");
			
		} else {
			
			
			try {
				shopID = URLDecoder.decode(shopID, "UTF-8");
				
				
				if(itemName == null || itemName.equals("")) {
					
					
					// DAO 사용, 검색 실행
					saleList = dao.getSaleList(shopID);
					
				} else {
					
					itemName = URLDecoder.decode(itemName, "UTF-8");
					
					saleList = dao.getSaleListByItemName(shopID, itemName);
					
				}
				
				
				
				// JSON 으로 변환
				String json = convertToJson(saleList);
				
				res.getWriter().write(json);
				
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
			
			
		}

		return new ForwardingAction(isRedirect, viewPage);
	}
	
	private String convertToJson(ArrayList<SaleDTO> list) {
		StringBuffer result = new StringBuffer("");
		ItemDAO itemDAO = new ItemDAO();
		
		result.append("{\"result\":[");
		
		if(list.size() == 0) return "";
		
		for(int i=0; i<list.size(); i++) {
			int id = i+1;
			
			result.append("{\"id\": \"" + id + "\",");
			result.append("\"saleID\": \"" + list.get(i).getSaleID() + "\",");
			result.append("\"saleDate\": \"" + list.get(i).getSaleDate() + "\",");
			result.append("\"itemID\": \"" + list.get(i).getItemID() + "\",");
			result.append("\"itemName\": \"" + itemDAO.getItem(list.get(i).getItemID()).getItemName() + "\",");
			result.append("\"saleCount\": \"" + list.get(i).getSaleCount() + "\"}");
			
			if(i != list.size() -1) result.append(",");
		}
		
		result.append("]}");
		
		return result.toString();
	}
	
}
