package com.command.item;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;
import com.dao.SaleDAO;
import com.dto.ItemDTO;
import com.dto.SaleDTO;

public class ItemSearchCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		ArrayList<ItemDTO> itemList = null;
		ItemDAO dao = new ItemDAO();
		
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		String itemID = req.getParameter("itemID");
		String itemName = req.getParameter("itemName");
	
		// Validation (예외처리)
		if(shopID == null || shopID.equals("") || itemID == null || itemID.equals("")) {
			res.getWriter().write("");
			
		} else {
			
			
			try {
				shopID = URLDecoder.decode(shopID, "UTF-8");
				itemID = URLDecoder.decode(itemID, "UTF-8");

				if(itemName == null || itemName.equals("")) {
					// 검색조건이 없을 경우, 전체 조회 실행
					
					System.out.println(itemID);
					itemList = dao.getItemList(Integer.parseInt(shopID));
				} else {
					itemName = URLDecoder.decode(itemName, "UTF-8");
					
					System.out.println(itemName);
					
					itemList = dao.getItemListByItemName(Integer.parseInt(shopID), itemName);
				}
				
				
				// JSON 으로 변환
				String json = convertToJson(itemList);
				
				System.out.println(json);
				
				res.getWriter().write(json);
				
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
			
			
		}

		return new ForwardingAction(isRedirect, viewPage);
	}
	
	private String convertToJson(ArrayList<ItemDTO> list) {
		StringBuffer result = new StringBuffer("");
		
		result.append("{\"result\":[");
		
		if(list.size() == 0) return "";
		
		for(int i=0; i<list.size(); i++) {
			int id = i+1;
			
			result.append("{\"id\": \"" + id + "\",");
			result.append("\"itemID\": \"" + list.get(i).getItemID() + "\",");
			result.append("\"itemName\": \"" + list.get(i).getItemName() + "\"}");
			
			if(i != list.size() -1) result.append(",");
		}
		
		result.append("]}");
		
		return result.toString();
	}
	
}
