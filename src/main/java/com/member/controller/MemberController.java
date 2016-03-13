package com.member.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.member.service.MemberService;
import com.member.vo.MemberVo;

@Controller
public class MemberController {

	@Resource(name="MemberService")
	public MemberService memberservice; 
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberjoin(Model model) {
		
			System.out.println("회원가입 Page이동!");
		
			return "/member/MemberJoin";
	}
	
	
	@RequestMapping(value = "/memberjoin_j", method = RequestMethod.POST)
	public String memberjoin_j(Model model, MemberVo membervo) throws Exception{
		
		if(!membervo.getId().equals(null) || !membervo.getId().equals("") ){
			int firstvalue=0;
			membervo.setUser_level(firstvalue);
			membervo.setUser_exp(firstvalue);
			membervo.setAccess_count(firstvalue);
			membervo.setMember_point(firstvalue);
			membervo.setSts("");
			
			memberservice.memberjoin(membervo);
			model.addAttribute("LOGIN_RESULT",membervo.getId()+"님 로그인 되었습니다.");
			model.addAttribute("LoginResult","SUCCESS");
			System.out.println("회원가입 완료!");
			
		}
		return "/main/MainR";
	}
}
