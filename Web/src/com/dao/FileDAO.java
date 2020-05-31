package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dto.FileDTO;
import com.dto.SaleDTO;
import com.util.DBConnector;

public class FileDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public FileDAO() {
		
	}
	
	public ArrayList<FileDTO> getFiles(String userID) {
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		
		String sql = "select * from file_table where user_id = ? order by upload_date desc";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userID);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FileDTO file = new FileDTO();
				
				file.setFileID(rs.getInt("file_id"));
				file.setFileName(rs.getString("file_name"));
				file.setUserID(rs.getString("user_id"));
				file.setUploadDate(rs.getString("upload_date"));
				file.setState(rs.getString("state"));
				
				list.add(file);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public FileDTO getFile(String fileID) {
		FileDTO file = null;
		
		String sql = "select * from file_table where file_id = ?";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fileID);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				file = new FileDTO();
				
				file.setFileID(rs.getInt("file_id"));
				file.setFileName(rs.getString("file_name"));
				file.setUserID(rs.getString("user_id"));
				file.setUploadDate(rs.getString("upload_date"));
				file.setState(rs.getString("state"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return file;
	}
	
	public void add(String fileName, String userID) {
		
		String sql = "insert into file_table values (0, ?, ?, now(), ?)";
		
		try {
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fileName);
			pstmt.setString(2, userID);
			pstmt.setString(3, "데이터 처리 중");
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
