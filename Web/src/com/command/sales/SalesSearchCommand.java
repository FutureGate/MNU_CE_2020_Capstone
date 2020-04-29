package com.command.sales;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.SalesDAO;
import com.dto.SalesDTO;

public class SalesSearchCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) {
		boolean isRedirect = true;
		String viewPage = null;
		
		// request 로부터 인자 받기
		String userID = req.getParameter("userID");
		String prodCode = req.getParameter("prodCode");
		
		ArrayList<SalesDTO> salesList = null;
		
		SalesDAO dao = new SalesDAO();
		
		if((userID != null) && (prodCode != null)) {
			salesList = dao.getSalesList(userID);
		}
		
		req.setAttribute("salesList", salesList);
		
		return new ForwardingAction(isRedirect, viewPage);
	}
	
}
