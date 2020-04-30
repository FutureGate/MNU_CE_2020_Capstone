package com.dto;

public class SaleDTO {
	private int saleID;
	private String userID;
	private String saleDate;
	private String prodCode;
	private String prodName;
	private int saleCount;
	
	public SaleDTO() {
		super();
	}

	public SaleDTO(int saleID, String userID, String saleDate, String prodCode, String prodName, int saleCount) {
		super();
		this.saleID = saleID;
		this.userID = userID;
		this.saleDate = saleDate;
		this.prodCode = prodCode;
		this.prodName = prodName;
		this.saleCount = saleCount;
	}

	public int getSaleID() {
		return saleID;
	}

	public void setSaleID(int saleID) {
		this.saleID = saleID;
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
	
	
	
}
