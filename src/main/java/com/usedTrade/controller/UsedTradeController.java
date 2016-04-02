package com.usedTrade.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsedTradeController {
	
	@RequestMapping("/usedTrade")
	public String viewMain(){
		return "/usedTrade/usedTrade";
	}

}
