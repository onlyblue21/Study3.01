package com.common;

import java.net.InetAddress;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.main.controller.MainController;

@Controller
@RequestMapping("")
public class EnterManager {
	public static Logger logger = Logger.getLogger(MainController.class.getName());
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) throws Exception {
		//org.apache.ibatis.logging.LogFactory.useLog4JLogging();
		Localhostcheck(request);
		
		// TODO 로그인 체크
		
		return "/main/MainR";
	}
	
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
}
