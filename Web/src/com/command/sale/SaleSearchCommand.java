package com.command.sale;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
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
		String userID = req.getParameter("userID");
		String prodCode = req.getParameter("prodCode");
		
		
	
		// Validation (예외처리)
		if(userID == null || userID.equals("") || prodCode == null || prodCode.equals("")) {
			res.getWriter().write("");
			
		} else {
			
			
			try {
				userID = URLDecoder.decode(userID, "UTF-8");
				prodCode = URLDecoder.decode(prodCode, "UTF-8");
				
				// DAO 사용, 검색 실행
				saleList = dao.getSaleList(userID, prodCode);
				
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
		
		result.append("{\"result\":[");
		
		if(list.size() == 0) return "";
		
		for(int i=0; i<list.size(); i++) {
			int id = i+1;
			
			result.append("{\"id\": \"" + id + "\",");
			result.append("\"saleID\": \"" + list.get(i).getSaleID() + "\",");
			result.append("\"saleDate\": \"" + list.get(i).getSaleDate() + "\",");
			result.append("\"prodCode\": \"" + list.get(i).getProdCode() + "\",");
			result.append("\"prodName\": \"" + list.get(i).getProdName() + "\",");
			result.append("\"saleCount\": \"" + list.get(i).getSaleCount() + "\"}");
			
			if(i != list.size() -1) result.append(",");
		}
		
		result.append("]}");
		
		return result.toString();
	}
	
}
