package com.dto;

public class FileDTO {
	private int fileID;
	private String fileName;
	private String userID;
	private String uploadDate;
	private String state;
	
	public FileDTO() {
		super();
	}
	
	public FileDTO(int fileID, String fileName, String userID, String uploadDate, String state) {
		super();
		this.fileID = fileID;
		this.fileName = fileName;
		this.userID = userID;
		this.uploadDate = uploadDate;
		this.state = state;
	}
	
	public int getFileID() {
		return fileID;
	}
	public void setFileID(int fileID) {
		this.fileID = fileID;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
