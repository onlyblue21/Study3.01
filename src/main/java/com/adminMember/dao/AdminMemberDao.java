package com.adminMember.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.apache.ibatis.session.RowBounds;


import com.member.vo.MemberVo;

@Repository("AdminMemberDao")
public class AdminMemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int CountCheck(Map<String, String> param) throws Exception{
		return sqlSession.selectOne("countCheck", param);
	}

/*	
	public List<MemberVo> memberList(){
		
		return sqlSession.selectList("memberList");
	
	}
*/
	
	public List<MemberVo> memberList(Map<String, Object> param){
		
		return sqlSession.selectList("memberList", param);
		
		
	}
	
}
