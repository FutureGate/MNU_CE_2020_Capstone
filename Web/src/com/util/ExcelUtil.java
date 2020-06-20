package com.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

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
	
	public boolean excelFileCheck(File file) {
		int rowCount = 0;
		int cellCount = 0;
		
		
		try {
			Workbook wb = WorkbookFactory.create(file);
			
			Sheet sheet = wb.getSheetAt(0);
            
            for(Row row : sheet) {
            	
            	cellCount = 0;
            	
            	for(Cell cell : row) {
            		if(cellCount > 2)
            			return false;
            		
            		String data = cell.toString();
            		
            		if(rowCount == 0) {
            			switch (cellCount) {
						case 0:
							if(!cell.toString().equals("판매일자"))
								return false;
							break;
						case 1:
							if(!cell.toString().equals("상품번호"))
								return false;
							break;
						case 2:
							if(!cell.toString().equals("판매수량"))
								return false;
							break;	
						default:
							break;
						}
            		} else {
            			int 
					
            		}
            		
            		System.out.println(cell.toString());
            		
            		cellCount++;
            	}
            	rowCount++;
            }
            
            return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
