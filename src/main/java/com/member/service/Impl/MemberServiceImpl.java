package com.member.service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public boolean Login(MemberVo membervo) throws Exception {
		return memberdao.Login(membervo);
	}
	
	@Override
	public int memberphoto(MemberVo membervo) throws Exception{
		return memberdao.memberphoto(membervo);
	}
	
	@Override
	public ArrayList<MemberVo> ajaxseelct(String type, String value) throws Exception {
		Map<String, String> key = new HashMap<String, String>();
		key.put("type", type);
		key.put("value", value);
		return memberdao.ajaxseelct(key);
	}

	@Override
	public ArrayList<MemberVo> memberInfo(MemberVo membervo) throws Exception{
		return memberdao.memberInfo(membervo);
	}
	
	@Override
	public boolean checkId(String userId) throws Exception{
		return memberdao.checkId(userId);
	}
	@Override
	public boolean memberLeave(MemberVo membervo) throws Exception{
		return memberdao.memberLeave(membervo);
	}
	
	@Override
	public void memberUpdate(String userId) throws Exception{
		memberdao.memberUpdate(userId);
	}
}
