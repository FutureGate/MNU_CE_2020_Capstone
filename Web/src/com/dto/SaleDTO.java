package com.dto;

public class SaleDTO {
	private int saleID;
	private String saleDate;
	private int shopID;
	private int itemID;
	private int saleCount;
	
	public SaleDTO() {
		super();
	}

	public SaleDTO(int saleID, String saleDate, int shopID, int itemID, int saleCount) {
		super();
		this.saleID = saleID;
		this.saleDate = saleDate;
		this.shopID = shopID;
		this.itemID = itemID;
		this.saleCount = saleCount;
	}

	public int getSaleID() {
		return saleID;
	}

	public void setSaleID(int saleID) {
		this.saleID = saleID;
	}

	public String getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
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

	public int getSaleCount() {
		return saleCount;
	}

	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}
	
}
