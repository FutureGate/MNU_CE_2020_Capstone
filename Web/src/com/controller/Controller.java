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
import com.command.forecast.ForecastSearchCommand;
import com.command.item.ItemDeleteCommand;
import com.command.item.ItemSaveCommand;
import com.command.item.ItemSearchCommand;
import com.command.request.RequestSearchCommand;
import com.command.sale.SaleDeleteCommand;
import com.command.sale.SaleFormDownloadCommand;
import com.command.sale.SaleSaveCommand;
import com.command.sale.SaleSearchCommand;
import com.command.sale.SaleUploadCommand;
import com.command.stat.StatSearchCommand;
import com.command.user.UserLoginCommand;
import com.command.user.UserSettingShopSaveCommand;
import com.command.user.UserSettingUserPasswordSaveCommand;
import com.command.user.UserSettingUserSaveCommand;
import com.dto.UserDTO;

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
		Command cmd = null;
		
		// URI 파싱
		String uri = req.getRequestURI();
		String path = req.getContextPath();
		
		PrintWriter script = res.getWriter();
		
		String page = uri.substring(path.length());
		
		/* ===========================================
		
		페이지 라우팅
		
		============================================= */ 
		
		UserDTO user = (UserDTO) req.getSession().getAttribute("user");
		
		// 단순 뷰
		if(page.equals("/index.do")) {
			forward = new ForwardingAction(false, "index.jsp");
			
		} 
		
		
		/* ===========================================
		
		회원 관련 페이지 및 기능
		
		============================================= */ 
		
		// 로그인 페이지
		else if (page.equals("/login.do")) {
			forward = new ForwardingAction(false, "login.jsp");
			
		// 회원 로그인 처리 페이지
		} else if (page.equals("/loginAction.do")) {
			cmd = new UserLoginCommand();
			
			forward = cmd.execute(req, res);
		
		// 로그아웃 페이지
		} else if (page.equals("/logoutAction.do")) {
			
			req.getSession().removeAttribute("user");
			
			forward = new ForwardingAction(true, "login.do");

			
		// 회원만 접근할 수 있도록 Private Routing. ( 이 아래로는 모두 회원 전용 페이지 ) =============================================================
		} else if(user == null || user.getUserID() == null) {
			forward = new ForwardingAction(true, "login.do");
		
			
			
			
		// 메인 페이지로 가도록 하는 페이지 ===================================================================================================
		} else if(page.equals("/goHome.do")) {
			forward = new ForwardingAction(true, "dashboard.do");
	
			
		// 회원 정보 수정 처리 페이지
		} else if (page.equals("/userSetting.do")) {
			forward = new ForwardingAction(false, "userSetting.jsp");
			
			
		// 회원 정보 수정 처리 페이지
		} else if (page.equals("/userSettingUserSaveAction.do")) {
			cmd = new UserSettingUserSaveCommand();
			
			forward = cmd.execute(req, res);
			
		// 비밀번호 수정 처리 페이지
		} else if (page.equals("/userSettingUserPasswordSaveAction.do")) {
			cmd = new UserSettingUserPasswordSaveCommand();
			
			forward = cmd.execute(req, res);
						
		// 판매점 정보 수정 페이지
		} else if (page.equals("/userSettingShopSaveAction.do")) {
			cmd = new UserSettingShopSaveCommand();
			
			forward = cmd.execute(req, res);
			
			
		/* ===========================================
		
		대시보드 관련 페이지
		
		============================================= */ 	
			
			
		// 대시보드 페이지
		} else if (page.equals("/dashboard.do")) {
			forward = new ForwardingAction(false, "dashboard.jsp");
			
			
		} else if (page.equals("/dashboardRequestSearch.do")) {
			cmd = new RequestSearchCommand();
			
			forward = cmd.execute(req, res);
			
			
			
		/* ===========================================
		
		모니터링 관련 페이지
		
		============================================= */ 	
			
		// 모니터링 관련 페이지 및 기능
    	} else if (page.equals("/monitoringItem.do")) {
			forward = new ForwardingAction(false, "monitoringItem.jsp");
			
		// 제품별 모니터링 -> 예측 조회
		} else if (page.equals("/monitoringItemForecastSearch.do")) {
			cmd = new ForecastSearchCommand();
			
			forward = cmd.execute(req, res);
			
		// 제품별 모니터링 -> 통계 조회
		} else if (page.equals("/monitoringItemStatSearch.do")) {
			cmd = new StatSearchCommand();
			
			forward = cmd.execute(req, res);
		
		
		} else if (page.equals("/monitoringMonthly.do")) {
			
			// (임시)
			forward = new ForwardingAction(false, "monitoringMonthly.jsp");
		} else if (page.equals("/monitoringSeasonal.do")) {
			
		} else if (page.equals("/monitoringHoliday.do")) {
			
		}
		
		
		// 상품 관련 페이지 및 기능
		else if (page.equals("/itemView.do")) {
			
			// (임시)
			forward = new ForwardingAction(false, "itemView.jsp");
		
		
		/* ===========================================
		
		상품 관리 페이지
		
		============================================= */ 
		
		// 상품 관리 페이지
		} else if (page.equals("/itemManagement.do")) {
			forward = new ForwardingAction(false, "itemManagement.jsp");
			
			
		// 상품 조회 기능
		} else if (page.equals("/itemSearchAction.do")) {

			cmd = new ItemSearchCommand();
			
			forward = cmd.execute(req, res);
			
		} else if (page.equals("/itemSaveAction.do")) {
			
			cmd = new ItemSaveCommand();
			
			forward = cmd.execute(req, res);
			
		}  else if (page.equals("/itemDeleteAction.do")) {
			
			cmd = new ItemDeleteCommand();
			
			forward = cmd.execute(req, res);
		}
		
		
		/* ===========================================
		
		판매 이력 관리 페이지 및 기능
		
		============================================= */ 
		// 판매이력 관리 (수동)
		else if (page.equals("/saleManagement.do")) {
			forward = new ForwardingAction(false, "saleManagement.jsp");
			
		// 판매이력 조회 기능
		} else if (page.equals("/saleSearchAction.do")) {
			
			cmd = new SaleSearchCommand();
			
			forward = cmd.execute(req, res);
			
		// 판매이력 저장/수정 기능
		} else if (page.equals("/saleSaveAction.do")) {
			
			cmd = new SaleSaveCommand();
			
			forward = cmd.execute(req, res);
		
		// 판매이력 삭제 기능
		} else if (page.equals("/saleDeleteAction.do")) {
			
			cmd = new SaleDeleteCommand();
			
			forward = cmd.execute(req, res);
		
		// 판매이력 관리 (자동)
		} else if (page.equals("/saleManagementAuto.do")) {
			
			// 임시
			forward = new ForwardingAction(false, "saleManagementAuto.jsp");
			
		} else if (page.equals("/saleManagementUpload.do")) {
			cmd = new SaleUploadCommand();
			
			forward = cmd.execute(req, res);
		} else if (page.equals("/saleFormDownload.do")) {
			cmd = new SaleFormDownloadCommand();
			
			forward = cmd.execute(req, res);
			
		// 회원 로그인 처리 페이지
		}
		
		
		
		/* ===========================================
		
		페이지 이동 처리
		
		============================================= */ 
		
		// 리다이렉트 ( 페이지 이동 )
		if(forward.getViewPage() != null) {
			if(forward.isRedirect()) {
				res.sendRedirect(path + "/" + forward.getViewPage());
			
				
			// 포워딩 ( URL 은 그대로 두고, 내부 페이지만 이동 )
			} else {
				RequestDispatcher dispatcher = req.getRequestDispatcher(forward.getViewPage());
				dispatcher.forward(req, res);
			}
		}
    }
}
