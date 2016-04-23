package com.usedTrade.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.member.service.MemberService;
import com.usedTrade.service.UsedTradeService;
import com.usedTrade.vo.UsedTradeVo;

/*
 * used_trade_seq , member_seq , title , content , reg_date ,
 * delete_date , read_count , trade_status , del_yn , used_trade_type ,
 * location_code , money
 */
@Controller
public class UsedTradeController {

	@Autowired
	UsedTradeService usedTradeService;

	@RequestMapping("/usedTrades/main")
	public String viewMain(Model model, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "rowsPerPage", defaultValue = "10") int rowsPerPage) throws Exception {

		List<UsedTradeVo> usedTrades = usedTradeService.listUsedTrade(page, rowsPerPage);

		model.addAttribute("usedTrades", usedTrades);

		return "/usedTrade/main";
	}
	@RequestMapping("/usedTrades/{used_trade_seq}")
	public String viewUsedTrade(Model model, @PathVariable int used_trade_seq) throws Exception {
		UsedTradeVo usedTrade = usedTradeService.selectUsedTrade(used_trade_seq);
		model.addAttribute("usedTrade", usedTrade);
		return "/usedTrade/";
	}

	@RequestMapping("/usedTradeWrite")
	public String viewUsedTradeWrite(Model mode) {
		return "/usedTradeWrite";
	}

	@RequestMapping("/writeUsedTrade")
	public String writeUsedTrade(
			@RequestParam("title") 				String title
			, @RequestParam("content") 			String content
			, @RequestParam("used_trade_type") 	String  used_trade_type
			, @RequestParam("location_code") 	String  location_code
			, @RequestParam("money") 			int  money) throws Exception {

		String url = "";
		
		UsedTradeVo usedtrade = new UsedTradeVo();
		usedtrade.setTitle(title);
		usedtrade.setContent(content);
		usedtrade.setUsed_trade_type(used_trade_type);
		usedtrade.setLocation_code(location_code);
		usedtrade.setMoney(money);
		
		int used_trade_seq = usedTradeService.writeUsedTrade(usedtrade);
		

		url = "redirect:/usedTrades/"+used_trade_seq;
		return url;
	}

}
