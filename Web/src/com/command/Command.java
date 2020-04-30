package com.command;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.ForwardingAction;

public interface Command {
	ForwardingAction execute(HttpServletRequest req, HttpServletResponse res) throws IOException;
}
