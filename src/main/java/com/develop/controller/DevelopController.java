package com.develop.controller;

import java.util.List;

//import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String selectList(DevelopVo developVo, Model model) throws Exception{
		
		List<DevelopVo> developList = developService.selectDevelopList(developVo);
		
		model.addAttribute("developList", developList);
		
		return "/develop/DevelopListR";
	}
	
	/**
     * 개발자 상세조회 화면
     *
     * @param developVo {@link DevelopVo}
     * @param model {@link Model}
     * @return 개발자 목록조회 jsp
     */
	@RequestMapping(value="/{develop_seq}")
	public String selectDevelop(DevelopVo developVo, Model model) throws Exception{
		model.addAttribute("developVo", developService.selectDevelopByDevelopSeq(developVo));
		
		return "/develop/DevelopR";
	}
	
	/**
     * 개발자 등록 화면
     *
     * @param model {@link Model}
     * @return 개발자 등록화면 jsp
     */
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertDevelop(Model model) throws Exception{
		model.addAttribute("developVo", new DevelopVo());
		
		return "/develop/DevelopCU";
	}
	
	/**
     * 개발자 등록 수행
     *
     * @param developVo {@link DevelopVo}
     * @param model {@link Model}
     * @return 개발자 상세조회 jsp
     */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertDevelop(DevelopVo developVo) throws Exception{
		
		// TODO 로그인정보 가져와야함
		developVo.setMember_seq(1);
		
		developService.insertDevelop(developVo);
		
		// 등록한 게시물 재조회
		//developVo = developService.selectDevelop(developVo);
		
		return "redirect:/develop/";
	}
	
	/**
     * 개발자 수정 화면
     *
     * @param model {@link Model}
     * @return 개발자 수정화면 jsp
     */
	@RequestMapping(value="/{develop_seq}/update", method=RequestMethod.GET)
	public String updateDevelop(DevelopVo developVo, Model model) throws Exception{
		developVo = developService.selectDevelopByDevelopSeq(developVo);
		
		model.addAttribute("developVo", developVo);
		
		return "/develop/DevelopCU";
	}
	
	/**
     * 개발자 수정 수행
     *
     * @param developVo {@link DevelopVo}
     * @param model {@link Model}
     * @return 개발자 상세조회 jsp
     */
	@RequestMapping(value="/{develop_seq}/update", method=RequestMethod.POST)
	public String updateDevelop(DevelopVo developVo) throws Exception{
		
		// TODO 로그인정보 가져와야함
		developVo.setMember_seq(1);
		
		developService.updateDevelop(developVo);
		
		return "redirect:/develop/" + developVo.getDevelop_seq();
	}
	
	
}
