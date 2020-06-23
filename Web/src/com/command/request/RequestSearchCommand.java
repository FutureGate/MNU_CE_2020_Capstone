package com.command.request;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;
import com.dao.RequestDAO;
import com.dto.RequestDTO;
import com.dto.SaleDTO;

public class RequestSearchCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		RequestDTO request = null;
		RequestDAO dao = new RequestDAO();
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		
		// Validation (예외처리)
		if(shopID == null || shopID.equals("")) {
			res.getWriter().write("");
			
		} else {
			try {
				request = dao.getRecentRequest(shopID);
				
				// JSON 으로 변환
				String json = convertToJson(request);
				
				res.getWriter().write(json);
				
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
			
		}

		return new ForwardingAction(isRedirect, viewPage);
	}
	
	private String convertToJson(RequestDTO request) {
		StringBuffer result = new StringBuffer("");
		
		ItemDAO itemDAO = new ItemDAO();
		
		String itemName = itemDAO.getItem(request.getItemID()).getItemName();
		
		if(request == null)
			return "";
		
		result.append("{\"result\":[");
		result.append("{\"requestDate\": \"" + request.getRequestDate() + "\",");
		result.append("\"itemID\": \"" + request.getItemID() + "\",");
		result.append("\"itemName\": \"" + itemName + "\",");
		result.append("\"state\": \"" + request.getState() + "\",");
		result.append("\"trained\": \"" + request.getTrained() + "\"}");
		result.append("]}");
		
		return result.toString();
	}
	
}
