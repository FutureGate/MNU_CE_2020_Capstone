package com.controller;

public class ForwardingAction {
	private boolean isRedirect = false;
	private String viewPage = null;
	
	public ForwardingAction() {
		
	}
	
	public ForwardingAction(boolean isRedirect, String viewPage) {
		super();
		this.isRedirect = isRedirect;
		this.viewPage = viewPage;
	}

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
}
