package com.command.item;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;

public class ItemDeleteCommand implements Command{

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;

		ItemDAO dao = new ItemDAO();
		
		
		// Request로부터 파라미터 받기
		String itemID = req.getParameter("itemID");
		
		
		// Validation (예외처리)
		if(itemID == null || itemID.equals("")) {
			System.out.println("validation error");
			res.getWriter().write("");
			
		} else {
			try {
				itemID = URLDecoder.decode(itemID, "UTF-8");
				
				dao.delete(Integer.parseInt(itemID));
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}

}
