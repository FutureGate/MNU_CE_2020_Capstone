package com.command.user;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.UserDAO;
import com.dto.UserDTO;

public class UserSettingUserPasswordSaveCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
			boolean isRedirect = true;
			String viewPage = "userSetting.do";
			String error = null;
			String message = null;

			UserDAO dao = new UserDAO();
			
			// Request로부터 파라미터 받기
			String userID = req.getParameter("userID");
			String userName = req.getParameter("userName");
			String password = req.getParameter("password");
			String password2 = req.getParameter("password2");
			String shopID = req.getParameter("shopID");
			String registeredDate = req.getParameter("registeredDate");
			String userLevel = req.getParameter("userLevel");
			
			try {

				if(password.equals(password2)) {
					
					dao.modify(userID, userName, password, shopID, registeredDate, userLevel);
					
					UserDTO user = dao.getUser(userID);
					req.getSession().setAttribute("user", user);
					
					message = "비밀번호 수정이 완료 되었습니다.";
					
				} else {
					
					error = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
				}
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
