package com.dto;

public class RequestDTO {
	private int requestID;
	private int shopID;
	private int itemID;
	private String requestDate;
	private String state;
	private int trained;
	
	public RequestDTO() {
		super();
	}

	public RequestDTO(int requestID, int shopID, int itemID, String requestDate, String state, int trained) {
		super();
		this.requestID = requestID;
		this.shopID = shopID;
		this.itemID = itemID;
		this.requestDate = requestDate;
		this.state = state;
		this.trained = trained;
	}

	public int getRequestID() {
		return requestID;
	}

	public void setRequestID(int requestID) {
		this.requestID = requestID;
	}

	public int getShopID() {
		return shopID;
	}

	public void setShopID(int shopID) {
		this.shopID = shopID;
	}

	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getTrained() {
		return trained;
	}

	public void setTrained(int trained) {
		this.trained = trained;
	}
	
}
