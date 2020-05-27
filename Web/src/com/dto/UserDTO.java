package com.dto;

public class UserDTO {
	private String userID;
	private String userName;
	private String password;
	private int shopID;
	private String registeredDate;
	private int userLevel;
	
	public UserDTO() {
		super();
	}
	
	public UserDTO(String userID, String userName, String password, int shopID, String registeredDate, int userLevel) {
		super();
		this.userID = userID;
		this.userName = userName;
		this.password = password;
		this.shopID = shopID;
		this.registeredDate = registeredDate;
		this.userLevel = userLevel;
	}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getShopID() {
		return shopID;
	}
	public void setShopID(int shopID) {
		this.shopID = shopID;
	}
	public String getRegisteredDate() {
		return registeredDate;
	}
	public void setRegisteredDate(String registeredDate) {
		this.registeredDate = registeredDate;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}

	@Override
	public String toString() {
		return "UserDTO [userID=" + userID + ", userName=" + userName + ", password=" + password + ", shopID=" + shopID
				+ ", registeredDate=" + registeredDate + ", userLevel=" + userLevel + "]";
	}
	
}
