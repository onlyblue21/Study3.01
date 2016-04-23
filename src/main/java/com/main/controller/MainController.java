package com.main.controller;

import java.net.InetAddress;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

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
	public String login(Model model, MemberVo membervo) throws Exception {
		System.out.println("login");
		System.out.println("id,pw 값 불러와서 로그인함");

		HttpSession session = new HttpSession() {
			
			@Override
			public void setMaxInactiveInterval(int arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setAttribute(String arg0, Object arg1) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void removeValue(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void removeAttribute(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void putValue(String arg0, Object arg1) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public boolean isNew() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public void invalidate() {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String[] getValueNames() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Object getValue(String arg0) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public HttpSessionContext getSessionContext() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public ServletContext getServletContext() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public int getMaxInactiveInterval() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public long getLastAccessedTime() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public String getId() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public long getCreationTime() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public Enumeration getAttributeNames() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Object getAttribute(String arg0) {
				// TODO Auto-generated method stub
				return null;
			}
		};
		
		
		boolean _login = false;
		_login = memberservice.Login(membervo);
		System.out.println("_login = " + _login);
		System.out.println("mainvoid = " + membervo.getId());
		System.out.println("mainvopw = " + membervo.getPassword());
		if (_login) {
			System.out.println("LOGIN 성공");
			model.addAttribute("LOGIN_RESULT",membervo.getId()+"님 로그인 되었습니다.");
			model.addAttribute("LoginResult","SUCCESS");
		} else {
			System.out.println("로그인실패");
			model.addAttribute("login", "ID가 없습니다.");
			return "/main/MainR";
		}

		String test = "login됨";
		model.addAttribute("test", test);

		return "/main/MainR";
	}
}
