package com.adminMember.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adminMember.dao.AdminMemberDao;
import com.adminMember.service.AdminMemberService;
import com.member.vo.MemberVo;
import com.adminMember.util.PageNavigator;

@Service("AdminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService{
	
	private final int LINE_PER_PAGE = 5;
	
	@Autowired
	private AdminMemberDao adminmemberdao;
	
	@Override
	public int countCheck(String type, String value) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> param = new HashMap<String, String>();
		param.put("type", type);
		param.put("value", value);
		return adminmemberdao.CountCheck(param);
	}
	
/*	
	@Override
	public List<MemberVo> memberList() throws Exception {
		return adminmemberdao.memberList();
	}
*/
	
	@Override
	public int getLastPage(String type, String value) throws Exception{
		Map<String, String> param = new HashMap<String, String>();
		param.put("type", type);
		param.put("value", value);
		return (int)(Math.ceil((double)adminmemberdao.CountCheck(param)/LINE_PER_PAGE));
	}
	
	@Override
	public List<MemberVo> memberList(String type, String value, int page) throws Exception {
		// TODO Auto-generated method stub
		
		PageNavigator pageNavigator = new PageNavigator(page, LINE_PER_PAGE);
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("type", type);
		param.put("value", value);
		param.put("pageNavigator", pageNavigator);
		
		return adminmemberdao.memberList(param);
	}

    /**
     * 회원 탈퇴
     *
     * @param memberVo {@link MemberVo}
     */
	@Override
	public void deleteSvc(MemberVo memberVo) throws Exception {
		// TODO Auto-generated method stub
        	adminmemberdao.deleteSeq(memberVo.getMember_seq());
	
	}
	
	
}
