package com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

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
	
	public boolean xlsxFileCheck(File file) {
		try {
            FileInputStream fis = new FileInputStream(file);
            HSSFWorkbook workbook = new HSSFWorkbook(fis);
            HSSFSheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
            int rows = sheet.getPhysicalNumberOfRows(); // 해당 시트의 행의 개수
            for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                if (row != null) {
                    int cells = row.getPhysicalNumberOfCells();
                    for (int columnIndex = 0; columnIndex <= cells; columnIndex++) {
                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                        String value = "";
                        
                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                        case NUMERIC:
                            value = cell.getNumericCellValue() + "";
                            break;
                        case STRING:
                            value = cell.getStringCellValue() + "";
                            break;
                        case BOOLEAN:
                            value = cell.getBooleanCellValue() + "";
                            break;
                        case ERROR:
                            value = cell.getErrorCellValue() + "";
                            break;
                        }
                        System.out.println(value);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

		return false;
	}
}
