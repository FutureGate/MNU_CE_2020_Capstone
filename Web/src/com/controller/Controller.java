package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;

@WebServlet("*.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Controller() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doAction(request, response);
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doAction(request, response);
	}

    private void doAction(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	
    	// 인코딩  설정
    	req.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=UTF-8");
		
		
		// 포워딩 액션 설정 (이동할 페이지, 이동 방식)
		ForwardingAction forward = null;
		
		// command 객체 생성
		Command command = null;
		
		// URI 파싱
		String uri = req.getRequestURI();
		String path = req.getContextPath();
		
		PrintWriter script = res.getWriter();
		
		String page = uri.substring(path.length());
		
		/* ===========================================
		
		페이지 라우팅
		
		============================================= */ 
		
		
		// 단순 뷰
		if(page.equals("/index.do")) {
			forward = new ForwardingAction(false, "index.jsp");
		}
		
		
		// 회원 관련 페이지 및 기능
		else if (page.equals("/login.do")) {
			forward = new ForwardingAction(false, "login.jsp");
		} else if (page.equals("/loginAction.do")) {
			
		}
		
		
		// 모니터링 관련 페이지 및 기능
		else if (page.equals("/productMonitoring.do")) {
			
			// (임시)
			forward = new ForwardingAction(false, "productMonitoring.jsp");
		} else if (page.equals("/monthlyMonitoring.do")) {
			
		} else if (page.equals("/seasonalMonitoring.do")) {
			
		} else if (page.equals("/byHolidayMonitoring.do")) {
			
		}
		
		
		// 상품 관련 페이지 및 기능
		else if (page.equals("/productView.do")) {
			
		} else if (page.equals("/productManagement.do")) {
			
		} else if (page.equals("/productAddAction.do")) {
			
		}
		
		
		// 판매이력 관련 페이지 및 기능
		else if (page.equals("/salesManagement.do")) {
			forward = new ForwardingAction(false, "salesManagement.jsp");
		}
		
		
		
		
		/* ===========================================
		
		페이지 이동 처리
		
		============================================= */ 
		
		// 리다이렉트 ( 페이지 이동 )
		if(forward.isRedirect()) {
			res.sendRedirect(path + "/" + forward.getViewPage());
		
			
		// 포워딩 ( URL 은 그대로 두고, 내부 페이지만 이동 )
		} else {
			RequestDispatcher dispatcher = req.getRequestDispatcher(forward.getViewPage());
			dispatcher.forward(req, res);
		}
    }
}
