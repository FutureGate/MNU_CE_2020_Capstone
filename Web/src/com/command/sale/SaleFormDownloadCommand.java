package com.command.sale;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.Command;
import com.controller.ForwardingAction;

public class SaleFormDownloadCommand implements Command {

	@Override
	public ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// 변수 선언
		boolean isRedirect = true;
		String viewPage = null;
		
		String saveDir = "D:\\upload";
		String encType = "UTF-8";
		
		String fileName = "form.xlsx";
		
		int maxSize = 1024*1024*3;
		
		File file = new File(saveDir + "/" + fileName);
		
		res.reset();
		res.setContentType("application/octet-stream");
			
		String downName = null;
		if(req.getHeader("user-agent").indexOf("MSIE") == -1)
		{
			downName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}
		else
		{
			downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		res.setHeader("Content-Disposition","attachment;filename=\"" + downName + "\";");
		
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = res.getOutputStream();
		
		byte b [] = new byte[1024];
		int data = 0;
		
		while((data=(fileInputStream.read(b, 0, b.length))) != -1)
		{
			servletOutputStream.write(b, 0, data);
		}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
		
		return new ForwardingAction(isRedirect, viewPage);
	}
}
