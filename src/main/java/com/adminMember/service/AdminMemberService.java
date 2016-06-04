package com.adminMember.service;

import java.util.List;

import com.member.vo.MemberVo;


public interface AdminMemberService {
	
	public int countCheck(String type, String value) throws Exception;
	//public List<MemberVo> memberList() throws Exception;
	
	public int getLastPage(String type, String value) throws Exception;
	
	public List<MemberVo> memberList(String type, String value, int page) throws Exception;

	public void deleteSvc(MemberVo memberVo) throws Exception;
	
}
