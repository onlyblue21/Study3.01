package com.adminMember.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;



import com.adminMember.service.AdminMemberService;
import com.member.vo.MemberVo;


@Controller
public class AdminMemberController {
	
	@Resource(name="AdminMemberService")
	public AdminMemberService adminmemberservice;
	private MemberVo membervo;

	
	@RequestMapping(value="/adminMember")
	public ModelAndView memberList(ModelAndView mav, HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1")int page
			) throws Exception{

		List <MemberVo>memberList = new ArrayList<MemberVo>();
		
		String type=req.getParameter("searchType");
		String value=req.getParameter("searchValue");
		
		System.out.println("�쉶�썝�젙蹂댄럹�씠吏�濡쒖씠�룞! ");

		System.out.println("searchType "+ type);
		System.out.println("searchValue "+ value);
		System.out.println("page "+ page);

		memberList = adminmemberservice.memberList(type,value,page);
		int totalCount = adminmemberservice.countCheck(type,value);
		int lastPage = adminmemberservice.getLastPage(type,value);
		
		System.out.println(totalCount);
		System.out.println(lastPage);
		System.out.println(memberList);
		
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("lastPage", lastPage);
		mav.addObject("page", page);
		mav.addObject("memberList", memberList);
		
		mav.setViewName("adminMember/AdminMemberList");
		
		return mav;
	}
	
    @RequestMapping(value = "/adminMember/deleteSvc", method = RequestMethod.POST)
    public void deleteSvc(MemberVo memberVo,@RequestBody String param) throws Exception {
    	System.out.println("<"+param);
    	String [] temp = param.split("&");
    	for (int i = 0; i < temp.length; i++) {
    		System.out.println(temp[i]);
    		String temp2 = temp[i].replace("memberSeqs=", "");
    		System.out.println(temp2);
    		memberVo.setMember_seq(Integer.parseInt(temp2));
    		adminmemberservice.deleteSvc(memberVo);
		}
    }

}