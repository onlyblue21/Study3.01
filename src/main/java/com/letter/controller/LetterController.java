package com.letter.controller;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.letter.service.LetterService;
import com.letter.vo.LetterVo;

@Controller
public class LetterController {
	
	@Resource(name="LetterService")
	private LetterService letterService;
	 
	@RequestMapping(value="/letter")
	public ModelAndView letter(ModelAndView mav) throws Exception{
		ArrayList <LetterVo>letterList = new ArrayList<LetterVo>();
		System.out.println("/letter controller");
		letterList = letterService.letterList();
		mav.addObject("letterList", letterList);
		mav.setViewName("letter/Letter");
		
		return mav;
	}
}
