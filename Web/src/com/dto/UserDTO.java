package com.dto;

public class UserDTO {
	private String userID;
	private String userName;
	private String password;
	private String company;
	private String email;
	private String contact;
	private String about;
	private String registeredDate;
	private int userLevel;

	public UserDTO() {
		super();
	}

	public UserDTO(String userID, String userName, String password, String company, String email, String contact,
			String about, String registeredDate, int userLevel) {
		super();
		this.userID = userID;
		this.userName = userName;
		this.password = password;
		this.company = company;
		this.email = email;
		this.contact = contact;
		this.about = about;
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
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
		return "UserDTO [userID=" + userID + ", userName=" + userName + ", password=" + password + ", company="
				+ company + ", email=" + email + ", contact=" + contact + ", about=" + about + ", registeredDate="
				+ registeredDate + ", userLevel=" + userLevel + "]";
	}

	
	
	
}
