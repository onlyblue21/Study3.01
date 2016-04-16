package com.letter.controller;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.letter.service.LetterService;
import com.letter.vo.LetterVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class LetterController {
	
	@Resource(name="LetterService")
	private LetterService letterService;
	 
	@RequestMapping(value="/letter")
	public ModelAndView letter(ModelAndView mav) throws Exception{
		System.out.println("controller /letter ");
		mav.setViewName("letter/Letter");
		return mav;
	}
	
	@RequestMapping(value="/letterList")
	public void letterList(ModelMap model) throws Exception{
		ArrayList <LetterVo>letterList = new ArrayList<LetterVo>();
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		letterList = letterService.letterList();
		
		for (int i = 0; i < letterList.size(); i++) {
			System.out.println(i+">"+letterList.get(i).toString());
			jsonArray.add(letterList.get(i).toString());
		}
		jsonObject.put("size" , letterList.size());
		jsonObject.put("letterList" , jsonArray);
	
		model.put("letter/Letter", jsonObject);
	}
	
/*	@RequestMapping(value="/letterListSearch")
	public ModelAndView letterListSearch(ModelAndView mav, HttpServletRequest req) throws Exception{
		ArrayList <LetterVo>letterList = new ArrayList<LetterVo>();
		System.out.println("searchType "+ req.getParameter("searchType"));
		System.out.println("searchType "+ req.getParameter("searchValue"));
		String type=req.getParameter("searchType");
		String value=req.getParameter("searchValue");
		
		letterList = letterService.letterList(type, value);
		mav.addObject("letterList", letterList);
		mav.setViewName("letter/Letter");
		
		return mav;
	}	*/
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/letterListSearch", method={RequestMethod.POST}, produces="application/json; charset=utf8")
	@ResponseBody
	public String letterListSearch(HttpServletRequest req, @RequestBody String param) throws Exception{
		ArrayList  letterList = new ArrayList();
//		System.out.println(param);
		JSONObject json = JSONObject.fromObject(param);
//		System.out.println(json.get("type"));
//		System.out.println(json.get("value").toString());
		letterList = letterService.letterList(json.get("type").toString(), json.get("value").toString());
//		System.out.println("letterList.size() > "+ letterList.size());
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < letterList.size(); i++) {
//			System.out.println(letterList.get(i));
			jsonArray.add(letterList.get(i));
//			System.out.println(jsonArray.toString());
		}
		JSONObject result = new JSONObject();
		result.put("size", jsonArray.size());
		result.put("data", jsonArray);
//		System.out.println(result.toString());
		return result.toString();
	}
	
	@RequestMapping(value="/letterWrite")
	public ModelAndView letterWrite(ModelAndView mav) throws Exception{
		System.out.println("controller /letterWrite GET ");
		mav.setViewName("letter/LetterWrite");
		
		return mav;
	}
	
	@RequestMapping(value="/letterWrite",  method={RequestMethod.POST})
	public ModelAndView letterWrite(ModelAndView mav, LetterVo letterVo) throws Exception{
		System.out.println("controller /letterWrite POST");
		letterVo.setSender_id("sin");
		letterVo.setSender_seq("1");
/*		System.out.println(letterVo.getRecipient_id());
		System.out.println(letterVo.getRecipient_seq());
		System.out.println(letterVo.getContent());
*/
		int result =letterService.letterWrite(letterVo);
	
		mav.setViewName("letter/Letter");
		return mav;
	}
	@RequestMapping(value="/letterContent", method={RequestMethod.GET})
	public ModelAndView letterContent(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		System.out.println("controller /letterContent ");
		System.out.println("req "+req.getParameter("letter_seq"));
		int seq = Integer.parseInt(req.getParameter("letter_seq"));
		LetterVo letterVo = letterService.letterSelect(seq);
		System.out.println(letterVo.toString());
		
		mav.addObject("letterVo", letterVo);
		mav.setViewName("letter/LetterContent");
		
		return mav;
	}		
}
