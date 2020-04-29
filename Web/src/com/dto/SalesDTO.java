package com.dto;

public class SalesDTO {
	private String saleDate;
	private String prodCode;
	private String prodName;
	private String saleCount;
	
	public SalesDTO() {
		super();
	}
	
	public SalesDTO(String saleDate, String prodCode, String prodName, String saleCount) {
		super();
		this.saleDate = saleDate;
		this.prodCode = prodCode;
		this.prodName = prodName;
		this.saleCount = saleCount;
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

	public String getSaleCount() {
		return saleCount;
	}

	public void setSaleCount(String saleCount) {
		this.saleCount = saleCount;
	}
	
}
