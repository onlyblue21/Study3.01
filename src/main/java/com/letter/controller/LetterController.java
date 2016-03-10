package com.letter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.letter.service.LetterService;
import com.letter.vo.LetterVo;

@Controller
@RequestMapping(value="/letter")
public class LetterController {
	@Autowired
	private LetterService letterService;
	
	@RequestMapping(value="/")
	public String selectLetterList(LetterVo letterVo, Model model){
		model.addAttribute("letterList", letterService.selectLetterList());
		
		return "/letter/LetterListR";
	}
}
