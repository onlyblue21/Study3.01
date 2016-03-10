package com.main.Controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.main.service.MainService;
import com.main.vo.MainVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {

	@Resource(name = "MainService")
	public MainService mainservice;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model, MainVo membervo) throws Exception {

		// MessageSourceAccessor msa = new MessageSourceAccessor(null);
		System.out.println("====================");
		System.out.println("====================");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

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
	public String login(Model model, MainVo mainvo) throws Exception {
		System.out.println("login");
		System.out.println("id,pw 값 불러와서 로그인함");

		boolean _login = false;
		_login = mainservice.Login(mainvo);
		System.out.println("_login = " + _login);
		System.out.println("mainvoid = " + mainvo.getId());
		System.out.println("mainvopw = " + mainvo.getPw());
		if (_login) {
			System.out.println("LOGIN 성공");
			model.addAttribute("LOGIN_RESULT",mainvo.getId()+"님 로그인 되었습니다.");
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
