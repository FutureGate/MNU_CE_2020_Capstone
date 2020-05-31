package com.command.user;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ShopDAO;
import com.dto.ShopDTO;

public class UserSettingShopSaveCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		boolean isRedirect = true;
		String viewPage = "userSetting.do";
		String error = null;
		String message = null;

		ShopDAO dao = new ShopDAO();
		
		// Request로부터 파라미터 받기
		String shopID = req.getParameter("shopID");
		String shopName = req.getParameter("shopName");
		String contact = req.getParameter("contact");
		String email = req.getParameter("email");
		
		try {

			dao.modify(Integer.parseInt(shopID), shopName, contact, email);
			ShopDTO shop = dao.getShop(Integer.parseInt(shopID));
			
			message = "판매점 정보 수정이 완료 되었습니다.";

			req.getSession().setAttribute("shop", shop);
			
		} catch (Exception e) {
			res.getWriter().write("");
		}
		
		if(error != null) {
			req.getSession().setAttribute("error", error);
		}
		
		if(message != null) {
			req.getSession().setAttribute("message", message);
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
