package com.command.user;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.UserDAO;
import com.dto.UserDTO;

public class UserLoginCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		boolean isRedirect = true;
		String viewPage = null;
		String error = null;
		
		UserDAO dao = new UserDAO();
		
		String userID = req.getParameter("userID");
		String password = req.getParameter("password");
		
		try {
			
			if(dao.login(userID, password)) {
				viewPage = "productMonitoring.do";
				
				UserDTO user = dao.getUser(userID);
				
				req.getSession().setAttribute("user", user);
			} else {
				viewPage = "login.do";
				error = "아이디 혹은 비밀번호가 일치하지 않습니다.";
				
				req.getSession().setAttribute("error", error);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return new ForwardingAction(isRedirect, viewPage);
	}

}
