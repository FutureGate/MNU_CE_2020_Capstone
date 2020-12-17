package com.command.sale;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.dao.ItemDAO;
import com.dao.SaleDAO;
import com.dto.SaleDTO;
import com.dto.ShopDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.ExcelUtil;

public class SaleUploadCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		
		
		String saveDir = "D:\\upload";

		int maxSize = 1024*1024*3;
		
		String encType = "UTF-8";
		String serverURL = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort();	
		ShopDTO shop = (ShopDTO) req.getSession().getAttribute("shop");
		
		int shopID = shop.getShopID();
		
		try {
			// 파일 저장
			MultipartRequest multipartRequest
			= new MultipartRequest(req, saveDir, maxSize, encType, new DefaultFileRenamePolicy());
		
			String orgFileName = multipartRequest.getFilesystemName("filepond");
			int pos = orgFileName.lastIndexOf( "." );
			String ext = orgFileName.substring( pos + 1 );
			
			File file = multipartRequest.getFile("filepond");
			
			ArrayList<SaleDTO> saleList = null;
			
			saleList = ExcelUtil.getInstance().excelFileCheck(file, shopID, new ItemDAO());
			
			if(saleList == null) {
				
				file.delete();
				res.sendError(400);
			} else {
				for(SaleDTO sale : saleList) {
					SaleDAO dao = new SaleDAO();
					
					String saleID = Integer.toString(sale.getSaleID());
					String saleDate = sale.getSaleDate();
					String itemID = Integer.toString(sale.getItemID());
					String saleCount = Integer.toString(sale.getSaleCount());
					
					SaleDTO targetSale = dao.getSaleByInfo(saleDate, Integer.toString(shopID), itemID);
					
					if(targetSale == null) {
						dao.add(saleID, saleDate, Integer.toString(shopID), itemID, saleCount);
					} else {
						dao.addSaleCount(Integer.toString(targetSale.getSaleID()), saleCount);
					}
					
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
	
	public void insertSaleData() {
		
	}
}


