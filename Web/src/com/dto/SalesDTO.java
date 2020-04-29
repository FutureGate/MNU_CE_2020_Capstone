package com.dto;

public class SalesDTO {
	private String userID;
	private String saleDate;
	private String prodCode;
	private String prodName;
	private int saleCount;
	
	public SalesDTO() {
		super();
	}
	
	public SalesDTO(String userID, String saleDate, String prodCode, String prodName, int saleCount) {
		super();
		this.userID = userID;
		this.saleDate = saleDate;
		this.prodCode = prodCode;
		this.prodName = prodName;
		this.saleCount = saleCount;
	}
	
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}

	public String getProdCode() {
		return prodCode;
	}

	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public int getSaleCount() {
		return saleCount;
	}

	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}

	@Override
	public String toString() {
		return "[userID=" + userID + ", saleDate=" + saleDate + ", prodCode=" + prodCode + ", prodName="
				+ prodName + ", saleCount=" + saleCount + "]";
	}

	
	
	
}
