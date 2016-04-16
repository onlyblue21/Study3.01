package com.member.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;

import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

public class FileUpload {


	
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
//		  MemberController.fileUpload(file, path, replaceName);
		  return "redirect:/";
		 }
		//-----------------------------------------
		
		
	
	
}
