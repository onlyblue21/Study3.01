package com.member.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SmtpGmail extends Authenticator {
	
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		String user = "@gmail.com";
		String pw ="";
		
		return new PasswordAuthentication(user,pw);
		
	}

}
