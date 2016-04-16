package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.member.service.MemberService;
import com.member.vo.MemberVo;

@Controller
public class MemberController {

	@Resource(name="MemberService")
	public MemberService memberservice; 
	
	
	@RequestMapping(value = "/logout")
	public String logout(Model model){
		
		return "/main/MainR";
	}
	
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberjoin(Model model) {
		
			System.out.println("회원가입 Page이동!");
			return "/member/MemberJoin";
	}
	
	
	//fileupload
	public void fileUpload(MultipartFile mulpartfile, Model model, MemberVo membervo) throws IOException {
		
		final Logger logger = LoggerFactory.getLogger(MemberController.class);
		String path = "F:/FIle";  //로컬
//		String path ="j:/File"; //서버
		String fileName = UUID.randomUUID().toString() + ".png"; 
		
//		MultipartFile report = multipartRequest.getFile("upload");
//		System.out.println("report.getName " +  report.getName());
//		System.out.println("report.getsize =" + report.getSize());
//		System.out.println("report.getOriginalFilename =" + report.getOriginalFilename());
		
		 File filepath = new File(path);
	     File newFile = new File(path+"/"+fileName);
	     logger.debug("newFile:"+newFile);
		 try{
			 if(!filepath.isDirectory()){
				 filepath.mkdirs();
			 }
			 FileUtils.writeByteArrayToFile(newFile, mulpartfile.getBytes());
			 membervo.setFileupload(newFile.toString());
	         model.addAttribute("message", "파일업로드 성공!");
		 }catch(Exception ex){
			 ex.printStackTrace();
	            model.addAttribute("message", "파일업로드 실패!");
		 }
	}
	
	
	@RequestMapping(value = "/memberjoin_j", method = RequestMethod.POST)
	public String memberjoin_j(@RequestParam("upload") MultipartFile mulpartfile, Model model, MemberVo membervo) throws Exception{
		
		if(!membervo.getId().equals(null) || !membervo.getId().equals("") ){
			
			new MemberController().fileUpload(mulpartfile, model, membervo );
			long time = System.currentTimeMillis();
		    SimpleDateFormat ctime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		    String CurrentTime = ctime.format(new Date(time));
		    
		    System.out.println("CurrentTime = " + CurrentTime);
		    System.out.println("파일PATH = "  + membervo.getFileupload());
		    
			memberservice.memberjoin(membervo);
			model.addAttribute("LOGIN_RESULT",membervo.getId()+"님 로그인 되었습니다.");
			model.addAttribute("LoginResult","SUCCESS");
			System.out.println("회원가입 완료!");
		}else{
			
			System.out.println("id가 널일경우");
		}
		
		
		return "/main/MainR";
	}
	
	@RequestMapping(value="/passwordmail", method = RequestMethod.POST)
	public String passwordmail(Model model, MemberVo membervo)throws Exception{
		
		String from ="onlyblue21@gmail.com";
		String to="onlyblue21@naver.com";
		String notice="";
		
		final String fromEmail="onlyblue21@gmail.com";
		final String password="rlatjdanr26";
		
		Properties per = new Properties();
		
		per.put("mail.transport", "smtp");
		per.put("mail.smtp.host", "smtp.gmail.com");
		per.put("mail.smtp.port", "465");
		per.put("mail.smtp.starttls.enable","true");
		per.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		per.put("mail.smtp.user", "from");
		per.put("mail.smtp.auth", "true");
		
//		Authenticator auth = new SmtpGmail(fromEmail, password);
//		Session mailSession = Session.getDefaultlnstance(per.auth);
		
		try{
			
//			MimeMessage ms = new MimeMessage(mailSession);
//			ms.setFrom(new InternetAddress(from));
//			ms.setSubject("제목");
//			ms.setSentDate(new Date());
//			Transport.send(ms);
			
			notice ="전송완료";
		}catch(Exception e){
			notice="전송오류:" + e.toString(); 
		}
		System.out.println(notice);
		
		return "";
	}
	


	
}
