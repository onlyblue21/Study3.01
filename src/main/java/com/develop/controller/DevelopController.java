package com.develop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.develop.service.Impl.DevelopServiceImpl;
import com.develop.vo.DevelopVo;

@Controller
@RequestMapping("/develop")
public class DevelopController {
	@Autowired
	private DevelopServiceImpl developService;
	
	/**
     * 개발자 목록조회 화면
     *
     * @param developVo {@link DevelopVo}
     * @param model {@link Model}
     * @return 개발자 목록조회 jsp
     */
	@RequestMapping("")
	public String selectList(DevelopVo developVo, Model model){
		
		List<DevelopVo> developList = developService.selectDevelopList(developVo);
		
		model.addAttribute("developList", developList);
		
		return "/develop/DevelopListR";
	}
}
