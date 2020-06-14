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
		String saleDate = req.getParameter("saleDate");
		String shopID = req.getParameter("shopID");
		String itemID = req.getParameter("itemID");
		String saleCount = req.getParameter("saleCount");
		
		System.out.println(saleID + ":" + saleDate + ":" + shopID + ":" + itemID + ":" + saleCount);
		
		// Validation (예외처리)
		if(saleID == null || saleID.equals("") || saleDate == null || saleDate.equals("") || shopID == null || shopID.equals("") || itemID == null || itemID.equals("") || saleCount == null || saleCount.equals("")) {
			System.out.println("validation error");
			res.getWriter().write("");
			
			res.sendError(566, "정보를 모두 입력해 주세요");
			
		} else {
			try {
				saleID = URLDecoder.decode(saleID, "UTF-8");
				saleDate = URLDecoder.decode(saleDate, "UTF-8");
				shopID = URLDecoder.decode(shopID, "UTF-8");
				itemID = URLDecoder.decode(itemID, "UTF-8");
				saleCount = URLDecoder.decode(saleCount, "UTF-8");
				
				if(saleID.equals("0")) {
					dao.add("0", saleDate, shopID, itemID, saleCount);
				} else {
					dao.modify(saleID, saleDate, itemID, saleCount);
				}
				
			} catch (Exception e) {
				
				res.getWriter().write("");
			}
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
