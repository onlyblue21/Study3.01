package com.adminMember.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adminMember.dao.AdminMemberDao;
import com.adminMember.service.AdminMemberService;
import com.letter.vo.LetterVo;
import com.member.vo.MemberVo;

@Service("AdminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Autowired
	private AdminMemberDao adminmemberdao;
	
	@Override
	public int countCheck(MemberVo membervo) throws Exception {
		// TODO Auto-generated method stub
		return adminmemberdao.CountCheck(membervo);
	}
	
/*	
	@Override
	public List<MemberVo> memberList() throws Exception {
		return adminmemberdao.memberList();
	}
*/
	
	@Override
	public List<MemberVo> memberList(String type, String value) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> param = new HashMap<String, String>();
		param.put("type", type);
		param.put("value", value);
		return adminmemberdao.memberList(param);
	}
}
