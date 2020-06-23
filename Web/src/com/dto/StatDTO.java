package com.dto;

public class StatDTO {
	private int statID;
	private String baseDate;
	private String statDate;
	private int shopID;
	private int itemID;
	private int sum;
	private float avg;
	
	public StatDTO() {
		super();
	}

	public StatDTO(int statID, String baseDate, String statDate, int shopID, int itemID, int sum, float avg) {
		super();
		this.statID = statID;
		this.baseDate = baseDate;
		this.statDate = statDate;
		this.shopID = shopID;
		this.itemID = itemID;
		this.sum = sum;
		this.avg = avg;
	}

	public int getStatID() {
		return statID;
	}

	public void setStatID(int statID) {
		this.statID = statID;
	}

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	public String getStatDate() {
		return statDate;
	}

	public void setStatDate(String statDate) {
		this.statDate = statDate;
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

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}

	public float getAvg() {
		return avg;
	}

	public void setAvg(float avg) {
		this.avg = avg;
	}
	
	
	
}
