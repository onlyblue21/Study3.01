package com.member.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.dao.MemberDao;
import com.member.service.MemberService;
import com.member.vo.MemberVo;

@Service("MemberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao memberdao;
	
	@Override
	public int memberjoin(MemberVo membervo) throws Exception{
		
		return memberdao.memberjoin(membervo);
	}
	
}
