package com.command.sale;

import java.io.File;
import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.ExcelUtil;

public class SaleUploadCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		
		
		String saveDir = "C:\\upload";

		int maxSize = 1024*1024*3;
		
		String encType = "UTF-8";
		String serverURL = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort();	
		
		try {
			MultipartRequest multipartRequest
			= new MultipartRequest(req, saveDir, maxSize, encType, new DefaultFileRenamePolicy());
		
			//System.out.println("파일 : " + multipartRequest.getParameter("filepond"));
			//System.out.println("업로드파일명 : " + multipartRequest.getFilesystemName("filepond"));
			//System.out.println("원래파일명 : " + multipartRequest.getOriginalFileName("filepond"));
			
			String orgFileName = multipartRequest.getFilesystemName("filepond");
			int pos = orgFileName.lastIndexOf( "." );
			String ext = orgFileName.substring( pos + 1 );
			
			File file = multipartRequest.getFile("filepond");
			boolean result = true;
			
			if(ext.equals("xlsx")) {
				result = ExcelUtil.getInstance().excelFileCheck(file);
			}
			
			if(result == false) {
				res.sendError(400);
			}
			
			//System.out.println("파일 용량 : " + file.length());
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
