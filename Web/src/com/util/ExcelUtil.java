package com.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.dao.ItemDAO;
import com.dto.SaleDTO;
import com.dto.ShopDTO;

public class ExcelUtil {
	private static ExcelUtil instance = new ExcelUtil();
	
	public ExcelUtil() {
		
	}
	
	public static ExcelUtil getInstance() {
		if(instance == null) {
			instance = new ExcelUtil();
		}
		
		return instance;
	}
	
	public ArrayList<SaleDTO> excelFileCheck(File file, int shopID, ItemDAO dao) {
		ArrayList<SaleDTO> saleList = new ArrayList<SaleDTO>();
		
		int rowCount = 0;
		int cellCount = 0;
		
		
		try {
			
			Workbook wb = WorkbookFactory.create(file);
			
			Sheet sheet = wb.getSheetAt(0);
            
			// 행에 대해서 반복
            for(Row row : sheet) {
            	SaleDTO sale = new SaleDTO();
            	cellCount = 0;
            	
            	sale.setShopID(shopID);
            	sale.setSaleID(0);
            	
            	// 셀에 대해서 반복
            	for(Cell cell : row) {
            		
            		// 셀이 3칸 이상일 경우 오류
            		if(cellCount > 2)
            			return null;
            		
            		String data = cell.toString();
            		
            		if(data.length() == 0 || data.equals(""))
            			return null;
            		
            		// 헤더 검사 ("판매일자", "상품번호", "판매수량")
            		if(rowCount == 0) {
            			switch (cellCount) {
						case 0:
							if(!data.equals("판매일자"))
								return null;
							break;
						case 1:
							if(!data.equals("상품번호"))
								return null;
							break;
						case 2:
							if(!data.equals("판매수량"))
								return null;
							break;
						default:
							break;
						}
            			
            			
            		// 데이터 검사 (존재하는 상품 정보인지)
            		} else {
            			switch (cellCount) {
						case 0:
							
							String[] parsedData = data.split("-");
							
							String year = parsedData[2];
							String month = parsedData[1];
							String date = parsedData[0];
							
							month = month.replace("월", "");
							
							if(Integer.parseInt(month) < 10) {
								month = "0" + month;
							}
						
							sale.setSaleDate(year + "-" + month + "-" + date);
							
							break;
						case 1:
							int itemID = (int) Float.parseFloat(data);
                			
                        	if(dao.getItem(itemID) == null) {
                        		
                        		System.out.println("등록되지 않은 상품정보");
                        		return null;
                        	}
                        	
                        	sale.setItemID(itemID);
                        	
							break;
						case 2:
							int saleCount = (int) Float.parseFloat(data);
							
							sale.setSaleCount(saleCount);
							break;	
						default:
							break;
						}
            		}
            		
            		cellCount++;
            		
            	}
            	
            	if(sale.getItemID() == 0 || sale.getSaleDate() == null) {
        			
        		} else {
        			saleList.add(sale);
        		}
            	
            	rowCount++;
            }
            
            return saleList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
