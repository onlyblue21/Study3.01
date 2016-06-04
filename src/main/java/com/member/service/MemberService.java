package com.member.service;

import java.util.ArrayList;

import com.member.vo.MemberVo;

public interface MemberService {
	
	public int memberjoin(MemberVo membervo) throws Exception;
	
	public boolean Login(MemberVo membervo) throws Exception;
	
	public int memberphoto(MemberVo membervo) throws Exception;
	
	public ArrayList<MemberVo> ajaxseelct(String type, String value) throws Exception;
	
	public ArrayList<MemberVo> memberInfo(MemberVo membervo) throws Exception;
	
	public boolean checkId(String userId) throws Exception;
	
	public void memberUpdate(String userId) throws Exception;
}
