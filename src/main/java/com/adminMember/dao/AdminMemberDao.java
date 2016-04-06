package com.adminMember.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.member.vo.MemberVo;

@Repository("AdminMemberDao")
public class AdminMemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int CountCheck(MemberVo membervo) throws Exception{
		
		return sqlSession.selectOne("countCheck", membervo);
	}

/*	
	public List<MemberVo> memberList(){
		
		return sqlSession.selectList("memberList");
	
	}
*/
	
	public List<MemberVo> memberList(Map<String, String> param){
		return sqlSession.selectList("memberList", param);
	}
	
}
