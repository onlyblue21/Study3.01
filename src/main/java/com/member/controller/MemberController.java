package com.member.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

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
	
	
//-------------------------------파일 업로드 소스 ---------------------------------	
	
	public static void fileUpload(MultipartFile fileData, String path, String fileName) throws IOException {
		  String originalFileName = fileData.getOriginalFilename();
		  String contentType = fileData.getContentType();
		  long fileSize = fileData.getSize();
		/*
		  System.out.println("file Info");
		  System.out.println("fileName " + fileName);
		  System.out.println("originalFileName :" + originalFileName);
		  System.out.println("contentType :" + contentType);
		  System.out.println("fileSize :" + fileSize);
		*/
		  InputStream is = null;
		  OutputStream out = null;
		  try {
		   if (fileSize > 0) {
		    is = fileData.getInputStream();
		    File realUploadDir = new File(path);
		    if (!realUploadDir.exists()) {             //경로에 폴더가 존재하지 않으면 생성합니다.
		     realUploadDir.mkdirs();
		    }
		    out = new FileOutputStream(path +"/"+ fileName);
		    FileCopyUtils.copy(is, out);            //InputStream에서 온 파일을 outputStream으로 복사
		   }else{
		    new IOException("잘못된 파일을 업로드 하셨습니다.");
		   }
		  } catch (IOException e) {
		   e.printStackTrace();
		   new IOException("파일 업로드에 실패하였습니다.");
		  }finally{
		   if(out != null){out.close();}
		   if(is != null){is.close();}
		  }
		 }
//-------------------------------파일 업로드 소스 ---------------------------------	
	
	
	
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	 public String fileUpload(Model model, MultipartRequest multipartRequest) throws IOException{
	  MultipartFile file = multipartRequest.getFile("upload");   //뷰에서 form으로 넘어올 때 name에 적어준 이름입니다.
	  Calendar cal = Calendar.getInstance();
	  String fileName = file.getOriginalFilename();
	  String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
	  String replaceName = cal.getTimeInMillis() + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
	  
	  String path = "C:/Fileupload";   //제 바탕화면의 upload 폴더라는 경로입니다. 자신의 경로를 쓰세요.
	  MemberController.fileUpload(file, path, replaceName);
	  return "redirect:/";
	 }
	//-----------------------------------------
	
	
	
	@RequestMapping(value = "/memberjoin_j", method = RequestMethod.POST)
	public String memberjoin_j(Model model, MemberVo membervo, MultipartHttpServletRequest multipartRequest) throws Exception{
	
		
//		MemberController.fileUpload(fileData, path, fileName);
//		MultipartRequest multi=new MultipartRequest(model, "MS949",new DefaultFileRenamePolicy());
		
		if(!membervo.getId().equals(null) || !membervo.getId().equals("") ){
			System.out.println("upload 전");
			
			MultipartFile file = multipartRequest.getFile("upload");   //뷰에서 form으로 넘어올 때 name에 적어준 이름입니다.
			System.out.println("filePAth = " + file);
			System.out.println("upload 후");
			
			Calendar cal = Calendar.getInstance();
			String fileName = file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			String replaceName = cal.getTimeInMillis() + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			
			String path = "C:/Fileupload";   //제 바탕화면의 upload 폴더라는 경로입니다. 자신의 경로를 쓰세요.
			MemberController.fileUpload(file, path, replaceName);
			
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
