package com.dto;

public class ItemDTO {
	private int itemID;
	private String itemName;
	private int shopID;
	
	public int getItemID() {
		return itemID;
	}
	public void setItemID(int itemID) {
		this.itemID = itemID;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getShopID() {
		return shopID;
	}
	public void setShopID(int shopID) {
		this.shopID = shopID;
	}
	
	public ItemDTO() {
		super();
	}
	
	public ItemDTO(int itemID, String itemName, int shopID) {
		super();
		this.itemID = itemID;
		this.itemName = itemName;
		this.shopID = shopID;
	}
		
	
}
