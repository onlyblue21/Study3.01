package com.profile.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.profile.service.ProfileService;

@Controller
public class ProfileController {
	
		@Resource(name = "ProfileService")
		public ProfileService profileservice;

		@RequestMapping(value = "/profile", method = RequestMethod.POST)
		public String profile(Model model){
			System.out.println("profile");
			String test = "profile생성화면";
			model.addAttribute("test",test);
			
			return "/profile/Profile";
		}
		
		
		@RequestMapping(value = "/profileconfirm" , method = RequestMethod.POST)
		public String profileconfirm(Model model){
			System.out.println("profileconfirm");
			
			return "/main/MainR";
		}

	}
