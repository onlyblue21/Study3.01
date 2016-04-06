package com.adminMember.service;

import java.util.List;
import java.util.Map;

import com.member.vo.MemberVo;


public interface AdminMemberService {
	
	public int countCheck(MemberVo membervo) throws Exception;
	//public List<MemberVo> memberList() throws Exception;
	public List<MemberVo> memberList(String type, String value) throws Exception;;
}
