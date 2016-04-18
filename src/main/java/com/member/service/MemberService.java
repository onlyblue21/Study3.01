package com.member.service;

import java.util.ArrayList;

import com.member.vo.MemberVo;

public interface MemberService {
	
	public int memberjoin(MemberVo membervo) throws Exception;
	
	public boolean Login(MemberVo membervo) throws Exception;
	
	public int memberphoto(MemberVo membervo) throws Exception;
	
	public ArrayList<MemberVo> ajaxseelct(String type, String value) throws Exception;
	
}
