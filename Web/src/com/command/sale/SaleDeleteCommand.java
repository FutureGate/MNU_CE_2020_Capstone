package com.command.sale;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.SaleDAO;

public class SaleDeleteCommand implements Command{

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;

		SaleDAO dao = new SaleDAO();
		
		
		// Request로부터 파라미터 받기
		String saleID = req.getParameter("saleID");
		
		
		// Validation (예외처리)
		if(saleID == null || saleID.equals("")) {
			System.out.println("validation error");
			res.getWriter().write("");
			
		} else {
			try {
				saleID = URLDecoder.decode(saleID, "UTF-8");
				
				dao.delete(saleID);
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}

}
