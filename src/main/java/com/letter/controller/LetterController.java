package com.letter.controller;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
		System.out.println("controller /letter ");
		mav.addObject("letterList", letterList);
		mav.setViewName("letter/Letter");
		return mav;
	}
	
	@RequestMapping(value="/letterList")
	public ModelAndView letterList(ModelAndView mav, HttpServletRequest req) throws Exception{
		ArrayList <LetterVo>letterList = new ArrayList<LetterVo>();
		System.out.println("searchType "+ req.getParameter("searchType"));
		System.out.println("searchType "+ req.getParameter("searchValue"));
		String type=req.getParameter("searchType");
		String value=req.getParameter("searchValue");

		letterList = letterService.letterList(type,value);
//		mav.addObject("letterList", letterList);
		mav.setViewName("letter/Letter");
		
		return mav;
	}	
	
	@RequestMapping(value="/letterWrite")
	public ModelAndView letterWrite(ModelAndView mav) throws Exception{
		System.out.println("controller /letterWrite ");
		mav.setViewName("letter/LetterWrite");
		
		return mav;
	}
	@RequestMapping(value="/letterContent")
	public ModelAndView letterContent(ModelAndView mav) throws Exception{
		System.out.println("controller /letterContent ");
		mav.setViewName("letter/letterContent");
		
		return mav;
	}		
}
