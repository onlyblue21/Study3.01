package com.member.service;

import com.member.vo.MemberVo;

public interface MemberService {
	
	public int memberjoin(MemberVo membervo) throws Exception;
	
	public boolean Login(MemberVo membervo) throws Exception;
	
}
