package com.member.controller;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SmtpGmail extends Authenticator {
	
	String name="aa";
	
	
	public void sendUpgradeEMail(String name){
		Properties props = new Properties();
		props.put("mail.stmp.host", "mail.ksug.org");
		Session s = Session.getInstance(props,null);
		
		MimeMessage message = new MimeMessage(s);
		
		try{
			
			message.setFrom(new InternetAddress("useradmin@ksug.org"));
//			message.addRecipient(Message.RecipientType.TO, new InternetAddress(name.getEmail()));
			
			message.setSubject("제목 테스트");
			message.setText("내용 테스트");
			
			Transport.send(message);
			
		}catch(AddressException e){
			throw new RuntimeException(e);
		}catch(MessagingException e){
			throw new RuntimeException(e);
		}
//			catch(UnsupportedEncodingException e){
//			throw new RuntimeException(e);
//		}
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		String user = "@gmail.com";
		String pw ="";
		
		return new PasswordAuthentication(user,pw);
		
	}

}
