package com.dto;

public class ForecastDTO {
	private int forecastID;
	private String baseDate;
	private String saleDate;
	private int shopID;
	private int itemID;
	private float saleCount;
	
	public ForecastDTO() {
		super();
	}
	
	public ForecastDTO(int forecastID, String baseDate, String saleDate, int shopID, int itemID, float saleCount) {
		super();
		this.forecastID = forecastID;
		this.baseDate = baseDate;
		this.saleDate = saleDate;
		this.shopID = shopID;
		this.itemID = itemID;
		this.saleCount = saleCount;
	}
	
	public int getForecastID() {
		return forecastID;
	}
	public void setForecastID(int forecastID) {
		this.forecastID = forecastID;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
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
	public float getSaleCount() {
		return saleCount;
	}
	public void setSaleCount(float saleCount) {
		this.saleCount = saleCount;
	}
	
	
}
