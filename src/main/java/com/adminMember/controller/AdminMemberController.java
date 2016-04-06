package com.adminMember.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import com.adminMember.service.AdminMemberService;
import com.member.vo.MemberVo;


@Controller
public class AdminMemberController {
	
	@Resource(name="AdminMemberService")
	public AdminMemberService adminmemberservice;
	private MemberVo membervo;

	
	@RequestMapping(value="/adminMember")
	public ModelAndView memberList(ModelAndView mav, HttpServletRequest req) throws Exception{

		List <MemberVo>memberList = new ArrayList<MemberVo>();
		
		int totalCount = adminmemberservice.countCheck(membervo);

		String type=req.getParameter("searchType");
		String value=req.getParameter("searchValue");
		
		System.out.println("회원정보페이지로이동! ");
		System.out.println(totalCount);
		System.out.println("searchType "+ type);
		System.out.println("searchValue "+ value);

		memberList = adminmemberservice.memberList(type,value);
		
		System.out.println(memberList);
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("memberList", memberList);
		
		mav.setViewName("adminMember/AdminMemberList");
		
		return mav;
	}


}