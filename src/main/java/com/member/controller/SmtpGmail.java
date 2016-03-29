package com.member.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SmtpGmail extends Authenticator {
	
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		String user = "onlyblue21@gmail.com";
		String pw ="rlatjdanr26";
		
		return new PasswordAuthentication(user,pw);
		
	}

}
