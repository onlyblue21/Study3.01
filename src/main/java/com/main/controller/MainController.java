package com.main.controller;

import java.net.InetAddress;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
public class MainController {

	@Resource(name="MemberService")
	public MemberService memberservice; 
	
	 
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	//ip관련
	private void Localhostcheck(HttpServletRequest request) throws Exception{
		
		//외부 ip주소 받아오는것
/*		String localhost = InetAddress.getLocalHost().toString();
		InetAddress[] iaArr = InetAddress.getAllByName("study.iptime.org");
		for(InetAddress remote : iaArr){
			System.out.println("www.naver.com IP 주소 : " + remote.getHostAddress());
		}*/
		
		String localhost = InetAddress.getLocalHost().toString();
		StringTokenizer st = new StringTokenizer(localhost,"/");
		String host = st.nextToken();
		String ip = st.nextToken(host);
		System.out.println("ip = " + ip);
		String clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
		
		if(null == clientIp || clientIp.length() == 0  || clientIp.toLowerCase().equals("unknown")){
		  clientIp = request.getHeader("REMOTE_ADDR");
		 
		  if(null == clientIp || clientIp.length() == 0  || clientIp.toLowerCase().equals("unknown")){
			  clientIp = request.getRemoteAddr();
		  }
		}
		System.out.println("접속clientIp= " + clientIp);
	}
	
	
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model, MemberVo membervo,HttpServletRequest request) throws Exception {

		// MessageSourceAccessor msa = new MessageSourceAccessor(null);
		System.out.println("====================");
		System.out.println("====================");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		Localhostcheck(request);
			
			
		String formattedDate = dateFormat.format(date);
		String test = "main화면";

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("test", test);

		return "/main/MainR";
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String main(Locale local, Model model) {
		System.out.println("main");
		String test = "main";
		model.addAttribute("test", test);

		return "/Main/Main";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, MemberVo membervo) throws Exception {
		System.out.println("login");
		System.out.println("id,pw 값 불러와서 로그인함");

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
//충돌테스트
}
