package com.dto;

public class ShopDTO {
	
	private int shopID;
	private String shopName;
	private String contact;
	private String email;
	
	public ShopDTO(int shopID, String shopName, String contact, String email) {
		super();
		this.shopID = shopID;
		this.shopName = shopName;
		this.contact = contact;
		this.email = email;
	}

	public ShopDTO() {
		super();
	}

	public int getShopID() {
		return shopID;
	}

	public void setShopID(int shopID) {
		this.shopID = shopID;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
