package com.main.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.member.service.MemberService;
import com.member.vo.MemberVo;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/main")
public class MainController {

	@Resource(name="MemberService")
	public MemberService memberservice; 
	
	public static Logger logger = Logger.getLogger(MainController.class.getName());
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Locale locale, Model model, MemberVo membervo,HttpServletRequest request) throws Exception {
		logger.fatal("log4j:logger.fatal()");
		logger.error("log4j:logger.error()");
		logger.warn("log4j:logger.warn()");
		logger.info("log4j:logger.info()");
		logger.debug("log4j:logger.debug()");
		logger.trace("log4j:logger.trace()");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
	
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

		return "/main/MainR";
	}



	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, MemberVo membervo, HttpSession session) throws Exception {
		boolean _login = false;
		boolean memberLeave = false;
		_login = memberservice.Login(membervo);
		
		//회원 정보가 있음
		if (_login) {
			//세션에 모든 정보 담을
			ArrayList<MemberVo> memberInfo = memberservice.memberInfo(membervo);
			
			System.out.println("test id = " + memberInfo.get(0).getId());
			session.setAttribute("memberInfo", memberInfo.get(0));
			session.setAttribute("memberId", memberInfo.get(0).getId());
			System.out.println("member = " + memberInfo.get(0));
			System.out.println("LOGIN 성공");
			model.addAttribute("LOGIN_RESULT",membervo.getId()+"님 로그인 되었습니다.");
			model.addAttribute("LoginResult","SUCCESS");
			model.addAttribute("login", memberInfo.get(0).getId()+"님 로그인 되었습니다.");
			
			return "/main/MainR";
		
		//회원 정보가 없음
		}else if(_login == false){
			memberLeave = memberservice.memberLeave(membervo);
			if(memberLeave){
				model.addAttribute("login","탈퇴한 회원 입니다.");
			}
			else{
				System.out.println("로그인실패");
				model.addAttribute("login", "ID가 없습니다.");
				return "/main/MainR";
			}
			return "/main/MainR";
		}
		return "";
	}
}
