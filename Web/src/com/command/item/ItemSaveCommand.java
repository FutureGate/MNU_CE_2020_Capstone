package com.command.item;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;
import com.dao.SaleDAO;

public class ItemSaveCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;

		ItemDAO dao = new ItemDAO();
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		String itemID = req.getParameter("itemID");
		String itemName = req.getParameter("itemName");
		
		// Validation (예외처리)
		if(shopID == null || shopID.equals("") || itemID == null || itemID.equals("") || itemName == null || itemName.equals("")) {
			System.out.println("validation error");
			res.getWriter().write("");
			
		} else {
			try {
				shopID = URLDecoder.decode(shopID, "UTF-8");
				itemID = URLDecoder.decode(itemID, "UTF-8");
				itemName = URLDecoder.decode(itemName, "UTF-8");
				
				if(itemID.equals("0")) {
					dao.add(0, itemName, Integer.parseInt(shopID));
				} else {
					dao.modify(Integer.parseInt(itemID), itemName);
				}
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
