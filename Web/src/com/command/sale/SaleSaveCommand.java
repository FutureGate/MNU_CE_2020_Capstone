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

public class SaleSaveCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;

		SaleDAO dao = new SaleDAO();
		
		
		// Request로부터 파라미터 받기
		String saleID = req.getParameter("saleID");
		String userID = req.getParameter("userID");
		String saleDate = req.getParameter("saleDate");
		String prodCode = req.getParameter("prodCode");
		String prodName = req.getParameter("prodName");
		String saleCount = req.getParameter("saleCount");
		
		// Validation (예외처리)
		if(saleID == null || saleID.equals("") || userID == null || userID.equals("") || saleDate == null || saleDate.equals("") || prodCode == null || prodCode.equals("") || prodName == null || prodName.equals("") || saleCount == null || saleCount.equals("")) {
			System.out.println("validation error");
			res.getWriter().write("");
			
		} else {
			try {
				saleID = URLDecoder.decode(saleID, "UTF-8");
				userID = URLDecoder.decode(userID, "UTF-8");
				saleDate = URLDecoder.decode(saleDate, "UTF-8");
				prodCode = URLDecoder.decode(prodCode, "UTF-8");
				prodName = URLDecoder.decode(prodName, "UTF-8");
				saleCount = URLDecoder.decode(saleCount, "UTF-8");
				
				if(saleID.equals("0")) {
					dao.add("0", userID, saleDate, prodCode, prodName, saleCount);
				} else {
					dao.modify(saleID, userID, saleDate, prodCode, prodName, saleCount);
				}
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
			
			
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
